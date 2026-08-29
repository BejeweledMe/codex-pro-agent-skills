# Templates

## Index Manifest

Record: corpus snapshot and owner; source/extraction/chunking versions; metadata and access schema; embedding/query/document contract; similarity and ANN configuration; retrieval/rerank/context policy; evaluation set and result; creation time; rollback target.

## Stage Diagnosis

Record: user-visible symptom; expected evidence; caller/access class; last correct stage; first broken transition; trace IDs and artifact versions; minimal discriminating experiment; proposed change; quality/latency/cost guardrails; fallback and owner.

## Release Decision

Record: changed bundle fields; query slices; stage and final metrics; access/citation results; tail latency and cost; canary scope; rollback trigger; owner; residual risks. A release without a prior recoverable bundle is not reversible.
