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

## Source Of Truth And Derived Data

- Assign one authoritative owner for each datum or invariant.
- Treat caches, indexes, search views, replicas, aggregates, and exports as derived unless explicitly authoritative.
- Define how derived data is built, versioned, refreshed, reconciled, and rebuilt.
- Make lineage clear enough to answer where a value came from and which update should win.
- Avoid active-active ownership of the same invariant unless conflict resolution is a deliberate domain rule.

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
- Serializable execution where concurrent operations must preserve a global invariant.

During a network partition, state which operations remain available and which reject or delay work to preserve correctness. Do not describe consistency only with a database label; define user-visible behavior.

Keep invariants within one transactional boundary when practical. For workflows across boundaries:

- Model explicit states and compensating actions.
- Persist intent before emitting side effects.
- Use an outbox or equivalent atomic handoff from transaction to message publication.
- Make handlers idempotent and record processed identities when duplicates are harmful.
- Reconcile periodically from the source of truth.
- Expose pending, failed, and compensated states instead of pretending the workflow is atomic.

## Replication

- Replication improves availability and read capacity but adds lag, conflict, failover, and cost.
- State leader, quorum, or conflict-resolution behavior and how clients find the current authority.
- Define read routing and whether stale replicas are allowed for each operation.
- Account for replication lag in user flows, tests, caches, and failover.
- Test failover and failback. Promotion without a safe return path is only half a design.
- Model correlated failure across zones, regions, control planes, credentials, and deployments.

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
