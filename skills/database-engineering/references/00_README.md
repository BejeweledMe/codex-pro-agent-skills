# Database Engineering References

Choose a reference by the unresolved engine decision. Each module connects mechanism, failure evidence, action, and verification.

| Task | Read | Useful result |
| --- | --- | --- |
| Concurrent transactions violate a rule | [Invariants and concurrency](invariants-transactions-and-concurrency.md), then the engine module | Forbidden history, enforcement scope, conflict coverage, retry behavior, and concurrent verification |
| PostgreSQL constraint, blocking, or slow-plan investigation | [PostgreSQL schema, locks, and plans](postgresql-schema-locking-plans.md) | Exact semantic or plan finding and a discriminating next action |
| Index selection, generated SQL, joins, pagination | [Access paths and index economics](sql-access-paths-and-index-economics.md) | Query/access-path explanation and workload-wide read/write comparison |
| Schema migration or large backfill | [Safe schema change](safe-schema-change.md) | Version-scoped transition, validity checks, lock/rewrite exposure, and recovery boundary |
| PostgreSQL maintenance, WAL growth, or PITR | [Maintenance and recovery](postgresql-maintenance-and-recovery.md) | Diagnosed retention/maintenance cause or a demonstrable restore procedure |
| SQLite contention, stale reads, growing WAL, or copying | [SQLite WAL and backup](sqlite-wal-and-backup.md) | Connection/journal state model and a consistent, verified backup path |

## Evidence Scope

PostgreSQL engine semantics here are grounded in PostgreSQL 18 documentation: Constraints, Modifying Tables, Transaction Isolation, Explicit Locking, Using EXPLAIN, Routine Vacuuming, and Continuous Archiving and Point-in-Time Recovery. Each relevant module links its sources. Verify the installed major version and the exact operation before adapting commands or operational procedures.

SQLite guidance follows its Isolation, Write-Ahead Logging, and Online Backup API documentation. Those pages cover distinct mechanisms and have independently evolving compatibility details. A deployed SQLite library can differ from an application's command-line SQLite; identify the library actually opening the file.

Markus Winand's *Use The Index, Luke!* supplies B-tree access, predicate, join, ordering, and index-cost foundations. Its cross-engine examples do not establish every contemporary PostgreSQL or SQLite optimizer feature.

*Designing Data-Intensive Applications*, second edition, supplies architectural reasoning about invariant scope, transactions, derived state, uncertain outcomes, and verification. It is not authority for engine commands.

## When to Refresh

Refresh the smallest relevant primary-documentation section when the task depends on:

- Exact DDL lock modes, rewrite exceptions, deferred validation, online index operations, or migration-tool transaction wrapping.
- Operator classes, expression/partial-index eligibility, plan caching, optimizer statistics, or version-specific plan fields.
- Maintenance emergency commands, backup-tool compatibility, incremental backup dependencies, HA, promotion, or failback.
- SQLite checkpoint modes, child backup API contracts, WAL-source backup details, filesystem behavior, extensions, or patch-level fixes.

Preserve a useful diagnosis when documentation is unavailable. State which executable step remains unverified and the exact behavior that must be established; do not replace a scoped uncertainty with a universal recipe.

Remeasure when data distribution, query mix, concurrency, cache conditions, write rate, schema, or recovery objectives change. Successful measurements apply to the conditions observed.
