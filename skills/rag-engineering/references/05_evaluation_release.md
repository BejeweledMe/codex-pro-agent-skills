# Evaluation, Observability, And Release

## Evidence Set

Build qrels or equivalent evidence labels from representative production-like cases. Keep query, expected document or evidence, access class, no-answer expectation, and source version. Add a redacted production failure only after an owner confirms expected behavior.

## Measure By Stage

Use extraction checks, candidate recall/hit, MRR/NDCG where ranked evidence exists, rerank movement, context coverage, citation validity, supported-answer quality, abstention precision/recall, access correctness, P50/P95/P99 latency, and cost. The exact metric and threshold follow the answer contract and risk; no bundled number is universal.

## Experiments

Compare one explicit hypothesis at a time on a fixed corpus snapshot and query set. Record configuration, artifact versions, data split, evaluation protocol, quality by slice, latency/cost, rejected alternative, and what would falsify the choice.

## Release

Release the index and its dependent configuration as a bundle. Use shadow, canary, or limited routing when risk warrants it. Define fallback to a verified prior index or simpler retrieval path, rollback trigger, owner, and how an affected answer is investigated.

Use `$agent-llm-evals` for the harness, graders, calibration, CI placement, and regression gates. Use `$genai-security-testing` for an authorized test of ACL, injected content, or data-flow boundaries.
