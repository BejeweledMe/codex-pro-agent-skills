# Serving Release And Operations

## Serving Bundle

Record model/base precision, tokenizer/template, adapter, runtime/build, scheduler,
parallelism/topology, limits, cache policy, route, prompt/policy, and evaluation
report together. A runtime-only rollback is unsafe if a compatible template or adapter
is no longer available.

## Release Gate

- Workload classes and target TTFT, decode, end-to-end, throughput, and cost:
- Capacity assumptions and memory/KV evidence:
- Task/format/long-context quality comparison with previous bundle:
- Scheduler/admission/fairness/deadline/cancellation behavior:
- Error, OOM/reject, eviction, and fallback observations:
- Canary scope, stop condition, previous verified route, rollback owner:

Use `$agent-llm-evals` for behavior regression harnesses,
`$sre-reliability-engineering` for SLO/incident operation, and `$llm-system-design`
for product-level route and degradation decisions.
