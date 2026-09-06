# PostgreSQL Maintenance and Recovery

Use this module for maintenance debt, statistics, WAL retention, and engine-local restoration. The engine semantics are scoped to PostgreSQL 18; operational thresholds and executable emergency procedures require the deployed version and workload.

## Distinguish Maintenance Responsibilities

| Mechanism | Purpose | Evidence of a relevant problem |
| --- | --- | --- |
| `ANALYZE` | Supply sampled distribution statistics to the planner | Estimate errors correlated with skew, changed distributions, or insufficient statistics |
| Routine `VACUUM` | Make obsolete-version space reusable, maintain visibility information, and freeze old transaction metadata | Dead-version accumulation, cleanup restrictions, visibility effects, age horizons |
| Autovacuum/autoanalyze | Schedule routine work from engine triggers | Worker saturation, delayed completion, conflicting locks, uncovered table classes |
| WAL/checkpoint/archive work | Support durability, crash recovery, and retained recovery history | Generation/retention pressure, archive failures, checkpoint-related I/O, recovery-chain gaps |

`VACUUM` alone is not equivalent to `ANALYZE`. They can be requested together, but plan statistics, visibility, reusable space, and freeze safety are distinct results to verify.

Routine vacuum generally makes space available for reuse inside a relation. Reclaiming a particular amount of filesystem space is a separate requirement. Do not infer “vacuum failed” solely from an unchanged file size.

## Diagnose Before Increasing Maintenance Aggressiveness

For poor plans, compare estimates with actuals and inspect distribution changes. Autoanalyze reacts to row-change counts, which need not reflect how much the distribution relevant to one query changed. Manual analysis or more suitable statistics may help, but stale statistics are not the only explanation.

For delayed cleanup or growing relations, inspect completed maintenance, table churn, long-lived transactions/snapshots that retain visibility, worker capacity, and lock conflicts. Increasing worker activity cannot remove a visibility horizon held by another operation.

For autovacuum coverage, identify the relation class. PostgreSQL 18 does not autoanalyze partitioned or foreign tables. Changes in inheritance children do not trigger autoanalyze of the parent; a rarely changed parent can retain stale aggregate statistics. Temporary tables need session-owned maintenance. Establish manual analysis where these cases affect plans, rather than increasing workers and expecting unsupported coverage.

Treat maintenance as capacity: foreground work, vacuum, analysis, checkpoints, and backup compete for I/O and other resources. Measure completion and query/write effects rather than disabling essential work to improve one short benchmark.

`VACUUM FULL` rewrites a relation, requires extra disk, and takes `ACCESS EXCLUSIVE`. Autovacuum does not issue it. Choose it only for an established rewrite/space-reclamation need with a planned impact window; it is not routine maintenance or a routine anti-wraparound remedy.

## Freeze Safety Is a Separate Failure Class

Track transaction-ID and multixact age separately. Their exhaustion conditions and remedies are not interchangeable. A table with little apparent bloat can still require freezing.

When age approaches an operational safety boundary:

1. Identify the affected databases/relations and whether the horizon is XID or MXID.
2. Determine why required vacuum has not completed: retained state, locks, capacity, or scheduling.
3. Restore the conditions for the documented maintenance procedure.
4. Verify completion and reduced age pressure, including other affected relations.

Do not improvise emergency `VACUUM FULL`, blanket freezing, or single-user-mode procedures from a generic wraparound label. PostgreSQL's emergency behavior and permitted commands need the exact version's instructions. Anti-wraparound activity can occur even when ordinary autovacuum is disabled; that is not a substitute for routine capacity and monitoring.

## Diagnose WAL Growth by Retention Owner

Separate the rate of new WAL generation from the reason older WAL is retained. Inspect archive success, oldest required recovery history, backup activity, and any replication/CDC consumers retaining source history.

| Observation | Next distinction | Action |
| --- | --- | --- |
| Archive failures or increasing archive delay | Destination unavailable, persistence failure, command failure, or insufficient throughput | Repair archival and verify durable success before trusting the recovery window |
| Archive command reports success but files are absent/incomplete | Incorrect success or overwrite semantics | Correct the archival contract and establish which recovery history remains usable |
| A stalled consumer retains WAL | Temporary lag versus abandoned consumer; restart versus reseed | Coordinate source retention with the consumer owner; verify the consequences before releasing retention |
| WAL grows during maintenance/backfill | Higher generation versus archive/consumer bottleneck | Adjust competing work and retention capacity using measured rates |
| Disk space approaches exhaustion | Which files remain required and how fast headroom is disappearing | Coordinate incident action and preserve required state; do not delete WAL files by filename age |

Archive commands must report success only after the archive copy is fully persisted. An existing destination file must not be silently overwritten; accept an existing copy only through the documented identical-and-persisted check.

Archive stalls can fill `pg_wal` and take the database offline. Increasing capacity can buy time, but does not fix a stalled archive or consumer. Return retention/reseed decisions to the data or system owner when they affect another system's ability to rebuild.

Do not turn a sample `archive_timeout` value into an RPO. Relate the required recovery point to observed archive behavior and failure assumptions.

## Assemble a Recoverable PITR Chain

PostgreSQL PITR needs a physical base backup and continuous required WAL from at least the backup's start, together with the relevant metadata and timeline history.

Establish:

- Backup identity, start/end, consistency/completion, engine/tool compatibility, and tablespace layout.
- Required WAL availability through the target and the correct timeline/history.
- Backup metadata custody, including byte-for-byte preservation of low-level backup label and tablespace-map material where applicable.
- Configuration and external prerequisites that WAL does not restore.
- Archive durability and retention covering the entire selected chain.

`pg_dump` and `pg_dumpall` are logical backup paths, not the base backup for physical PITR. Physical recovery operates on the cluster; extracting a historical table may require restoring an isolated cluster and then performing a separate logical extraction.

If incremental backups are in use, track their predecessor dependencies and the target-version reconstruction procedure. Do not prune an earlier backup solely because a newer incremental backup exists. Verify required WAL summaries, history, and combination tooling for the actual backup method.

## Restore in an Ordered, Isolated Procedure

Prepare an executable runbook from the exact backup method and PostgreSQL version. Its state transitions should establish:

1. **Target and preserved evidence:** Select the intended recovery point/timeline. Preserve the current cluster and surviving WAL when investigating failure. Choose a recovery target after the selected base backup's end; an earlier target needs a suitable earlier backup.
2. **Compatible restore environment:** Provide the required binaries, storage, tablespace paths, access, configuration, and archive access. Keep the restored instance isolated from production writers and side effects.
3. **Base restoration:** Restore or reconstruct the selected base and required metadata according to the backup method.
4. **WAL recovery:** Configure the documented archive-retrieval and target behavior. Observe recovery reaching the intended point on the intended timeline; a process start alone does not prove this.
5. **Result inspection:** Check the achieved recovery point, data invariants, critical reads, relationships, and representative application behavior.
6. **Controlled return to service:** Coordinate routing, authority, and any downstream reconciliation before accepting production writes. Retain timeline history and establish backup/archiving for the resulting history.

HA promotion and failback require system/platform ownership; a successful isolated restore does not prove a safe production authority transition.

## Prove Recovery by the Result

Record actual elapsed recovery time and achieved recovery point against the stated need. Distinguish archive-chain completeness, engine startup, database validity, and application usability.

Useful checks include domain uniqueness and relationship invariants, representative balances/counts with semantic meaning, recent expected operations near the recovery boundary, and critical queries against the restored schema. If committed application activity would be lost at the selected target, make that consequence explicit.

For derived consumers, pass the restored timeline/position and schema to the data owner. Do not assume an old consumer offset is compatible with restored history. Reconcile or reseed according to the cross-system contract.

SRE owns drill cadence, SLO acceptance, incident coordination, and recovery-time policy. Database engineering supplies the method, engine signals, and observed restore result.

## Sources and Refresh Limits

- [PostgreSQL 18 Routine Vacuuming](https://www.postgresql.org/docs/18/routine-vacuuming.html): reusable space, analysis, visibility, autovacuum, XID/MXID safety, and rewrite costs.
- [PostgreSQL 18 Continuous Archiving and Point-in-Time Recovery](https://www.postgresql.org/docs/18/continuous-archiving.html): physical backup/WAL continuity, archive success, metadata, timelines, and recovery sequencing.
- *Designing Data-Intensive Applications*, second edition, verification and auditability discussions: restoration and invariant checks as evidence of recovery.

These sources do not establish workload-specific thresholds, complete monitoring queries, HA/failover commands, third-party backup/bloat tooling, or an observed RPO/RTO. Refresh the relevant versioned procedure and measure the target workload.
