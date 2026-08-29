# RAG Engineering References

Use these references to make component decisions, not to turn a RAG design into a list of fashionable components.

## Route

- `01_operating_model_and_stage_diagnosis.md`: answer contract, stage map, baseline, and first-broken-stage investigation.
- `02_ingestion_chunking_metadata.md`: extraction/OCR, source structure, chunk hypotheses, provenance, access, and update/delete behavior.
- `03_retrieval_and_indexing.md`: embedding contract, sparse/dense/hybrid search, exact baseline, ANN, filters, and index migrations.
- `04_context_advanced_rag.md`: reranking, context assembly, citations/abstention, GraphRAG, and agentic retrieval gates.
- `05_evaluation_release.md`: qrels, component metrics, traces, experiments, release, fallback, and rollback.
- `06_templates.md`: reusable design, manifest, diagnosis, and release-decision shapes.

## Companion Boundaries

- `$agent-llm-evals` owns harnesses, graders, calibration, CI gates, and regression operations.
- `$genai-security-testing` owns authorized ACL, injection, data-flow, and tool-security testing.
- `$agent-workflows` owns action loops and tool orchestration.
- `$system-design` owns generic storage, API, and distributed-system contracts.
