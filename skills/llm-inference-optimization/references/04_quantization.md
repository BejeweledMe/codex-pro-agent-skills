# Quantization

## Choose A Representation For A Binding Constraint

Quantization reduces some numeric representation cost, but the relevant target may be
weight residency, memory bandwidth, KV-cache capacity, accelerator throughput, model
load time, or dollar cost. Identify the binding stage first and verify that the chosen
runtime/hardware has an efficient kernel and supported model path. Smaller bytes can
add conversion overhead and make a workload slower.

## Main Choices

| Target | Candidate approach | Validate |
|---|---|---|
| Weights | Weight-only post-training quantization; granularity can be per tensor, channel, or group | Task slices, model load, prefill/decode, memory bandwidth, kernel support |
| Weights and activations | Mixed/lower precision execution or calibration-based quantization | Numerical stability, structured output, long generation, accelerator support |
| KV cache | Lower-precision or compressed cached keys/values | Long-context quality, retrieval/tool-context cases, cache occupancy/evictions, decode tail latency |
| Full serving bundle | Quantized base with adapters/templates/runtime | Compatibility of every artifact, route-level quality, rollback |

Granularity, outlier treatment, calibration data, and runtime kernels change both error
and speed. Do not choose a bit width from a generic benchmark. Compare a full-precision
baseline and candidates on the same model/template, workload mix, context lengths, and
quality slices.

## KV-Cache Specific Rules

KV cache consumes capacity with active sequence length and concurrency, so cache
quantization can enable more active work. It can also shift error toward long contexts
or specific attention patterns. Test context-heavy, retrieval-heavy, tool-output, and
structured-output cases separately; monitor cache occupancy, eviction/offload events,
OOM/rejects, TTFT, decode rate, and P99. Keep a previous precision/runtime route for
rollback.

Use `$nlp-modeling-and-adaptation` for quantized training choices such as QLoRA; this
file owns quantization of the deployed inference route.
