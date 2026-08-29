# Context, Grounding, And Advanced RAG

## Reranking And Context

Rerank only a bounded candidate pool and prove that the desired chunk is present before blaming the reranker. Measure pre-rerank recall, post-rerank ranking quality, pair or request latency, context-token cost, and final supported-answer quality.

Context assembly needs diversity, deduplication, ordering, parent expansion where necessary, and a bounded budget. More chunks can dilute evidence or crowd out the needed section. Treat context-policy changes as versioned release changes.

## Citations And Abstention

Validate that citations resolve to supplied context IDs and that the cited material supports the claimed statement. Where the evidence is absent, contradictory, stale, or below the answer contract, prefer a bounded corrective retrieval attempt, an explicit abstention, or a human handoff over an unsupported answer.

## GraphRAG

Graph extraction, entity linking, relation confidence, source provenance, update cost, and retrieval behavior form one system. Use local entity expansion for entity-centred questions and corpus-wide synthesis only when it is required. Noisy edges must not become facts merely because they are traversable.

## Agentic Retrieval

Use a bounded retrieval loop when a query needs dynamic decomposition, multiple sources, or evidence checking. Set retry, token, cost, and deadline limits; capture every query and evidence transition. For a fixed lookup, ordinary retrieval remains the safer baseline.
