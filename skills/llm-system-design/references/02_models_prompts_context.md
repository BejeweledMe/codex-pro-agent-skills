# Models, Prompts, And Context

## Model Portfolio Before Model Loyalty

Filter candidates by hard constraints first: allowed data placement, license and
contract terms, language/modality, context and structured-output requirements,
availability, and operational ownership. Then compare a small shortlist on the
actual task slices. A portfolio may contain a default route, a stronger route for
hard cases, and a deterministic or human fallback.

This skill decides which existing model/provider route serves a product request.
If the question is whether to change weights, tokenizer, or embeddings, hand it to
`$nlp-modeling-and-adaptation`. If a self-hosted candidate must meet a capacity
contract, hand it to `$llm-inference-optimization`.

## Prompt And Context Contract

Version system instructions, user-input framing, tool policy, template, structured
output schema, context assembly policy, token limits, and post-validation. Separate
trusted control instructions from untrusted retrieved text or tool output. Context
is a limited resource: allocate tokens deliberately among policy, task state,
evidence, examples, and answer budget.

Define behavior when the context is absent, exceeds the budget, conflicts, or is not
authorized. Do not silently truncate material evidence and then present the answer
as complete.

## Routing

Routing rules must be inspectable. For each route, record its match condition,
selected model/provider, context/output limits, timeout, cost and latency budget,
fallback, and owner. Prefer deterministic routing signals before an LLM router when
they are sufficient. Evaluate routing errors separately from model errors.
