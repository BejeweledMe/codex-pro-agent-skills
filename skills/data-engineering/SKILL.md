---
name: "data-engineering"
description: "Build, diagnose, and recover batch and streaming data pipelines: event-time windows, CDC/outbox consumption, retry-safe orchestration, replay/backfill, dataset publication, quality, freshness, lineage, and Iceberg/Parquet/Arrow boundaries. Database engine tuning and model or retrieval semantics have separate owners."
---

# Data Engineering

Make derived data reproducible, publishable, and recoverable from named authoritative inputs. Start with the consumer and the meaning of one output row or event; establish time, ordering, retry, and visibility semantics before choosing infrastructure.

## Working Method

Inspect the affected transformation and runtime evidence. Scale the work to the request: a partition retry fix needs its input and sink contract, not a complete platform design.

1. Identify source authority, consumer, output grain/keys, derivation version, required invariants, and acceptable staleness.
2. Choose bounded batch, unbounded stream, or incremental maintenance. Define relevant event/availability time, order, late corrections, and historical join semantics.
3. Pin input versions or a consistent snapshot/log cut, and establish what retained history can reconstruct.
4. Preserve logical work and effect identity across attempts. Name the supported atomic/idempotent sink boundary and the condition making complete output visible.
5. For replay or rebuild, isolate a candidate, control external effects, catch up and reconcile, then publish with current deletion/access restrictions and an eligible rollback.
6. Verify the consumer outcome. Separate integrity, timeliness, and each assurance layer; a green scheduler state does not establish them.

For diagnosis, locate the first source-to-output disagreement, distinguish plausible causes with evidence, and apply the smallest correction within the requested scope. Report observed verification separately from proposed checks.

## References

Read only the relevant modules; [the reference guide](references/00_README.md) also routes common symptoms.

- [Source contracts and derived state](references/source-contracts-and-derived-state.md): grain, authority, semantic evolution, reproducibility, freshness, deletion, and consumer handoffs.
- [Batch, stream, and window semantics](references/batch-stream-window-semantics.md): batch bottlenecks, Beam event time, panes, state, temporal joins, and late-data diagnosis.
- [CDC, outbox, and replay](references/cdc-outbox-and-replay.md): consistent bootstrap, ordering/retention, recovery/effect scope, reseeding, and historical rebuild.
- [Orchestration and idempotent publication](references/orchestration-idempotent-publication.md): Airflow task control, deterministic intervals, durable artifacts, uncertain outcomes, and complete-version visibility.
- [Quality, lineage, and table formats](references/quality-lineage-table-formats.md): distinct dbt shape/content/freshness assurances, OpenLineage evidence, Iceberg table state, Parquet files, and Arrow memory/IPC.

## Boundaries and Essential Constraints

System-design owns authority, topology, and cross-system consistency promises; database-engineering owns engine constraints, isolation, plans, WAL, and restore. This skill implements derived temporal state and verifies reconstruction against their snapshot/log guarantees.

ML/CV/NLP owners define feature/label meaning, sampling/splits, prediction-time availability, and model acceptance. RAG-engineering owns corpus-to-retrieval behavior, index compatibility, retrieval evidence, and answer grounding. Supply their source/time/version, quality, and deletion evidence without taking over those semantic decisions. API-contract-engineering owns public HTTP/OAS/dialect/serialization behavior; dataset shape does not replace its wire contract. SRE owns SLO and incident policy; this skill supplies lag, state, freshness, reconciliation, and rebuild evidence. Broader code lifecycle and infrastructure delivery go to the software/platform owners when needed.

Scope exactly-once claims to the actual progress/state/effect boundary. A checkpoint cannot undo an arbitrary external effect. Keep Beam pane triggers separate from Airflow task trigger rules, and keep structural checks, content assertions, freshness, lineage, table state, file bytes, and memory guarantees distinct.

Preserve current deletion and access restrictions through replay, publication, and rollback. A retained version is not automatically eligible to serve. Use the installed implementation and targeted primary documentation for version-sensitive syntax and guarantees; missing details call for a focused refresh.

Deliver the requested implementation, design, or diagnosis with its affected contract, chosen mechanism and tradeoff, observed evidence, recovery behavior, and material limits. For a narrow change, this can be a short record; reuse existing artifacts.
