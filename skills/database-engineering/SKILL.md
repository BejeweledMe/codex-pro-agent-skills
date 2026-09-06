---
name: database-engineering
description: "Design, diagnose, and change relational and embedded databases, especially PostgreSQL and SQLite. Use for constraints, transaction anomalies, locks, SQL plans and indexes, schema changes, maintenance, and restore. Store topology and cross-system guarantees belong to system-design."
---

# Database Engineering

Connect an invariant or query contract to an engine mechanism and evidence of its behavior. Keep PostgreSQL and SQLite semantics explicit: a snapshot, index, or backup label alone does not establish correctness, efficiency, or recoverability.

## Working Method

Use the parts needed for the request; a small query correction need not become an architecture or recovery review.

1. Establish the engine/version and relevant schema, SQL, bind types, settings, and transaction boundaries. Capture the observed failure, representative data distribution, and concurrent workload.
2. For correctness, describe the forbidden history and select enforcement with sufficient conflict coverage. For performance, locate actual work before choosing a change.
3. Compare the smallest effective SQL, constraint, index, or maintenance change against write cost, storage/cache pressure, blocking, and other important queries.
4. For stored-state changes, separate validity, rewrite work, lock exposure, application compatibility, and recovery. Verify the target version's exact operation before presenting an executable procedure.
5. Verify the affected invariant or workload under representative conditions. Report the conclusion, evidence, change, verification performed, and remaining uncertainty. Label unexecuted experiments and restores accurately.

A stable snapshot can permit write skew; an index scan can traverse a broad range. `EXPLAIN ANALYZE` executes the statement and can impose effects or load that rollback does not undo. No rewrite does not mean no lock, and inverse DDL does not recover lost data. Use the relevant reference to establish the mechanism.

## References

Read only the module needed; [the index](references/00_README.md) describes outputs and refresh boundaries.

- [Invariants and concurrency](references/invariants-transactions-and-concurrency.md): constraint scope, anomaly histories, locks, retries, and uncertain commit outcomes.
- [PostgreSQL schema, locks, and plans](references/postgresql-schema-locking-plans.md): null semantics, engine isolation, blocking, and plan interpretation.
- [SQL access paths and index economics](references/sql-access-paths-and-index-economics.md): composite order, predicates, joins, covering, pagination, generated SQL, and workload cost.
- [Safe schema change](references/safe-schema-change.md): validity/rewrite/locks, compatible stages, concurrent backfills, and recovery.
- [PostgreSQL maintenance and recovery](references/postgresql-maintenance-and-recovery.md): statistics, vacuum/freeze, WAL, PITR, and restore evidence.
- [SQLite WAL and backup](references/sqlite-wal-and-backup.md): connection snapshots, single-writer contention, checkpoints, file custody, and consistent backups.

## Ownership

Keep practical engine implementation and proof here when the database boundary is chosen. Use a named companion only for an unresolved neighboring decision.

| Decision | Owner and exchange |
| --- | --- |
| Source of truth, store selection, replication/sharding, cross-system commit | `system-design` supplies authority, invariant scope, and failure guarantees; return engine atomicity, access, and restore feasibility with costs. |
| ORM session, request/use-case transaction, application side effects | `python-backend-engineering` or `node-typescript-backend-engineering` owns lifecycle and retry code; exchange generated SQL, commit boundaries, and engine outcomes. |
| Mixed-version code rollout and deprecation | `software-engineering` with the backend owner sequences consumers; supply DDL, lock/rewrite exposure, data compatibility, and rollback limits. |
| Pipelines, CDC consumers, event time, replay, derived publication | `data-engineering` owns processing semantics; exchange source schema, snapshot/log position, order, retention, and restore/reseed obligations. |
| ANN recall and relevance | `rag-engineering` owns retrieval evaluation; this skill supplies relational SQL and physical access-cost evidence. |
| SLOs, incidents, recovery policy and drills | `sre-reliability-engineering` owns reliability acceptance; supply engine signals, restore method, achieved recovery point, and elapsed time. |
| General verification strategy | `qa-testing` places tests; supply concurrent histories, query-count, migration, and recovery cases. |
| Observable HTTP schema and compatibility | `api-contract-engineering` owns the wire contract; storage schema does not automatically define it. |

Pass only the relevant evidence and outstanding decision. Domain owners determine invariant meaning and any accepted weakening or compensation.
