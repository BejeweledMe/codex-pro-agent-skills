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

## Prove The Executed Representation

For a low-bit, sparse, or otherwise compressed candidate, inspect the exported
artifact and a representative target-runtime operator trace. Record operator shape,
layout, stored representation, compute/accumulation dtype, kernel dispatch, and any
conversion or fallback. An artifact label does not prove the execution path.

| Representation | Evidence and failure branch |
|---|---|
| Weight-only low-bit | Show packed residency and the actual unpack/dequantize plus compute path. Floating-point compute can be intentional; judge its bandwidth savings and conversion cost rather than assuming end-to-end integer execution. |
| Low-bit weights and activations | Check calibrated ranges, operator coverage, casts/reformats, accumulation, and floating-point fallback. Concentrated unsupported operations can dominate the critical path. |
| Unstructured sparse | Require a materialized sparse format and supported sparse dispatch. Include index/metadata bytes and irregular access cost; a zero mask executed by a dense kernel provides no sparse compute proof. |
| Structured pruning | Verify that reduced exported shapes execute efficiently on the target dense kernels; zeroing channels without changing execution shape does not prove savings. |
| N:M sparse | Verify the exact exported pattern plus supported dtype/layout/shape/kernel. Sparse hardware peak claims do not establish whole-request speedup. |
| Low-rank factors | Confirm that factors execute directly and measure their intermediate traffic and launches. Reconstructing the dense tensor can erase the intended runtime benefit. |

Compare serialized size, resident/peak memory, metadata/scales, load time, transfers,
fallback and conversion time, prefill, decode, and end-to-end goodput at a common
quality floor. State dense/sparse and precision conventions when using hardware
rates. Re-measure composed transformations rather than multiplying their individual
speedups.

For sparse storage, compare values plus indices, scales, alignment, and other metadata
against the dense representation. For execution, find the measured break-even across
shapes and densities, including metadata decoding and irregular accesses. Storage
break-even does not imply latency break-even.

If an exported model uses dynamic routing or early exit, measure gate cost, path
distribution, worst-case quality, batching effects, and tails. Average work saved
alone does not establish capacity under a difficult-request mix.

If a smaller artifact is slower, identify whether conversion/fallback, unsupported
shapes, state movement, or a non-model stage dominates. Use a supported export/kernel
or retain higher precision for the affected operation; return to the previous bundle
if the target benefit does not survive the complete request path. Reduced residency
can still be a valid capacity gain, but label it as such and verify the resulting
concurrency, fairness, and tails.

Revalidate task/domain, structured-output/tool, long-generation, and long-context
slices, including the supported adapter combinations and hard boundary cases. Use
representative calibration data where the method needs it. Behavior gates belong to
the evaluation owner; runtime contributes the exact exported path and performance
evidence for those gates.

## KV-Cache Specific Rules

KV cache consumes capacity with active sequence length and concurrency, so cache
quantization can enable more active work. It can also shift error toward long contexts
or specific attention patterns. Test context-heavy, retrieval-heavy, tool-output, and
structured-output cases separately; monitor cache occupancy, eviction/offload events,
OOM/rejects, TTFT, decode rate, and P99. Keep a previous precision/runtime route for
rollback.

Use `$nlp-modeling-and-adaptation` for quantized training choices such as QLoRA; this
file owns quantization of the deployed inference route.

If the candidate requires changed training execution or QAT, pass its required
representation and export semantics to `$neural-training-systems`, with objective
and quality decisions retained by the model owner. Receive an executable artifact
and validate target dispatch here; no training-step or checkpoint procedure is needed
in this reference.
