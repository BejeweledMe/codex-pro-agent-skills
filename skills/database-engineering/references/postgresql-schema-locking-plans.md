# PostgreSQL Schema, Locking, and Plans

This module describes PostgreSQL 18 semantics. Identify the installed version, transaction settings, schema, and exact statements before using it to justify a change.

## Constraints Encode Different Rules

| Mechanism | What it establishes | What to inspect |
| --- | --- | --- |
| `NOT NULL` | A value must be present | Whether absence has domain meaning and existing rows satisfy the rule |
| `CHECK` | A row-local predicate must evaluate true or null | Add explicit nullability where needed; avoid dependencies on other rows or mutable function behavior |
| `UNIQUE` | Equality-based uniqueness | Key scope and null policy; nulls are distinct by default in PostgreSQL 18 |
| Primary key | Unique, non-null identity | Identity stability and referencing relationships |
| Foreign key | A declared relationship to an eligible unique referenced key | Optionality, multicolumn null behavior, parent lifetime, and lookup cost |
| Exclusion constraint | Prohibited combinations defined through supported operators | Whether equality, range boundaries, and conflict operators express the actual rule |

PostgreSQL assumes `CHECK` expressions are immutable for a given row. A check that queries another table can appear to work while failing to maintain integrity and causing dump/restore trouble. Changing a function used by a constraint requires considering existing rows and revalidation, not just future writes.

Unique and primary-key constraints create unique B-tree indexes. Avoid adding a duplicate physical index for the same access purpose. PostgreSQL 18 supports explicit `NULLS NOT DISTINCT` uniqueness semantics; choose it only when nulls should conflict.

The referenced side of a foreign key needs eligible uniqueness. PostgreSQL does not automatically index the referencing columns. Examine parent deletes/updates, child lookup patterns, and write cost before adding that index.

Deletion actions express object lifetime. `CASCADE`, `SET NULL`, and `SET DEFAULT` must agree with domain behavior and other constraints. `NO ACTION` checking can be deferred when the constraint is configured accordingly; `RESTRICT` cannot be deferred. Nullable multicolumn keys need deliberate matching semantics. Check exact deferral syntax and timing before using them in a migration or transaction.

Use [safe schema change](safe-schema-change.md) when installing or changing enforcement on existing data.

## PostgreSQL Isolation Behavior

| Requested level | PostgreSQL 18 behavior | Application obligation |
| --- | --- | --- |
| Read Uncommitted | Behaves as Read Committed | Do not infer dirty-read behavior from the label |
| Read Committed | A new snapshot for each statement, plus the transaction's own writes | Multiple reads can observe different committed states; examine read/modify patterns |
| Repeatable Read | Transaction snapshot, including prevention of read phantoms | Snapshot consistency does not exclude write skew; write conflicts can require whole-transaction retry |
| Serializable | Serializable Snapshot Isolation detects incompatible dependency patterns | Handle serialization failures, including at commit, and retry the complete transaction |

At Read Committed, an updating or locking command can wait for a conflicting transaction and then reevaluate its condition against an updated row version. Diagnose the actual statement and dependency pattern; do not classify every race as a lost update.

Serializable failures use SQLSTATE `40001`. Do not expose tentative results or irreversible effects as final before successful commit. Specialized read-only deferrable safe snapshots have additional conditions; verify them before relying on that exception.

SSI predicate locks track dependencies and do not themselves block. Ordinary row and table locks used within a Serializable transaction can still wait or deadlock.

## Diagnose Locks Through Conflicts and Duration

Among PostgreSQL table-lock modes, only `ACCESS EXCLUSIVE` conflicts with the `ACCESS SHARE` lock taken by an ordinary `SELECT`. Modes with “row” in their name can still be table locks. Row locks block conflicting writers and lockers, while ordinary MVCC readers can usually continue.

For blocking:

1. Identify the waiting statement and the transaction holding the conflicting lock.
2. Record transaction age, current/previous work, lock resource and mode, acquisition order, and whether a transaction is idle while retaining locks.
3. Follow the blocking chain to its root. A slow waiter is not necessarily the expensive or defective operation.
4. Choose the smallest correction: finish unnecessary transaction scope, repair resource order, reduce batch duration, or revise the operation's lock strategy.
5. Recheck wait duration and throughput under the same conflict, including DDL competing with ordinary traffic.

Use consistent acquisition order and obtain the most restrictive mode that will actually be needed first, avoiding avoidable upgrades. PostgreSQL chooses a deadlock victim without a predictable application preference; handle an aborted transaction accordingly. `SELECT FOR UPDATE` can itself cause disk writes to mark locked rows.

Advisory locks protect only participants following the same protocol. Transaction-level locks release at transaction end. Session-level locks survive transaction rollback and require explicit release and pool lifecycle ownership. Advisory locks also consume shared lock capacity.

Do not invoke an advisory-lock function across an unbounded row set and assume `LIMIT` restricts evaluation. Form the bounded candidate set before applying the locking function, using the documented evaluation-safe shape.

Exact DDL lock modes, timeout settings, advisory function signatures, and `NOWAIT`/`SKIP LOCKED` semantics require the target-version references. Skipping work also changes the query contract; it needs an application decision.

## Gather a Useful Plan

Capture the SQL actually sent, bind values or representative distributions, bind types, table/index definitions, row counts and skew, settings affecting planning, and observed application latency.

Plain `EXPLAIN` reports estimates. `EXPLAIN ANALYZE` executes the statement, adding measurement overhead and potentially material work. Prefer a representative isolated environment when execution can write, invoke effects, acquire disruptive locks, or load the service.

A transaction followed by rollback can undo ordinary transactional DML, but is not blanket protection against every invoked effect or operational impact. Account for sequences, functions, triggers, external integrations, and load before treating a measurement as reversible.

Read the plan as a tree:

- Costs are planner units, not milliseconds.
- Estimated `rows` means emitted rows, not necessarily inspected rows.
- Actual rows and time for repeated nodes are per-loop averages. Use loops to understand repeated work; do not sum inclusive parent and child timings as independent costs.
- `Index Cond` identifies index-level conditions. Relate those conditions to key order and scan bounds; its presence alone does not establish a short leaf walk.
- Filters remove candidates after earlier work. Inspect rows removed, rechecks, and where table fetches happen.
- Buffers, sort disk use, hash batches, and heap fetches help identify work. They do not independently prove one root cause.

## Evidence to Action

| Finding | Competing explanations | Discriminating action |
| --- | --- | --- |
| Estimated and actual rows diverge | Stale or inadequate statistics, skew, correlation, parameter sensitivity | Inspect distribution and planning context; compare representative values before changing statistics or SQL |
| Few results after a broad index scan | Weak leading restriction, residual predicates, poor locality | Trace access bounds and discarded candidates; compare a different predicate/index shape |
| Cheap inner operation repeated many times | Large outer result, estimate error, repeated probes | Inspect outer cardinality and the join contract before tuning the inner node |
| Sort or hash spills | Too many rows, wide projections, estimates, memory competition | Reduce avoidable input/width first; assess concurrent memory cost before changing settings |
| Index-only plan has heap fetches | Visibility state and recently modified pages | Correlate writes and visibility/maintenance evidence; do not declare vacuum failure from the counter alone |
| Plan execution is fast but endpoint is slow | Query count, pool/lock waits, result transfer, application processing | Trace the surrounding request and generated SQL with the backend owner |

Where available, `Index Searches` distinguishes repeated B-tree searches from one traversal; PostgreSQL 18 documents skip-scan examples. Relate searches to buffers and predicate shape instead of treating ordinary leading-prefix reasoning as an absolute optimizer restriction.

`LIMIT` can stop a child early while its estimates describe full execution. Merge joins can rescan inner rows. Some plan fields, including bitmap-node actual-row reporting, have implementation limitations. Interpret surprising counters with the matching version's manual.

After correcting the identified mechanism, compare result correctness, representative parameter slices, actual work, application latency, and concurrent writes. Keep [index economics](sql-access-paths-and-index-economics.md) in scope when a physical index changes.

## Sources and Refresh Limits

- [PostgreSQL 18 Constraints](https://www.postgresql.org/docs/18/ddl-constraints.html): check/null semantics, identity, foreign keys, and exclusion.
- [PostgreSQL 18 Transaction Isolation](https://www.postgresql.org/docs/18/transaction-iso.html): snapshots, SSI, and retry behavior.
- [PostgreSQL 18 Explicit Locking](https://www.postgresql.org/docs/18/explicit-locking.html): conflict sets, deadlocks, advisory lifecycle, and evaluation hazards.
- [PostgreSQL 18 Using EXPLAIN](https://www.postgresql.org/docs/18/using-explain.html): plan fields, execution effects, and interpretation caveats.

Refresh exact command references for online DDL, lock/timeouts, index operator classes, planner statistics internals, and monitoring-query syntax. General access-path reasoning is developed separately and does not establish those version-specific capabilities.
