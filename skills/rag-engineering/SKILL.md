---
name: rag-engineering
description: Use when designing, implementing, reviewing, debugging, evaluating, or operating retrieval-augmented generation systems. Trigger for ingestion, OCR, chunking, metadata and provenance, embeddings, sparse/dense/hybrid retrieval, ANN, reranking, context assembly, citations, abstention, GraphRAG, agentic retrieval, index versioning, or stage-by-stage RAG diagnosis.
---

# RAG Engineering

Treat RAG as a diagnosable pipeline, not a prompt. Locate the first broken transition in `source -> extraction -> chunk -> candidate retrieval -> rerank/context -> answer` before tuning a later component.

## Core Rules

- Start with the answer, citation, no-answer, corpus-ownership, freshness, access, latency, and cost contracts.
- Build an inspectable baseline before GraphRAG, agentic retrieval, a new vector database, or a new embedding model.
- Version extraction, chunking, metadata schema, embedding/query mode, normalization, similarity, index, and ANN configuration as one index manifest.
- Measure candidate retrieval before reranking and generation. A reranker cannot recover a document that never entered the candidate pool.
- Keep source/version/access provenance with every chunk and enforce access before retrieval. Route adversarial or ACL-boundary testing to `$genai-security-testing`.
- Pair quality gains with tail latency, cost, index/update complexity, fallback, and rollback evidence. Do not prescribe universal chunk sizes, `k`, fusion weights, or ANN parameters.

## Reference Routing

Read only the files needed for the request.

- Start with [operating model and diagnosis](references/01_operating_model_and_stage_diagnosis.md) for every broad RAG design or failure investigation.
- For extraction, OCR, structure, chunking, metadata, provenance, deletion, and corpus updates, read [ingestion and chunking](references/02_ingestion_chunking_metadata.md).
- For embeddings, exact baselines, sparse/dense/hybrid retrieval, ANN, filters, and index migrations, read [retrieval and indexing](references/03_retrieval_and_indexing.md).
- For reranking, context selection, citations, abstention, GraphRAG, and agentic retrieval, read [context and advanced RAG](references/04_context_advanced_rag.md).
- For qrels, stage metrics, traces, experiments, release, and rollback, read [evaluation and release](references/05_evaluation_release.md), then use `$agent-llm-evals` for harness and grader mechanics.
- For design, manifest, diagnosis, and release templates, read [templates](references/06_templates.md).

## Workflow

1. Classify the work: new system, stage diagnosis, retrieval comparison, corpus/index change, or advanced-RAG decision.
2. Record the corpus and answer contracts, representative query slices, current index manifest, and the last stage where correct evidence is visible.
3. Establish a simple baseline with verified extraction and exact or sparse retrieval where applicable.
4. Change one causal layer at a time and compare on fixed query/evidence cases. Preserve an immutable previous index bundle.
5. Use `$agent-workflows` only when the search route or tool sequence is genuinely unknown; use `$system-design` for storage, APIs, and platform capacity.
6. Release through shadow or canary traffic with an explicit fallback retrieval path, owner, and rollback trigger.

## Output

For a design or review, include the answer contract; corpus ownership and access policy; stage architecture and failure map; index manifest; retrieval and context alternatives; stage metrics; trace fields; latency/cost assumptions; security handoffs; release, fallback, rollback, owner, and next experiment.

For a diagnosis, lead with the last correct stage, the first broken transition, the evidence supporting that conclusion, and the smallest discriminating experiment.

## Quality Bar

- Do not solve a retrieval failure with prompt changes before checking extraction, chunk boundaries, filters, and candidate recall.
- Do not mix incompatible embedding/index settings or overwrite a proven index in place.
- Do not use GraphRAG for a simple local fact, or agentic retrieval for a fixed single lookup, without measured need.
- Do not treat a citation string as grounding without validating that it points to supplied evidence.
- Mark ideas outside the bundled references as `external extension`.
