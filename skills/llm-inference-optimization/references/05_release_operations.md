# Serving Release And Operations

## Serving Bundle

Record model/base precision, tokenizer/template, adapter, runtime/build, scheduler,
parallelism/topology, limits, cache policy, route, prompt/policy, and evaluation
report together. A runtime-only rollback is unsafe if a compatible template or adapter
is no longer available.

Include the actual exported representation/operator support, admission/retry policy,
and state/cache compatibility in the attributable bundle. The runtime supplies this
execution contract and its evidence; `$ai-platform-llmops` owns registry integration,
fleet rollout, controller scaling, and routing implementation.

## Release Gate

- Workload classes and target TTFT, decode, end-to-end, throughput, and cost:
- Class-specific completed-request goodput, quality/policy evidence coverage, offered
  demand, and explicit metric/error denominators.
- Capacity assumptions and memory/KV evidence:
- Actual operator path, per-rank peak memory, representative service curves, and
  measured cold/load/warm/readiness behavior.
- Task/format/long-context quality comparison with previous bundle:
- Scheduler/admission/fairness/deadline/cancellation behavior:
- Queue and retry bounds, prediction misses, overload recovery, and state reclamation.
- Error, OOM/reject, eviction, and fallback observations:
- Canary scope, stop condition, previous verified route, rollback owner:

Use evidence proportionate to the change. For a serving-capacity claim, cover normal
load, the hard prompt/output and tenant slices, cache misses, bursts beyond admission,
and recovery after load falls. Verify that cancellation frees execution/state capacity
and that a failed or cold replacement does not turn retries into continuing overload.

Before traffic expansion, verify the correct model/template/adapter/runtime is loaded,
initialized, allocated, and warmed as required by the deployed runtime on the actual topology. A live process or successful
health response alone does not establish useful serving readiness. Retain replacement
and rollback capacity assumptions with the platform owner.

Set runtime stop conditions against the declared class goodput, tails, quality gates,
OOM/reject/preemption, and fairness contract. A smaller canary limits immediate
exposure; it does not establish enough evidence for rare failures or delayed quality
outcomes. Record observation duration and sample coverage for the claims being made.

For rollback, verify that the previous executable bundle, compatible cache/session
handling, and route remain available. Drain or cancel in-flight work according to its
contract; invalidate or rebuild incompatible KV/prefix state. Preserve current access
and tenant restrictions when restoring an older bundle. Verify the restored version,
warm execution, class outcomes, and state cleanup. Rebuilding a cold compatible cache
can be a valid rollback path; keeping all previous cache entries resident is not
required. Supply session/version and drain constraints for bounded mixed-version
operation; fleet rollback is not an instantaneous global switch. Hand fleet
coordination to AI platform and incident decisions to SRE.

Use `$agent-llm-evals` for behavior regression harnesses,
`$sre-reliability-engineering` for SLO/incident operation, and `$llm-system-design`
for product-level route and degradation decisions.

## Evidence Basis And Refresh

The mechanisms here draw on *Machine Learning Systems*, Volume I, on compression,
benchmarking, serving, and release; Volume II, especially “Performance Engineering,”
“Inference at Scale,” and “ML Operations at Scale”; and the vLLM runtime/metrics and
NVIDIA Triton/AI Perf documentation on execution and metric semantics.

Use these as mechanism guidance. Exact engine flags/defaults, model/kernel coverage,
quantization or sparse dispatch, metric names, and platform integrations require
release-matched primary documentation and target measurements. There is no portable
batch size, utilization target, GPU sharing factor, scaling threshold, or speedup
constant established by these sources.

Refresh the relevant evidence when the model/tokenizer/template/adapter, runtime or
kernel, precision, hardware/topology, workload lengths/arrivals, cache/admission/
scheduler policy, or quality contract changes. Reprofile the full path after a gain:
the limiting stage may have moved. Preserve unmeasured version-specific behavior as
an explicit limit on the claim.
