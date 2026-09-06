# Invariants, Transactions, and Concurrency

Use this module when choosing enforcement or explaining a concurrent correctness failure. Start with a permitted outcome and a forbidden history, then map them to the selected engine.

## Define the Conflict Scope

Record the business rule in terms of stored facts: required values, identity, allowed relationships, nonnegative quantities, mutually exclusive reservations, or aggregate limits. Identify every writer, including imports, administrative tools, background jobs, and retries.

Distinguish:

- Atomicity: which effects commit or abort together.
- Integrity: which application rule and database constraints must hold.
- Isolation: which overlapping histories are allowed.
- Durability: which acknowledged changes survive the named failures.

An application validation check improves error reporting but does not enforce a concurrent invariant unless the read and conflicting writes meet in a mechanism that excludes the bad history.

| Rule shape | Candidate mechanism | Failure to check |
| --- | --- | --- |
| Required or row-local value | Nullability and row constraint | Null passes a nullable predicate; a function depends on mutable external state |
| Identity or duplicate operation | Unique/primary-key constraint in the correct scope | Application checks absence before insertion; identity omits tenant or operation scope |
| At most one row satisfying a condition per group | Eligible partial unique index | Uniqueness excludes duplicates but does not require a matching row to exist; exactly-one also needs existence enforcement |
| Relationship existence | Foreign key with deliberate null and deletion semantics | Optional relationship is accidentally accepted; parent deletion has unintended effects |
| Operator-defined conflict, such as overlapping intervals | Engine-supported exclusion constraint | Operators, boundary semantics, or required engine support do not represent the rule |
| Single-row conditional transition | Atomic conditional mutation, possibly with a row constraint | Application reads a value, computes outside protection, then overwrites a newer value |
| Multirow or absence-based decision | Serializable execution, suitable constraint, or complete lock protocol | Transactions change different rows; an empty result leaves nothing row-locked |
| Multiple authoritative systems | Architectural coordination or explicit compensation | Local commit is mistaken for an atomic external effect |

The system/domain owner chooses the rule and any accepted compensation. Database work must not silently weaken it to make concurrency easier.

## Build an Anomaly History

Use transaction boundaries and actual statement ordering, not an isolation label alone.

| Observation | Minimal history to investigate | Evidence that distinguishes it |
| --- | --- | --- |
| Dirty observation | A reads B's uncommitted state; B aborts | Connection separation, journal/isolation settings, commit sequence |
| Read skew or nonrepeatable read | A reads related facts across B's commit | Snapshot boundary of each statement and transaction |
| Lost application update | A and B read the same value, compute replacements, and overwrite | Actual SQL: replacement from stale state versus an atomic conditional update |
| Phantom or predicate change | A repeats a range/absence query after B changes matching rows | Engine snapshot semantics and whether the rule depends on deciding and writing |
| Write skew | A and B read the same rule, update different rows, and both commit | Read predicates, disjoint writes, missing conflict mechanism |

A phantom-free snapshot can still permit write skew. Reading a consistent version and excluding incompatible decisions are different obligations.

### Example: Two Remaining On-Call Staff

Assume the domain rule requires at least one on-call person.

| Step | Transaction A | Transaction B |
| --- | --- | --- |
| Read | Observes both A and B on call | Observes both A and B on call |
| Decide | B remains, so A may leave | A remains, so B may leave |
| Write | Marks A off call | Marks B off call |
| Commit under an insufficient snapshot mechanism | Commits its row | Commits its different row |

Each transaction was locally reasonable; the final state violates the rule. A row-local check on each person's status cannot express the aggregate.

Possible repairs have different obligations:

- Serializable execution must cover the complete read/decide/write transaction and handle aborts by rereading and retrying the entire operation.
- A guard-row protocol must use an existing row for the conflict scope, and every relevant writer must acquire it before making the decision. In PostgreSQL Read Committed, acquire the guard before the subsequent predicate read; do not assume waiting refreshes an already established Repeatable Read snapshot.
- A directly representable constraint can move the decision into engine enforcement. Confirm that the model still expresses the domain rule.

Locking only rows returned by an absence query does not protect the missing row. PostgreSQL SSI predicate tracking is not a general-purpose blocking range-lock API.

## Choose Blocking or Abort Costs Deliberately

Locks trade concurrent progress for waiting and possible deadlocks. Optimistic/serialization checks trade some completed work for abort and retry. Serial or single-writer execution limits simultaneous write progress; two-phase locking carries wait/deadlock costs; SSI carries dependency tracking and abort costs. Compare transaction duration, hot conflict sets, tail latency, and useful completed operations under contention.

Serializability constrains transaction ordering; it does not by itself guarantee real-time recency or read-your-writes across replicas. Pass that freshness requirement to the system owner.

For a lock protocol, specify:

- The complete set of conflicting resources, including inserts and administrative writers.
- Acquisition order and mode, and when the lock is released.
- Whether reads after waiting use a valid view for the decision.
- What the caller does on deadlock, timeout, cancellation, or failed acquisition.

Keep transactions bounded and avoid holding them across user input or unnecessary remote work. A session-owned advisory lock needs ownership across pooling and error cleanup; a transaction-owned lock has a simpler release boundary.

## Retry the Decision, Not Just the Statement

After a serialization or write-conflict abort, discard the transaction's decisions and reread on a new transaction. Retrying only the last write can reuse an invalid premise. Include the commit operation in retry handling because failure can be discovered there.

Classify errors before retrying:

- A confirmed transient concurrency abort can be retried within the operation's deadline and attempt budget.
- A constraint rejection usually needs a domain response or explicit conflict resolution; repeating the same invalid write indefinitely is ineffective.
- A lost connection during commit can leave the outcome unknown. Determine the durable outcome using the operation identity where the design supports it; do not interpret a timeout as proof of rollback.

Keep external effects outside an assumed database rollback boundary. The backend owns session cleanup and application retry code. The system owner supplies outbox, external idempotency, or reconciliation semantics when the operation crosses systems.

## Diagnose the Failed Control

| Symptom | Evidence to collect | Action indicated by that evidence |
| --- | --- | --- |
| Application checks pass but committed data violates the rule | Actual isolation, complete writer set, and interleaved read/decide/write history | Close the conflict gap with a representable constraint or complete serialization/lock protocol |
| Serialization aborts grow | Transaction duration, hot conflict scope, retry timing and reused decisions | Reduce avoidable overlap and bound retries with jitter where useful; preserve the invariant when considering a different mechanism |
| Declared constraint coexists with bad historical rows | Definition, null policy, validation state, and violation query | Distinguish unenforced semantics from unvalidated history; agree on repair before enabling the intended rule |
| Parent deletion is unexpectedly slow | Referencing-side access path and observed scan work | Evaluate a child-side index against the whole workload |

If corruption already exists, quantify and preserve the violating rows and their meaning. Repair or quarantine is a domain decision; a newly declared constraint does not retroactively prove existing data valid.

## Verify the Forbidden History

Use separate connections and controlled interleavings to exercise the conflict. Check the committed final state and caller-visible outcome, including an abort followed by retry. A sequential test cannot establish a concurrent invariant.

For a material concurrency change, include the failure class actually addressed: simultaneous insert, stale update, disjoint-row decision, empty predicate, deadlock, or response lost after commit. Use the real target engine when behavior depends on its isolation or constraints.

Compare invariant violations, abort/deadlock rate, lock-wait duration, retry attempts, completed throughput, and tail latency under representative conflicts. No universal acceptable abort percentage follows from the isolation level.

## Sources and Scope

Architectural basis: *Designing Data-Intensive Applications*, second edition, Transactions; The Trouble with Distributed Systems; and verification/auditability discussions in Doing the Right Thing. These support anomaly-based reasoning and end-to-end verification, not command syntax.

For PostgreSQL behavior, use [PostgreSQL 18 Transaction Isolation](https://www.postgresql.org/docs/18/transaction-iso.html) and [Explicit Locking](https://www.postgresql.org/docs/18/explicit-locking.html). For SQLite connection and snapshot behavior, use [Isolation in SQLite](https://sqlite.org/isolation.html). Apply the engine-specific companion reference before choosing an executable remedy.
