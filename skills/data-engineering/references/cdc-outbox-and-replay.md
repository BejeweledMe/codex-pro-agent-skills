# CDC, Outbox, and Replay

Use this reference for snapshot bootstrap, diverging projections, log retention, checkpoint recovery, event history, and historical rebuilds.

## Choose the Change Contract

Keep three models distinct:

- **CDC** exposes committed changes to a source database's mutable state. Consumers may become coupled to internal schema and change representation.
- **Transactional outbox** stores domain state and an external event record in one local transaction. A separate publisher or CDC path carries that record downstream. This protects the public event contract from some internal schema churn but adds writes and transformation work.
- **Event sourcing** makes semantic events authoritative and derives current state from their history. It is an authority decision, not a synonym for consuming CDC.

The system/domain owner chooses authority and cross-system promises. Database/backend owners prove the local transaction and source capture mechanism. Data engineering owns consumption, ordering, derived state, retention, and rebuild.

An outbox removes the partial-success gap between separately committing domain state and event intent. It does not make delivery or every external effect occur once. A publisher can send successfully and lose its acknowledgment; consumers still need an explicit duplicate/effect contract.

Define event identity, entity key, schema version, operation/delete representation, order scope, and compatibility. Business time is not automatically a trustworthy commit order.

## Prove the Snapshot/Log Cut

A snapshot followed by “start reading recent changes” can miss or duplicate updates. Require evidence connecting the snapshot's visible state to the log positions used for catch-up.

1. Obtain the source engine/connector's supported consistent snapshot and log-position procedure. Identify the included tables and transaction boundaries.
2. Record the snapshot identity and corresponding position or set of positions. Specify whether the replay start includes or excludes each boundary; do not infer this from a timestamp.
3. Ensure required history remains available while the snapshot is read, loaded, and caught up.
4. Seed an isolated destination, then apply the corresponding changes in the promised order with retry-safe handling.
5. Process updates, deletes, and schema transitions across the boundary. Validate that a transaction spanning captured records receives the promised downstream treatment.
6. Reconcile at a comparable source cut before publishing the projection.

Multiple independently captured sources do not automatically share a globally consistent snapshot. Define acceptable cross-source skew or obtain the required coordination contract from system design.

An arbitrary combination of a database backup, a timestamp, and a consumer position is not proof of a consistent cut. Database engineering owns source snapshot/WAL and point-in-time restore mechanics; this skill verifies that the downstream starting position matches them.

## Ordering, Retention, and Consumer Progress

A work queue's acknowledgment and a retained log's replay position support different recovery models. Traditional queues often fit independent variable-duration work; retained logs support replay and ordered histories within their declared scope. Redelivery can reorder work, and a slow record can block later records in an ordered partition. Choose by replay need, order scope, work variance, and priority/expiry behavior. Partition-limited parallelism describes the classic consumer-group model, not every modern broker or queue API.

A dead-letter destination preserves failure evidence; it does not establish that the business event was processed.

For each consumer, identify:

- Committed input progress and the meaning of acknowledgment.
- Required order scope and behavior for reordering or stale updates.
- Deduplication identity, scope, retention, and result handling.
- Available replay history, including deletes and schema versions.
- Lag age relative to the oldest required retained history.
- Owner and disposition for poison events, abandoned consumers, and reseeding.

Some CDC implementations retain source WAL/binlog because a consumer has not advanced. This can threaten source storage even if downstream systems are separate. Check the actual implementation; do not assume either universal isolation or universal log pinning.

When lag approaches history loss, estimate whether catch-up can finish while protecting the source and live workload. If the history needed for correctness is gone, continuing from a later position silently loses facts. Stop claiming continuity, establish a new consistent seed, and reconcile.

A compacted log may reconstruct current key state when records are self-contained and delete/retention semantics support it. It does not necessarily preserve transitions, historical joins, or authoritative domain event history.

## Bind Recovery to Observable Effects

Checkpoint recovery needs a compatible combination of input progress, operator state, and output/effect state.

| Failure point | Risk | Required mechanism or recovery |
| --- | --- | --- |
| Output applied, acknowledgment lost | Replay duplicates the effect | Durable effect identity or an atomic boundary covering progress and output |
| Input progress recorded before durable output | Recovery skips missing output | Correct commit ordering/atomicity; reconcile and replay the missing range |
| Snapshot state and input position do not match | Events skipped or applied to the wrong state | Restore a proven compatible pair or rebuild from a known cut |
| Old and replacement workers both write | Stale values overwrite newer output | Sink-enforced ownership/version checks or controlled single-writer transition |
| Deduplication history expires before replay | Old operations become effective again | Align dedup retention with the supported replay horizon or reconcile/isolate replay |

Do not implement protected deduplication as an unguarded “check, then write.” The protected mutation and identity check need the database/sink's actual concurrency mechanism.

Carry a durable operation/event identity from the original intent to its effects. Scope it to the relevant source or tenant, destination, and logical effect so unrelated operations cannot collide and one event's distinct effects are not suppressed together. A source offset is usable only with its source/order context and a stable mapping to that effect. Preserve identity on retry; detect different parameters under the same identity. Attempt IDs and a new backfill ID are not substitutes for the original effect identity.

An idempotent state assignment can still be wrong if a stale replay overwrites a newer assignment. Preserve required ordering, transformation identity, and writer ownership. “Upsert” does not resolve every concurrency or correction rule.

For arbitrary external effects, determine whether the destination supports durable idempotency and status lookup. If a timeout leaves the outcome unknown and no safe repeat mechanism exists, stop automatic repetition and reconcile with the effect owner. A framework checkpoint cannot retract an email or payment.

Choose recovery state from remote replicated state, local state plus durable snapshots/changelog, redundant processing, or retained-input rebuild according to measured state size, replay cost, retention, and recovery target. Prove recovery by the resulting state and effects, not by successful process startup.

## Rebuild and Backfill Alongside Live Output

Use a separate version when replacing a substantial derivation or when in-place repair would expose mixed semantics.

1. **Bound the repair.** Identify affected records/intervals and downstream dependency closure, source authority, and the last trusted cut.
2. **Make replay reproducible.** Pin input/history, code, configuration, schemas, required order, and historical lookup values or versions. Record missing history as a limit.
3. **Isolate effects.** Write candidate derived output separately. Suppress notifications and other external effects, or use the same durable identity as the original logical effect.
4. **Preserve live correctness.** Keep the existing reader route while retaining the candidate's required live tail. Budget source, processor, and sink capacity so the rebuild does not destroy the retention margin.
5. **Catch up.** Apply changes after the historical cut, including deletes and schema transitions. Define a comparable validation boundary. Carry current deletion and access restrictions into the candidate before it becomes eligible for any reader; do not defer them until after cutover.
6. **Compare meaning.** Check identities, uniqueness, aggregates, updates/deletes, temporal joins, and affected consumer behavior. A corrected derivation may intentionally differ from the old output; state expected differences.
7. **Publish.** Use the [version/readiness procedure](orchestration-idempotent-publication.md). A canary may route selected readers to the whole candidate version; it must not accidentally mix rows from incompatible versions.
8. **Retire deliberately.** Preserve an eligible rollback route for the required period, then retire obsolete state and retained inputs according to deletion and retention obligations.

Replaying historical effects with a new identity defeats deduplication. Distinguish a retry of an old intent from a genuinely new compensation or correction authorized by the domain owner.

## Divergence Triage

| Evidence | Distinguishing question | Action and proof |
| --- | --- | --- |
| Source and projection differ immediately after seed | Is snapshot state bound to the replay start? | Repair/reseed from a proven cut; compare at a common boundary |
| Only a subset of keys regresses | Were updates reordered or applied by overlapping writers? | Repair order/version enforcement; replay those histories and inspect final values |
| Deleted entities reappear | Were tombstones/history omitted or an old snapshot restored? | Carry deletion through seed/replay/rollback and verify consumer absence |
| Rebuild changes historical enrichment | Did it use today's dimension state? | Restore declared temporal versions or publish an explicitly revised history |
| Source log storage grows | Does this implementation retain logs for stalled consumers? | Coordinate retention protection and reseed/consumer retirement with the source owner |

## Sources and Version Limits

Based on *Designing Data-Intensive Applications, 2nd edition*, CDC/outbox, queues versus logs, event sourcing, replay, event-time joins, end-to-end identity, and state recovery.

This establishes general snapshot/log and effect invariants, not current Kafka partitions/groups/transactions, Kafka Connect configuration, or Debezium snapshot/state behavior. Obtain targeted primary documentation for the actual product/version before issuing connector commands. Source-log retention, transaction markers, DDL handling, failover, and deduplication capabilities are implementation-specific.
