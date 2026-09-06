# Architecture, Routing, And Fallbacks

## Request Path

Draw the request path explicitly: authentication and tenant resolution, policy and
input validation, route selection, context acquisition, model call or workflow,
output validation, response streaming, audit fields, and fallback. The path should
show which components are synchronous, which side effects are possible, and which
data is available to each stage.

Use `$system-design` for service boundaries, queues, storage, and distributed
guarantees; use `$api-contract-engineering` for HTTP/OpenAPI artifacts and
observable consumer compatibility. This file owns LLM product composition and
the requirements handed to those implementations.

Pass the workload, compatible bundle, quality/latency/cost envelope, current
authority, and recovery constraints to `$ai-platform-llmops` for registry,
placement, replica/controller policy, and fleet operation. Runtime request
execution belongs to `$llm-inference-optimization`; neural update, memory,
collective, and coherent training-restart mechanics belong to
`$neural-training-systems`. Load only the owner of an unresolved decision.

## Product Budgets

Set a budget for the completed user task, not merely a model call. Split it into
request queueing, context work, model time to first token, completion, validation,
and downstream actions. Pair cost limits with token/context/output caps and route
selection. A product-level budget determines acceptable degradation; it does not
tell a runtime engineer how to tune kernels or KV cache.

## Graceful Degradation

Specify a user-visible response for provider failure, rate limit, timeout, missing
context, overload, invalid structured output, or an unavailable tool. Possibilities
include a smaller verified model, a narrower read-only path, cached/stale content
clearly marked as such, a deterministic answer, deferred work, human handoff, or an
explicit inability to complete the task. Preserve access and policy rules in every
fallback.

Release a route change with a previous verified route available. Measure success,
fallback activation, error reasons, task abandonment, latency/cost, and segment
outcomes before expanding traffic.
