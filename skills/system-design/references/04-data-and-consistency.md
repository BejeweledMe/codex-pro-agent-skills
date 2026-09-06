# Data And Consistency

## Start With Data Behavior

Before choosing storage, write down:

- Entities, relationships, cardinality, and ownership.
- Read and write access patterns, filters, sort order, joins, and aggregates.
- Read/write ratio, payload size, growth, retention, and hot-key risk.
- Required transaction boundary and correctness invariants.
- Acceptable staleness, conflict behavior, and durability.
- Query flexibility, schema evolution, export, deletion, and audit needs.

Pick storage for the dominant access patterns and guarantees. Do not make one store serve unrelated search, transactional, analytical, blob, and cache workloads merely to reduce the box count. Conversely, do not add specialized stores until their value exceeds synchronization and operational cost.

Keep the architectural workload and required guarantee here. Use
`$database-engineering` for the chosen engine's constraint, isolation, lock,
query-plan, index, DDL, and restore evidence. An isolated slow-query investigation
does not require a new distributed architecture.

## Source Of Truth And Derived Data

- Assign one authoritative owner for each datum or invariant.
- Treat caches, indexes, search views, replicas, aggregates, and exports as derived unless explicitly authoritative.
- Define how derived data is built, versioned, refreshed, reconciled, and rebuilt.
- Make lineage clear enough to answer where a value came from and which update should win.
- Avoid active-active ownership of the same invariant unless conflict resolution is a deliberate domain rule.

For a rebuildable view, name the required source facts or usable snapshot plus
subsequent history, derivation/configuration versions, and historical reference
data. Specify whether consumers may observe incremental updates or require a
complete published version. For the latter, build separately and switch through
a version/readiness boundary; parallel per-record writes alone do not provide
atomic dataset publication.

Rebuildability ends when required history or interpretation is lost. A cache or
index label does not establish it, and losing the source does not make a derived
copy a trustworthy authority automatically.

Separate freshness targets from integrity checks for missing, duplicate,
contradictory, or incorrectly derived results. Define how corrections and
deletions reach derived copies and survive rebuild or rollback. Distinguish
serving suppression from physical deletion in retained history and backups;
a tombstone alone does not prove erasure.

System design chooses authority and the consumer promise. `$data-engineering`
owns maintained transformations and publication/replay execution. Pass source
authority, snapshot/log position, ordering and retention, schema/derivation
versions, effect boundaries, and rebuild/deletion obligations.

## Storage Choice By Need

- Relational storage fits transactions, constraints, relationships, and flexible querying.
- Key-value storage fits direct lookup by stable key and predictable access paths.
- Document storage fits aggregate-shaped records with evolving fields when cross-document transactions are limited.
- Wide-column or partition-oriented storage fits very high scale with known partition and query patterns.
- Search indexes fit text relevance, faceting, and inverted-index queries; usually keep an authoritative source elsewhere.
- Object storage fits large immutable or versioned blobs with metadata indexed separately.
- Time-series storage fits append-heavy timestamped measurements with retention and aggregation policies.

These are capability categories, not vendor recommendations. A specific product may span categories with different guarantees and limits.

## Consistency And Transactions

Choose guarantees per operation:

- Strong read-after-write where a user must immediately observe their committed change.
- Monotonic reads where state must not appear to move backward.
- Consistent prefix or ordered processing where causality matters.
- Bounded staleness where delay is acceptable but must have a limit.
- Eventual convergence where temporary disagreement is harmless and conflicts are resolvable.
- Serializable execution over the relevant transaction scope where concurrent operations could otherwise violate an invariant.

During a network partition, state which operations remain available and which reject or delay work to preserve correctness. Do not describe consistency only with a database label; define user-visible behavior.

Read-your-writes and monotonic reads are session guarantees; they do not establish
global linearizability. Serializability constrains concurrent transaction
histories; it does not automatically provide real-time recency or enforce an
unstated business rule. Specify prohibited anomalies and participating writers,
then obtain engine-specific evidence.

A stable snapshot can still permit write skew when transactions read a predicate
and update different rows. Locking only returned rows may leave an empty
predicate unprotected. Choose an actual constraint or concurrency mechanism that
covers the conflict; do not infer protection from an isolation label. See
[distributed-guarantees-and-recovery.md](distributed-guarantees-and-recovery.md)
for isolation, real-time order, atomic commit, and consensus distinctions.

Keep invariants within one transactional boundary when practical. For workflows across boundaries:

- Model explicit states and compensating actions.
- Persist intent before emitting side effects.
- Use an outbox or equivalent mechanism to commit publication intent atomically with domain state, then recover and retry the publication separately.
- Make handlers idempotent and record processed identities when duplicates are harmful.
- Reconcile periodically from the source of truth.
- Expose pending, failed, and compensated states instead of pretending the workflow is atomic.

Choose the integration mechanism by authority and purpose:

| Mechanism | Architectural use | Remaining obligation |
| --- | --- | --- |
| Transactional outbox | Commit domain state and an intended external event in one local transaction | Extra write/translation cost, relay recovery, duplicate delivery, consumer idempotency, and external-effect reconciliation |
| Change data capture | Keep an existing database authoritative while propagating committed changes | Snapshot/log bootstrap, exposed schema, ordering, retention, and consumer recovery |
| Event sourcing | Make semantic domain facts the authoritative history | Long-lived event meaning, reproducible replay, side-effect isolation, and retention/deletion design |

These mechanisms can compose: CDC can publish an outbox. An outbox does not make
the destination effect atomic with the source transaction. CDC needs a deliberate
downstream contract if consumers should be insulated from internal schema changes.
A compacted current-state log is not necessarily sufficient domain history for
replay.

## Replication

- Replication improves availability and read capacity but adds lag, conflict, failover, and cost.
- State leader, quorum, or conflict-resolution behavior and how clients find the current authority.
- Define read routing and whether stale replicas are allowed for each operation.
- Account for replication lag in user flows, tests, caches, and failover.
- Test failover and failback. Promotion without a safe return path is only half a design.
- Model correlated failure across zones, regions, control planes, credentials, and deployments.

Tie acknowledgment to the copies and durable history required before reporting
success. Promotion needs an eligibility rule for that history, stale-writer
exclusion, routing changes, and safe reintegration. Choosing the freshest
available asynchronous replica can reduce loss without guaranteeing that every
acknowledged write survives.

Require read-path evidence for promised freshness: the enforced session/version
token, log position, or equivalent routing/read protocol. Replica count alone
does not establish read-your-writes. Last-writer-wins can converge while
discarding an accepted concurrent write; wall-clock ordering does not establish
causality or the right domain conflict policy.

If recovery discards previously accepted history, inspect downstream records,
identities, and external effects that may still reflect it. They do not roll back
automatically with the database. State the changed data-loss guarantee and
reconciliation obligation.

Replication also propagates accidental deletion and corruption. Preserve
independent historical recovery and restore validation; replica count is not
backup evidence. Use
[distributed-guarantees-and-recovery.md](distributed-guarantees-and-recovery.md)
for quorum, fencing, and authority-transition checks.

## Partitioning And Sharding

Choose a partition key that supports dominant queries, spreads load and storage, and has enough cardinality. Check:

- Hot tenants, celebrities, current-time partitions, and sequential keys.
- Cross-partition queries and transactions.
- Secondary index placement and fan-out.
- Rebalancing, split, merge, and resharding behavior.
- Routing metadata availability and consistency.
- Backup, restore, and migration per shard.
- Tenant movement and isolation requirements.

Prefer logical partitioning before physical sharding when current scale does not require operational distribution. If sharding is necessary, design rebalancing before the first shard fills.

Distinguish a demonstrated capacity, write, or geography need from read scaling
that replicas, caching, or query improvement may satisfy. Uniform key
distribution does not imply uniform traffic. Hashing a tenant key cannot split
one exceptionally hot tenant; salting spreads work at the cost of read fan-out
and potentially harder transaction coordination.

Routing and rebalancing must preserve ownership during copy, catch-up, cutover,
and retirement. Define the authoritative map/version, in-flight request handling,
stale-owner exclusion, throttles, and recovery state. A split competes with live
traffic; measure headroom and provide pause/resume behavior instead of assuming
an overloaded shard can absorb migration work.

Shard-local secondary indexes usually keep index maintenance near each shard
but scatter lookups that lack the shard key. A global index improves those
lookups while adding cross-shard update coordination or asynchronous propagation
and repair. Include its freshness, failure, and rebuild cost in the choice.

## Indexes And Data Lifecycle

- Derive indexes from query shapes and sort order.
- Treat every index as write amplification, storage, and migration cost.
- Avoid unbounded scans and unbounded result sets; require pagination with stable ordering.
- Define retention, archival, legal hold, deletion, tombstone, and backup behavior.
- Test restores, not only backup creation.
- Use expand-and-contract schema changes: add compatible shape, backfill, switch readers and writers, verify, then remove old shape.

## Review Questions

- Which invariant owns the transaction boundary?
- What is authoritative and what is derived?
- What does a user observe after a write, during lag, and after conflict?
- Can retries duplicate money, inventory, notifications, or external side effects?
- What is the worst partition or hot-key shape?
- How are reconciliation, rebuild, restore, reshard, and deletion validated?
