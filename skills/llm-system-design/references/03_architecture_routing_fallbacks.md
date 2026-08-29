# Architecture, Routing, And Fallbacks

## Request Path

Draw the request path explicitly: authentication and tenant resolution, policy and
input validation, route selection, context acquisition, model call or workflow,
output validation, response streaming, audit fields, and fallback. The path should
show which components are synchronous, which side effects are possible, and which
data is available to each stage.

Use `$system-design` for the detailed API, queue, storage, and distributed-system
contracts. This file owns only the LLM-specific composition and decision points.

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
