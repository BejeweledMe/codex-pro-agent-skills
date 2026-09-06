# Quality, Lineage, and Table Formats

Use this reference when a pipeline is green but consumers fail, when lineage is incomplete, or when a table/file/memory boundary is being changed.

## Keep Assurance Layers Separate

| Layer | Evidence it supplies | What remains unproved |
| --- | --- | --- |
| Dataset semantic contract | Agreed purpose, grain, units, keys, correction/deletion meaning | Actual enforcement and observed data |
| dbt model contract | Declared output names/types and supported structural constraints | All content, source timeliness, or business meaning |
| dbt data tests | Encoded assertions evaluated against materialized data | Properties not encoded or data outside the tested scope |
| Source freshness | Timeliness against the configured source timestamp and thresholds | Completeness, correctness, or freshness of every downstream output |
| Runtime lineage | Observed dataset/job/run relationships and supported facets | Correct transformation or complete instrumentation |
| Consumer verification | Required behavior on representative output | Untested consumers, intervals, and future changes |
| Public API/runtime contract | Protocol/schema/serialization behavior at its own boundary | Dataset correctness upstream |

Name each required check, its scope, failure action, and owner. Do not turn this table into a mandatory full-stack gate for a small transformation.

## Apply dbt Controls to the Right Failure

For eligible models, dbt model contracts declare every output column's name and data type. The documented structural preflight is order-independent; supported DDL constraints and their enforcement depend on adapter and materialization.

Data tests are distinct failing-row queries after materialization. Uniqueness, nullability, accepted values, and relationships can detect encoded content violations. Inspect the query, selected data, and configured failure criteria before interpreting a pass.

Source freshness is a separate timeliness check. The documented workflow does not make it part of `dbt build` automatically; explicitly arrange it as a blocking step when release requires it. Verify target-version behavior instead of assuming a successful build included freshness.

When a contract passes but a consumer fails:

1. Pin dbt version, adapter, materialization, model/source version, and the run being examined.
2. Inspect what the structural contract actually declares and what the adapter enforces.
3. Inspect executed tests and their data scope, including missing or empty partitions.
4. Inspect freshness configuration, timestamp origin, thresholds, and whether the check actually ran.
5. Compare the published output version with the tested version.
6. Check semantic assumptions with the consumer owner: grain, units, nulls, timezone, late correction, and availability.

| Symptom | Likely missing evidence | Corrective action |
| --- | --- | --- |
| Duplicate business entities despite a structural pass | Content uniqueness at the intended grain | Correct grain/key or add the relevant assertion; inspect failing identities |
| Recent load timestamp but a source segment is absent | Volume and coverage by expected source/partition | Establish completeness checks alongside freshness |
| All tests pass on an old output | Publication/version binding or source timeliness | Bind readiness to the candidate and required source cut |
| Constraint declared but invalid rows remain | Actual adapter/materialization enforcement | Use supported enforcement or an explicit blocking content check |
| Consumers disagree on values with the same schema | Semantic definition | Version or correct the definition and verify affected consumers |

ODCS offers a platform-independent contract frame, but field-level syntax is not specified here. Where a standard and a companion JSON Schema disagree, consult the standard's applicable text. Great Expectations quality dimensions can help identify missing checks; they do not supply an expectation API or prove equivalence to dbt controls.

## Use OpenLineage as Runtime Evidence

OpenLineage models datasets, jobs, and runs with facets. Use stable dataset/job identity and actual execution identity so incident investigation can connect a published dataset to the run and inputs that produced it. Preserve input/output versions and processing context where supported; do not assume every integration emits them.

Column lineage distinguishes direct derivation from indirect influence. A selected value may derive directly from one column while a filter, join, sort, group, window, or condition changes which values contribute. Losing indirect dependencies can make impact analysis and rebuild scope incomplete.

For a lineage gap:

1. Trace one known output to its actual input and transformation.
2. Inspect the producer's emitted events and facets, not only the catalog visualization.
3. Check dataset identity consistency and job/run association.
4. Compare supported column derivation and indirect dependencies with the actual query or transform.
5. Repair instrumentation or document the missing edge, then repeat the trace.

Lineage helps locate affected consumers and rebuild/deletion paths. It does not establish truthful inputs, valid business semantics, or complete collection. Instrumentation coverage is a separate signal.

Keep release versions and facet schema versions distinct. Producer-specific masking or Spark column-lineage options do not establish universal semantics. Do not infer dbt/Great Expectations event mappings or quality-facet behavior from an integration-list entry.

Avoid placing credentials or unnecessary sensitive values in lineage metadata. A dependency graph should carry the identity and context needed for its purpose, with access appropriate to that metadata.

## Distinguish Table, File, and Memory Contracts

| Layer | Owns | Inspect first |
| --- | --- | --- |
| Iceberg table | Which data/delete files constitute a snapshot; schema/partition evolution and commit state | Table metadata, snapshot, manifest list, manifests, data/delete membership |
| Parquet file | Persisted columnar file layout | Footer metadata, row groups, column chunks, and actual reader support |
| Arrow memory/IPC | Typed arrays, validity, buffers, record batches, and IPC representation | Schema/types, validity, buffer ownership, nested values, and IPC mode |

“Iceberg chooses files, Parquet reads columnar data, Arrow represents values” is a useful possible composition, not a formal guarantee of conversion or one universal engine path.

### Iceberg: Table State and Commit

Follow the hierarchy from table metadata through snapshot, manifest list, and manifests to data/delete files. A directory listing is not authoritative table membership.

Iceberg's metadata-pointer commit provides an atomic table-state transition through its supported commit mechanism. Optimistic validation detects conflicting changes; after a conflict, refresh and revalidate the candidate instead of blindly replaying stale metadata.

Field IDs support schema evolution without treating column position as identity. Partition-spec evolution changes how files are organized while preserving the need to interpret files under their applicable specification. Verify reader/writer compatibility for the schema, partition, and delete features actually used.

Table-level deletes affect query-visible state; they do not prove physical removal from retained files or snapshots. Include snapshot retention and later cleanup in deletion evidence.

### Parquet: Persisted File Layout

The supported foundation is a file containing row groups and column chunks with trailing metadata used for footer-first reading. Diagnose file completeness and metadata readability before attributing a failure to a table transaction.

A task may leave an incomplete file even when its intended schema is correct. Keep such files outside published table membership. If an engine reads different values, identify the same physical file and reader versions before comparing decoding behavior.

Do not infer encodings, statistics pruning, nested-value behavior, compression efficiency, or optimal row-group sizes from the basic layout. Those decisions need the relevant specification sections and engine/workload evidence.

### Arrow: Values, Nulls, and Memory Ownership

Arrow's validity bitmap determines nullness; bytes in a null slot are not a meaningful value. A zero-null array may omit a validity bitmap. Nested arrays require their type-specific parent/child validity interpretation, rather than assuming one blanket rule for all child buffers.

Record batches bind arrays to a schema. Stream and file IPC have different framing/access contracts. Choose the mode that matches the actual producer/consumer path.

“Zero-copy” is conditional on compatible representation and buffer ownership/lifetime. It does not establish that reading compressed Parquet into Arrow or crossing every process/language boundary avoids allocation or decoding. Measure the actual conversion path when memory, latency, or copy count matters.

## Verify a Format or Engine Transition

1. Pin table snapshot and schema/partition identities, physical files, reader/writer versions, and memory/IPC types.
2. Check table membership and delete application separately from file readability.
3. Compare values and nulls through the concrete conversion path, including the nested and temporal types the workload uses.
4. Exercise supported schema evolution and delete behavior on representative records.
5. Compare resource use on equal inputs and the same observable output; format names alone do not establish performance.
6. Publish only after consumer compatibility and lifecycle requirements pass. Preserve an eligible previous version.

If a mismatch first appears at table membership, fix snapshot/delete interpretation. If the same file decodes differently, investigate the file reader/type contract. If decoded values agree but a consumer sees different nulls or values, inspect Arrow construction, validity, conversion, and ownership.

## Sources and Version Limits

Based on dbt documentation for model contracts, data tests, and source freshness; OpenLineage dataset/job/run and column-lineage documentation; and Apache Iceberg, Parquet, and Arrow format specifications.

dbt contract/test/freshness syntax and Fusion/dbt State behavior are version-sensitive. ODCS fields, Great Expectations expectation/validation APIs, and OpenLineage quality-facet integrations need targeted evidence.

Iceberg catalog/Puffin details, Parquet encoding/statistics/nested-layout details, and Arrow C interfaces are outside this reference's supported procedure depth. This material does not establish Iceberg v4 as production-current or any engine's complete feature support. Verify the needed version and implementation before executable configuration or a compatibility claim.
