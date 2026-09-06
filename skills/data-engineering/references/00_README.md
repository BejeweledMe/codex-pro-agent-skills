# Data Engineering Reference Guide

Select a reference by the broken or undecided contract. These modules support individual fixes as well as a complete source-to-consumer design.

| Situation | Start here | Expected result |
| --- | --- | --- |
| Counts disagree, joins inflate rows, or a dataset's purpose is unclear | [Source contracts and derived state](source-contracts-and-derived-state.md) | Explicit grain, authority, temporal meaning, and reconciliation invariant |
| Windows change after outages or state keeps growing | [Batch, stream, and window semantics](batch-stream-window-semantics.md) | Timestamp/window/pane contract, bounded state, and late-data action |
| Snapshot-seeded projection differs from its source | [CDC, outbox, and replay](cdc-outbox-and-replay.md) | Proven snapshot/log boundary, ordering, retention, and repair path |
| Retries duplicate writes or readers see incomplete output | [Orchestration and idempotent publication](orchestration-idempotent-publication.md) | Stable work identity, durable artifacts, and a verified publication boundary |
| Structural checks pass but consumers fail | [Quality, lineage, and table formats](quality-lineage-table-formats.md) | Separate evidence for shape, content, freshness, lineage, and consumer meaning |
| A historical derivation must be replaced | [CDC, outbox, and replay](cdc-outbox-and-replay.md), then [publication](orchestration-idempotent-publication.md) | Isolated rebuild, tail catch-up, comparison, cutover, and eligible rollback |
| A deleted record returns after recovery | [Source contracts and derived state](source-contracts-and-derived-state.md) | Deletion propagation through history, derived copies, and rollback |
| Table reads disagree across engines or conversions | [Quality, lineage, and table formats](quality-lineage-table-formats.md) | Table membership, file readability, and memory/value compatibility checked separately |

## Source Coverage

The durable dataflow guidance draws on *Designing Data-Intensive Applications, 2nd edition*: authoritative versus derived data; batch and stream processing; logs, CDC and outbox; event sourcing and reprocessing; event time and joins; end-to-end integrity; and data lifecycle responsibility.

Product-specific guidance uses selected Apache Beam processing documentation, Apache Airflow 3.3.1 best-practice guidance, dbt model contracts/data tests/source freshness documentation, OpenLineage dataset/job/run and column-lineage documentation, and the Apache Iceberg, Parquet, and Arrow format specifications.

The references distinguish supported mechanisms from engineering applications of those mechanisms. They are not complete product manuals or conformance profiles. In particular:

- General CDC reasoning does not establish current Kafka or Debezium configuration.
- Beam runner/lifecycle details and Airflow dependency isolation need implementation-specific evidence.
- dbt enforcement depends on version, adapter, and materialization.
- ODCS field syntax, Great Expectations execution APIs, and OpenLineage quality integration mappings are not specified here.
- Iceberg catalog procedures, Parquet encodings/statistics/nesting, and Arrow C interfaces require additional detail for executable work.

Refresh the smallest relevant area when versions, consumers, ordering, source retention, lateness distributions, format features, or recovery requirements change. Do not install a mandatory vendor stack or load all companion skills to resolve one local issue.
