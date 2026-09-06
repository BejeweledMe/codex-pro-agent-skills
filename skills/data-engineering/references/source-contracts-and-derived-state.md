# Source Contracts and Derived State

Use this reference to define a dataset, diagnose semantic drift, choose a rebuild boundary, or carry retention and deletion through derived copies.

## Establish the Contract at the Consumer's Grain

For the affected data product, capture the fields that determine correctness. Reuse existing documentation or configuration; a new registry is unnecessary for a small pipeline.

| Field | Decision it must make explicit |
| --- | --- |
| Consumer and purpose | Which operation uses the output, and what wrong, stale, or missing data would do |
| Authority | Which source accepts facts and resolves corrections or conflicts |
| Grain and keys | What one row/event represents, uniqueness scope, and how updates or deletes identify it |
| Input identity | Dataset versions, extraction boundaries, or consistent snapshot/log positions |
| Time | Event time, source availability time, processing time, timezone/boundaries, and clock uncertainty |
| Transformation | Code/config/schema versions, join cardinality, filters, aggregation, and external lookup versions |
| Output semantics | Append, replacement, upsert, correction/retraction, or deletion; required order |
| Visibility and freshness | What makes a version complete, which consumers may see it, and tolerable lag |
| Recovery | Retained inputs and state, replay horizon, reconciliation invariant, and rebuild owner |
| Lifecycle | Access, retention, deletion propagation, eligible rollback copies, and exceptions with owners |

Grain precedes deduplication and aggregation. An order table with one row per order and a payment table with several rows per order cannot be joined and then have order totals summed without accounting for multiplication. Inspect key multiplicities before and after the join. Aggregate each side to the intended grain or define an explicit allocation rule with the domain owner; a final `DISTINCT` can conceal the defect while discarding legitimate rows.

Distinguish an event's identity from an entity's identity. Multiple valid updates to one entity are not duplicates. Conversely, a retry of one event should not become a new fact merely because its processing timestamp changed.

## Authority Versus Derivation

A warehouse table, index, cache, or feature table is derived only if named inputs and rules can reconstruct its promised state. The storage product does not determine authority.

If a derived output cannot be reconstructed, distinguish missing history or an undocumented transformation from an intended promotion to authority; loss of rebuildability alone does not decide which system is correct. If users edit a derived table directly, identify whether those edits are disposable repairs, new authoritative facts, or compensations. Persistent sink-only edits break reconstruction unless represented in the source contract. Return authority/conflict decisions to the system or domain owner; implement the resulting propagation rule here.

Choose materialization when saved read work and freshness needs justify update, storage, and recovery costs. High-churn dimensions or hot keys can make a fully denormalized representation expensive. Measure update fan-out and skew before materializing every combination.

## Choose What to Retain and Recompute

ETL can enforce selected transformations before data enters the destination. ELT can preserve source material for later corrections and alternative derivations, at the cost of storage, access control, and deletion obligations. Choose from consumer needs and the permitted retention boundary rather than assuming raw data should live forever.

For reproducible derivation:

1. Identify actual input versions or a reproducible source cut. A saved query over mutable tables does not identify historical input.
2. Pin transformation code, configuration, schemas, and relevant external lookup state.
3. Define ordering and duplicate rules where the operation is order-sensitive.
4. Record the output version and validation evidence associated with those inputs.
5. State any residual nondeterminism and its accepted tolerance.

An incremental result is comparable to a full recomputation only when both use equivalent input cuts and semantics. Include updates, deletes, late arrivals, and changed dimension records in the comparison. Exact equality is appropriate for deterministic outputs; otherwise use a justified tolerance and invariant. Do not invent a tolerance to hide a discrepancy.

A partitioned backfill is safe only if the affected dependency closure is understood. Changing one date can affect later rolling windows or joins. Determine the impact from transformation dependencies before choosing the reprocessing interval.

## Schema Compatibility and Semantic Compatibility

Check old and new consumers against the proposed source/output versions. Column names and types are only one layer:

- A field can keep its type while changing units, timezone, null meaning, population, or aggregation grain.
- A new nullable field may be structurally compatible while a consumer treats absence as zero.
- A corrected source timestamp can move records between partitions and windows.
- Renaming or reusing an identity can break deduplication and deletion propagation.

For a material change, build a separate output version, compare representative consumer behavior, then switch consumers through an explicit readiness condition. Preserve the previous usable contract for the agreed rollback period. Physical database DDL and lock safety belong to database engineering; HTTP serialization and schema dialect behavior belong to API contract engineering.

## Diagnose Timeliness Separately from Integrity

| Symptom | Distinguishing evidence | Action and verification |
| --- | --- | --- |
| Output is stale but otherwise consistent | Source arrival, processing lag, pending intervals, publication version | Restore progress; prove the required source cut becomes visible within the consumer's freshness target |
| Totals remain wrong after catch-up | Key multiplicities, filters, missing/deleted identities, temporal lookup versions | Repair the derivation or source fact, then reconcile a rebuilt version at the same cut |
| A recent row makes freshness look healthy | Per-source/partition coverage, zero-volume intervals, expected arrival schedule | Measure coverage and completeness for the required scope; do not rely only on a maximum timestamp |
| Repeated builds differ | Input versions, current-time dependencies, ordering, external lookup state | Pin or explicitly model the changing dependency and repeat the comparison |
| Consumers disagree despite matching schema | Units, grain, null semantics, correction rules, consumer version | Agree the semantic contract with its owner and verify representative reads |

Set freshness requirements by consequence: fraud decisions, inventory reservations, and alarms can make delay itself harmful. Catch-up repairs lag only if the required inputs and processing remain available; it does not repair a persistent integrity defect.

Measure source availability, ingest delay, transformation delay, and publication delay separately when this distinction changes the response. Event-time age may reflect old business events arriving correctly; processing success time may conceal missing source data. Each signal needs a scope, expected behavior, owner, and action.

## Deletion and Recovery Without Resurrection

Trace deletion through retained source extracts, change logs, derived tables, intermediate artifacts, caches, exports, and recovery copies. For model or retrieval artifacts, pass the affected data identities and lineage to the ML or RAG owner; data-row deletion alone does not establish model unlearning or removal of retrieval evidence.

A practical deletion procedure is:

1. Resolve the subject or record to the affected source and derived identities.
2. Apply the authoritative deletion/correction through the supported change path.
3. Remove, rewrite, or suppress derived representations according to the lifecycle contract, including delayed work and replay.
4. Keep sufficient authorized deletion evidence to prevent a historical input, checkpoint, or rollback copy from reintroducing the record. Choose the minimum retained identity data needed for that purpose.
5. Verify consumer reads and rebuild behavior, then track physical cleanup or retention exceptions separately.

A tombstone can prove logical suppression while original bytes remain in files, snapshots, or backups. Snapshot expiration, compaction, object deletion, and backup retirement have different effects; verify the relevant storage mechanism rather than declaring erasure from a query result.

Rollback eligibility includes current access and deletion obligations. Reapply those obligations before serving restored data. If an old version cannot meet them, rebuild an eligible fallback instead of restoring it unchanged. Retention and legal decisions remain with the accountable owner; this skill implements and reports their technical consequences.

## Handoff Evidence

For system/database work, pass source authority, invariant, schema, exact source cut, ordering and retention needs, effect boundary, and rebuild obligations. Receive the engine or topology guarantee that makes those requirements possible.

For ML/CV/NLP, receive the feature/label definition, sampling and split policy, and availability-at-prediction requirement. Return reproducible source versions, event and availability timestamps, transform lineage, exclusions, and quality evidence. An event-time join can still leak information that was unavailable at prediction time; the model owner defines that acceptance rule.

For RAG, pass source versions, access/deletion changes, extraction inputs, and completeness/freshness evidence. The RAG owner decides whether chunks, indexes, retrieval results, and citations remain valid.

## Sources and Limits

Based on *Designing Data-Intensive Applications, 2nd edition*, topics covering authoritative and derived data, reproducible processing, timeliness versus integrity, and retention/deletion responsibility. The contract fields and diagnostic procedures are engineering applications of those mechanisms. They do not prescribe a legal retention policy, model unlearning method, or universal semantic-compatibility standard.
