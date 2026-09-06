# Precision, Batching, Recompute And Compilation

Use after identifying the binding term or dependency. Preserve a baseline, test one
causal change and measure the cost transferred to compute, memory, communication,
startup or optimization steps.

| Binding evidence | Candidate | Cost to verify |
| --- | --- | --- |
| Saved activations | Smaller microbatch or selective recompute | Extra sequential work and batch-dependent behavior |
| Persistent state | Supported precision or minimal sharding | Numerical sensitivity, gathers and restart layout |
| Transient gathers | Smaller materialization units or less prefetch | More launches/collectives and reduced overlap |
| Workspace/shape churn | Shape buckets or supported allocator/kernel changes | Padding, data order, workspace and compile variants |
| Movement or launch overhead | Fusion, compilation, reuse or eligible IO-aware kernels | Conversion, graph coverage, compilation and retained memory |
| Input stalls | Measured pipeline/staging/overlap change | Host resources, preparation time and consumed-data semantics |

Changing optimizer algorithm, architecture, resolution, sequence truncation or
adaptation changes the modeling experiment; send the measured constraint and option
to its owner rather than silently substituting it.

## Precision Contract

Record working weights, gradients, optimizer/master state, activations, reductions
and communication dtypes separately. Frozen low-bit base weights do not imply that
adapter gradients, activations and optimizer state use that format.

Inspect supported low-precision operators and numerically sensitive higher-precision
paths. Compare finite inputs/loss, gradient norms, saturation and skipped updates
against the baseline. Where loss scaling is used, verify scale/unscale around the
actual accumulated gradient and clipping of the intended unscaled gradient. Track
overflow, completed updates, scheduler advancement and scaler checkpoint state.

If NaN/Inf or stagnation follows a precision change, locate the first affected
operator/state and restore a stable path or revert. Format names alone do not prove
the need for a particular scaling/master-copy recipe. Inspect the actual pinned
implementation and numerical evidence. Confirm selected kernels and conversion costs
before assigning a gain to a requested dtype; skipped updates are not useful speed.

## Effective Loss And Update

For equal-sized independent microbatches,
`B_effective = B_micro × accumulation_steps × data_parallel_replicas`.
Tensor and pipeline ranks are not additional independent data replicas.

Sample count alone does not prove gradient equivalence. Preserve the intended
weighted-loss denominator across microbatches and replicas; variable valid-token
counts, padding, ignored labels and unequal final batches can make an average of
local means wrong. Account for sum versus average reduction without normalizing twice.

Check where gradients clear, accumulate, reduce, unscale and clip; when synchronization
occurs; how partial windows finish; and when optimizer/schedule counters advance.
Schedules may be defined in updates, samples, tokens or epochs. Ranks must agree on
skip/overflow behavior and collective participation under the supported mechanism.

Compare a controlled update, then real learning behavior. Accumulation may differ
from a physical batch for BatchNorm, in-batch negatives, batch-coupled objectives
and stochastic operations. A correct gradient implementation can still require more
updates at a larger effective batch; retuning belongs with modeling and fresh
time-to-quality evidence.

## Selective Recomputation

Activation checkpointing discards selected saved intermediates and reruns forward
regions during backward. Choose boundaries from bytes saved versus recompute cost.
Inspect RNG behavior, mutable state/side effects, autocast and autograd support so
re-execution does not change the intended function or update state twice.

Measure saved activation peak, extra compute/launches and possible extra parameter
gathers under sharding. A lower activation peak can expose an optimizer or gather
peak. Activation checkpointing saves within-step memory; it is not durable recovery.

## Compile A Reusable Hot Path

Compilation/fusion can reduce launches and intermediate materialization. Inspect
graph breaks, shape guards, recompilation, fallback and forward/backward/optimizer
coverage. Forward-only success does not establish a faster training update.

For a stable compiled variant, a break-even hypothesis is
`remaining_steps × (baseline_step_time − compiled_step_time) > exposed_compile_cost`.
Include additional variants, cache memory and restarts when present. Measure cold and
steady timing, peak memory and representative dynamic/stochastic paths against eager
execution. Keep numerical differences within the declared tolerance.

IO-aware exact attention can reduce traffic and avoid large attention intermediates;
dense attention's quadratic arithmetic in sequence length remains. Verify actual
masks, shapes, dtype, dropout, backward support and selected kernel. Shape bucketing
can improve reuse but adds padding and may change order; packing/truncation also
changes data semantics.

Recheck the affected update, finite/skipped behavior, peak device/host memory,
cold/steady timing and quality guardrails. Verify resume when persistent state or
update boundaries change. Source basis: Volume I, ML Frameworks, Model Training,
Optimization Principles and Hardware Acceleration.
