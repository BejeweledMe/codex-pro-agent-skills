# Training Performance And Compression

## Compare Useful Time And Cost

State the decision, model/artifact, data/preprocessing, objective, evaluation/critical
slices and quality floor. Record intended differences, shapes, precision, batch/update
semantics, runtime, hardware/topology, warmup/cold rules, sustained duration, repeats,
background load and exclusions. Keep comparison variability where it could change
the decision. A candidate that misses the target within budget remains a failed
outcome, not an excluded timing sample.

Measure updates and useful samples/tokens to target, elapsed calendar time, peak
device/host memory, input/collective exposure and worst-rank tails. Include relevant
queue, staging, compilation, evaluation, checkpoints, failed work, replay, restore
and validation. Use disjoint elapsed boundaries: background copy or communication
may already overlap measured steps.

Allocated accelerator time, compute-active time and productive progress differ.
Multiplying utilization, availability and scaling factors can double-count the same
stalls. Prefer direct time/cost-to-quality; distinguish measured results from projected
steps-to-target or failure rates. Savings need shorter paid runtime, removed/avoided
capacity or another identified economic change. For energy, name chip/node/facility
boundary and measure sustained work; TDP is not run energy.

## Physical Models Guide Experiments

For a defined kernel/phase, `I = operations / bytes_moved` and
`attainable_rate ≤ min(precision_matched_peak, effective_bandwidth × I)`.
Name operation counting, precision, dense/sparse convention, shape/batch and memory
level. Roofline does not predict host dispatch, input, network, queue or quality.

If fraction `p` of an unchanged baseline path improves by `G`, idealized Amdahl
speedup is `1 / ((1−p) + p/G)`. Use this as a bound, then reprofile the actual path.
Do not multiply isolated technique speedups. Match bytes/bits, GB/GiB, link direction
and per-port/aggregate rates; hardware peaks need verified target precision/path.

## Compress Communication With Valid Semantics

Gradient compression changes payload and potentially the optimization trajectory.
For `d` dense FP32 entries and `k` retained FP32 values plus INT32 indices, payloads
are `4d` versus `8k` bytes before extra metadata/exchange costs; the ratio is `d/(2k)`.
This is payload arithmetic, not a network or training speedup.

Ranks can select different supports. Specify shared support, tuple gather/merge,
specialized sparse reduction or another supported exchange; ordinary dense AllReduce
on unrelated compact index/value buffers does not preserve the intended reduction.
Measure selection/encoding, indices/metadata, support overlap, exchange scaling,
merge/decode, temporary buffers and exposed time. Error-feedback residuals become
persistent recovery state; they do not erase traffic or prove unchanged convergence.
Accept only against quality trajectory and total time/cost, using the
[collective contract](parallelism-collectives-and-topology.md).

## Execute The Agreed Transformation

Modeling owns technique/objective/adaptation choices; training implements their
execution and materialized representation. Serving PTQ/calibration and target export
dispatch belong with inference. A measured PTQ quality failure can motivate QAT work
with modeling and training; it does not dictate a universal sequence.

| Transformation | Execution/representation obligation | Failure or displaced cost |
| --- | --- | --- |
| Unstructured pruning | Preserve masks during training; materialize sparse values and indexing for a claimed sparse artifact | Dense zero masks still use dense storage/execution; count metadata and conversion |
| Structured pruning | Physically reduced shapes propagated through dependent operators, followed by agreed training | Resulting shapes may map poorly to dense kernels; verify quality |
| N:M sparsity | Preserve exact grouping pattern and deliver post-export pattern, axis, dtype/layout and metadata | Only matching target operators benefit; compliance alone is not whole-path speed |
| Low-rank factors | Train and execute factors directly; deliver ranks, shapes and factor layout | Dense reconstruction on the hot path can erase gains; intermediate activations and launches matter |
| QAT | Match intended quantization granularity/ranges, rounding/clipping, scales/zero-points, observer/folding behavior and operator coverage | Simulation does not prove integer execution; retain transformation state for resume/export |
| Distillation | Produce standalone student with teacher/data/loss identity | Live teacher weights/forward state or cached-output storage/feed costs belong in the ledger and comparison |
| Early exit/dynamic routing | Materialize gates, thresholds, routes and fallback behavior | Gate cost, batch divergence, hard-input work and path distribution can worsen tails |

For sparse storage, compare retained-value bytes plus indices, row/block/group metadata,
padding and alignment with dense bytes. Storage break-even is not execution break-even:
irregular access, conversion and launch overhead may dominate; no universal sparsity
threshold applies.

For an `m × n` dense matrix replaced with rank-`r` factors, nominal factor storage is
`r(m+n)` elements versus `mn`, before metadata/buffers. Verify that the executable
graph retains factorized operators; measure the rank–quality–memory–latency tradeoff.

For QAT, record quantization semantics and high-precision/unsupported paths for export
parity. Do not infer a format-wide integer path from fake-quant nodes. For distillation,
teacher outputs cached under different preprocessing or teacher identity change the
training contract. Diagnose OOM with those extra states before changing the objective.

If QAT/pruning quality regresses, inspect the transformation schedule, placement and
export semantics and return evidence to modeling; do not prescribe an unsupported
learning-rate/observer remedy or silently lower quality/sparsity targets.

## Representation → Modality Quality → Target Dispatch

1. Retain the baseline and materialize the candidate: graph, weights/adapters, changed
   shapes, masks/factors/sparse layout, quantization metadata, input envelope and
   training configuration. Record conversion assumptions and unsupported paths.
2. Supply both artifacts, data/calibration identities and numerical differences to
   modeling/evaluation. Protect agreed aggregate, slice, calibration, language/format
   or visual quality. Per-route quality and hard inputs matter for dynamic execution.
3. Give the quality-qualified artifact to inference for actual operator/dtype/sparsity,
   fallback, peak-memory and end-to-end performance checks on the target workload.
   Include gate/path frequencies and worst-case work for tail measurement.

Export semantic changes or dense/high-precision fallback return to representation
and modeling work. Apply transformations incrementally and remeasure interactions;
prune/distill/quantize is not a universally valid order. Stop when quality fails,
the claimed target path is unavailable or added training/conversion/operating cost
outweighs the measured gain. Keeping the baseline can be the correct result.

Source basis: Volume I, Model Compression, Hardware Acceleration and Benchmarking;
Volume II, Collective Communication, Distributed Training and Fleet Orchestration.
