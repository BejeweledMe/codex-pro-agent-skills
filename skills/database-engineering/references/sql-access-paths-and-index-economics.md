# SQL Access Paths and Index Economics

Use this module to explain physical SQL work and choose a measured query or index change. B-tree reasoning transfers across engines; expression matching, null treatment, covering, skip strategies, plan caching, and online DDL require target-engine evidence.

## Start With the Emitted Query

Capture predicates and types, joins, projection, ordering, grouping, limit, pagination contract, bind distribution, and query count per application operation. Include representative common values, rare values, hot tenants, and empty results where they materially change work.

An indexed lookup can perform three very different amounts of work:

1. Descend the tree to the first candidate leaf.
2. Walk a candidate leaf range and evaluate index-level conditions.
3. Fetch base-table rows, unless the engine can satisfy the statement without them.

The expensive part is often the range walk or table fetch. A small result does not imply little work. A sequential scan can be cheaper than a broad index range with scattered table fetches.

Separate access predicates that bound traversal from index filters and filters applied after table access. Use available plan counters and measurements; do not invent an exact scanned-entry count when the engine does not expose it.

## Composite Order Is a Workload Decision

An index on `(tenant_id, status, created_at, id)` has lexicographic order. With equality on tenant and status, a range on creation time can follow a contiguous ordered region. Omitting a leading restriction can scatter the desired values across that region's predecessors.

For ordinary B-tree access:

- Leading equalities usually narrow the region before a range.
- A condition on a later key may filter candidates without tightly bounding the scan.
- A leading equality can preserve ordering by subsequent keys.
- A leading range usually does not provide global order by a later key alone.

These are access-path foundations, not claims that every modern optimizer is restricted to one seek strategy. Verify any skip-scan, bitmap combination, or other alternative in the actual plan.

Do not order columns solely by “most selective first.” Consider which prefixes the workload supplies, ordering and grouping, range placement, join probes, and uniqueness. Reordering a unique key can preserve its logical uniqueness while changing which queries use it and how efficiently.

Before replacing a prefix index with a wider one, compare size, locality, constraint dependencies, and plans for all important consumers. Logical prefix coverage alone does not establish equal cost.

## Repair Predicate Shape Without Changing Meaning

| Predicate issue | Candidate repair | Semantic check |
| --- | --- | --- |
| Function or formatting on a stored timestamp | Half-open raw-column interval: start inclusive, next boundary exclusive | Time zone, calendar boundary, column type, and precision |
| Cast on the indexed column | Bind the correct type or transform the search value where valid | Dirty data, rounding, collation, numeric-string identity, and cast direction |
| Case normalization inherent to the query | Expression index or generated representation if supported | Stable normalization semantics and optimizer recognition |
| Optional-filter expression hides active predicates | Generate the active query structure and bind values | Preserve null behavior and validate allowed structural choices |
| Arithmetic or concatenation hides the key | Equivalent raw-key predicates where available | Overflow, null propagation, formatting, and equality semantics |

Expression indexes and generated columns need stable semantics, eligible functions, matching query expressions, useful statistics, and accepted write/storage cost. Declaring a time-, locale-, session-, or external-state-dependent function deterministic does not make its indexed results correct.

Bind values by default. When skew or parameter-sensitive plans cause a measured problem, compare controlled specialization with generic planning. Keep runtime values bound even when query structure varies. Allow-list structural identifiers/operators in the application; values and SQL structure are different inputs.

A partial index can serve a small, stable, frequently accessed subset such as pending work. The query must imply its predicate in a form the optimizer can prove. Check parameterization and predicate eligibility on the target engine before relying on it.

Null storage, null ordering, and uniqueness differ between engines. Do not transfer Oracle all-null-key behavior to PostgreSQL or SQLite.

## Table Fetches, Covering, and Locality

Adjacent index entries can point to distant table pages. If table fetch dominates, compare a tighter range, narrower projection, better locality, or a covering path.

Covering is a statement/plan property. An index needs the values used by the statement, and the engine must be able to avoid base-row access. PostgreSQL index-only execution also depends on visibility information; merely adding projected columns cannot guarantee zero heap fetches.

Adding a projected column can remove index-only eligibility. Inspect `SELECT *`, hidden ORM fields, and later projection growth before widening an index. Include-column and key-width limits are engine-specific.

Heap and clustered/index-organized storage have different primary and secondary lookup costs. Do not assume a PostgreSQL primary-key index means rows remain physically clustered by that key. Some engines offer truncated-value prefix indexes; these do not preserve the full value and can limit covering or uniqueness. Distinguish that feature from the leading columns of a composite index.

## Join and Aggregation Work

| Physical operation | Index opportunity | Common wrong conclusion |
| --- | --- | --- |
| Nested loop | Small driving result and cheap, selective inner probes | Indexing the inner key solves an unexpectedly huge outer result |
| Hash join | Reduce input rows and bytes before build/probe; a different access path may change the chosen plan | A B-tree on the join key accelerates the hash probe itself |
| Merge join | Supply compatible ordering or reduce sorting/input size | Two indexes guarantee the merge plan is cheaper |
| Ordered grouping | Supply useful input order where the engine can exploit it | `GROUP BY` syntax guarantees a streaming physical implementation |
| Hash aggregation | Reduce groups/input width and understand memory/spills | Row count alone predicts memory demand |

Estimate errors can change join order and algorithms. Find where the plan first accumulates unexpectedly large work before forcing a later operator.

N+1 application queries combine repeated probes with round trips. Inspect actual SQL, binds, query count, and result shape with the backend owner. Set-oriented loading can reduce round trips, but a fetch join can multiply rows, overfetch, or introduce a costly `DISTINCT`. Compare the full operation.

## Ordering, Top-N, and Pagination

Declare the desired limit in SQL so the optimizer can consider early termination or a bounded sort. Closing a client cursor early does not communicate the same optimization opportunity.

Check the order of the scanned range, including equality prefixes, direction, null ordering, and a unique tie-breaker. Reverse scanning and mixed directions depend on engine support and the actual plan.

Use keyset pagination for sequential deep browsing when its product trade-offs fit:

- Encode the last-seen ordering key and a unique tie-breaker.
- Match the continuation predicate to the complete ordering, including null handling.
- Verify that the predicate becomes effective access bounds rather than a large residual filter.
- Document that arbitrary page-number jumps are not directly available.

Keyset pagination avoids repeatedly paying for all skipped rows, but does not provide a consistent snapshot across requests. Deletes, sort-key updates, or new rows can change observations. Define the product's acceptable behavior and isolation/lifetime costs if a fixed view is needed.

Offset pagination remains reasonable for shallow pages or explicit arbitrary jumps when measured cost is acceptable. Window-function pagination does not guarantee early termination; inspect the target plan.

## Price the Index Across the Workload

Every maintained index consumes write work, storage, cache, and future migration capacity. Insert, delete, and update costs include more than locating the target row; MVCC cleanup and engine-specific update behavior can move work to later maintenance.

Do not estimate index maintenance solely from the number of logically changed key values. Storage-engine rules determine when entries must be created, removed, or cleaned up.

For an index addition, removal, reorder, or widening:

1. Record the query family it should improve and the physical work expected to fall.
2. Identify constraints and other query families using the existing indexes.
3. Compare representative before/after results, rows/bytes inspected, fetches, spills, and end-to-end latency.
4. Measure concurrent writes, storage/cache effects, maintenance load, and plans elsewhere.
5. Retain or revert based on the combined workload and the agreed read/write priorities.

Adding an index can cause the optimizer to select a worse path for another query. Keep a fallback for the changed schema and account for the lock/build work required to restore a removed index.

Bulk-load index drop/rebuild is conditional: establish constraint coverage, reader requirements, rebuild capacity, logging/replication implications, and recovery. `TRUNCATE` has its own transaction, trigger, and dependency semantics; it is not an interchangeable fast `DELETE`.

## Verification That Survives Growth

A single warm-cache timing cannot establish scalability. Compare the data sizes, distributions, concurrency, cache conditions, projections, and deployment paths that explain the production concern. Separate response time from completed throughput.

Use correctness and actual-work checks as well as timing. Query-count regressions and meaningful plan properties can be useful; pinning an entire textual plan creates brittle tests when harmless optimizer choices change.

## Sources and Scope

Markus Winand, *Use The Index, Luke!*:

- Anatomy of an Index and Slow Indexes: descent, leaf traversal, and table access.
- The Where Clause: composite keys, expressions, bind values, predicate transformations, and partial indexes.
- Clustering and Join: table locality, covering, physical join contracts, and generated-query effects.
- Sorting and Grouping and Partial Results: ordered access, Top-N, and pagination.
- DML and Testing Scalability: maintained redundancy and representative performance evidence.

Historical operator names, framework flags, plan-cache behavior, feature matrices, and example speedups are not current defaults. Verify exact index syntax, operator classes, expression/partial eligibility, optimizer behavior, and online-build procedures for the selected engine.
