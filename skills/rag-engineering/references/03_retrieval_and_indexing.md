# Retrieval And Indexing

## Embedding And Index Contract

Treat embedding model and revision, query/document formatting, pooling, normalization, similarity, vector dimension, index type, filters, and ANN settings as a compatible bundle. Rebuild instead of silently mixing vectors from incompatible bundles.

## Baselines

Use exact retrieval on a tractable sample to distinguish an approximate-search loss from a representation loss. Sparse retrieval is an important baseline for identifiers, dates, numbers, negation, and exact terminology; dense retrieval may help paraphrases. A hybrid or fusion method earns its complexity only through measured improvement by slice.

## Candidate Retrieval

Measure candidate recall or hit rate before reranking, plus ranking metrics appropriate to the task such as MRR or NDCG. Track behavior separately for exact, paraphrase, multi-step, no-answer, and access-filtered queries. A high average can hide a critical failure class.

## ANN And Filters

Tune ANN recall, latency, memory, and cost together. Verify that metadata filters are applied before candidate visibility where access requires it. An empty result can mean no matching evidence, an extraction/index failure, a restrictive filter, or an ANN miss; preserve enough trace evidence to distinguish them.

## Migration Rule

When changing embeddings, chunking, normalization, dimension, or ANN configuration, create a new manifest and index. Compare it to the previous bundle, canary it, and make rollback a routing change rather than a destructive rebuild.
