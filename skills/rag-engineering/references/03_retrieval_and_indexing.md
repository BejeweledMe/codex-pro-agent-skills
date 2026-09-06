# Retrieval And Indexing

## Embedding And Index Contract

Treat embedding model and revision, query/document formatting, pooling, normalization, similarity, vector dimension, index type, filters, and ANN settings as a compatible bundle. Rebuild instead of silently mixing vectors from incompatible bundles.

## Baselines

Use exact retrieval on a tractable sample to distinguish an approximate-search loss from a representation loss. Sparse retrieval is an important baseline for identifiers, dates, numbers, negation, and exact terminology; dense retrieval may help paraphrases. A hybrid or fusion method earns its complexity only through measured improvement by slice.

## Candidate Retrieval

Measure candidate recall or hit rate before reranking, plus ranking metrics appropriate to the task such as MRR or NDCG. Track behavior separately for exact, paraphrase, multi-step, no-answer, and access-filtered queries. A high average can hide a critical failure class.

## ANN And Filters

Tune ANN recall, latency, memory, and cost together. Verify that metadata filters are applied before candidate visibility where access requires it. An empty result can mean no matching evidence, an extraction/index failure, a restrictive filter, or an ANN miss; preserve enough trace evidence to distinguish them.

Separate representation error, approximation error and physical retrieval cost.
Use the same eligible corpus/query set to compare an exact candidate baseline, ANN
candidate recall and the final reranked result. Inspect vector/index working set,
random reads, filter selectivity, cache state and candidate count before changing
the embedding model or adding a reranker. A faster search with lost authorized
evidence is not an equivalent improvement.

Contextual retrieval is a candidate: attach a bounded document-derived context
description to a chunk before embedding and lexical indexing (such as BM25) when
isolated chunks lose important meaning.
Keep the original text and locator separately, record enrichment/model/template
versions and constrain the parent context to the same access boundary. Generated
context is a retrieval aid, not a new authoritative source. Compare against
unenriched chunks for recall, grounded answers, access correctness, cost and
rebuild effort; reject enrichment that invents context or leaks restricted material.

## Migration Rule

When changing embeddings, chunking, normalization, dimension, or ANN configuration, create a new manifest and index. Compare it to the previous bundle, canary it, and make rollback a routing change rather than a destructive rebuild.

Reapply current deletions and authorization changes before exposing either a
rebuilt index or a rollback target. A previously valid snapshot can reintroduce
removed content or access. Carry source identity and deletion/access change
position through derived chunks, enrichment, embeddings, caches and replicas;
verify representative removals and denied-access queries after the switch.
A logical tombstone is not by itself proof of physical erasure from every copy.
