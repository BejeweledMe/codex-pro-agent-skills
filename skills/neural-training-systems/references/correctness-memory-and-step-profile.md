# Correctness, Memory And Step Profile

## Establish The Affected Update

Inspect a controlled batch after actual preprocessing: shapes, dtypes, layouts,
targets/masks, loss reduction and trainable parameter groups. Check forward,
backward and an optimizer update for finite values, gradient flow and intended
parameter changes. Look for detached tensors, wrong optimizer groups, unintended
gradient clearing, train/eval mismatches or frozen parameters being updated.

Overfitting a tiny clean subset can expose wiring errors when the objective supports
it. Batch-coupled objectives, stochastic targets and negative sampling may need a
modeling-owner diagnostic configuration. Failed memorization is not automatically
an execution defect; successful memorization does not establish generalization or
prove that every larger-scale failure is a systems defect.

Compare controlled updates when adding accumulation or distribution, using the same
effective loss and declared tolerance. Seeds alone do not guarantee identical
reduction order, kernels or data-loader behavior. If execution matches the specified
objective but learning remains poor, return the curves and update evidence to modeling.

## Account For Simultaneous Live State

Record each term's bytes or element count, dtype, lifetime, device/host residency,
replication/sharding and overlap with other allocations at the peak.

| Term | Hidden contributors or diagnostic phase |
| --- | --- |
| Parameters and persistent buffers | Frozen backbone, adapters, master copies, persistent statistics, aliases |
| Gradients | Accumulation, bucket views, temporary copies at backward/reduction |
| Optimizer state | Moments, per-parameter counters and lazy allocation at the first update |
| Saved activations | Microbatch/shape dependence, logits, stochastic masks, retained graphs |
| Transient materialization | Gathered parameters, casts, dense conversion, prefetch, full-state collection |
| Workspaces | Kernel/autotune/compiler scratch, shape-dependent algorithm choice |
| Communication | Buckets, staging, collective scratch and concurrent overlap buffers |
| Allocator and external allocations | Unused reserved blocks, fragmentation, non-framework usage |

Use `M_peak = max_t(sum of distinct resident allocations at time t)`. Do not count
aliases twice or assume every term's separate maximum occurs simultaneously. A sum
of maxima can be a conservative bound when lifetimes are unknown. Dense element
count times bytes per element is an estimate; packed/sparse/padded formats require
their actual metadata and alignment. Declare GB versus GiB and residency.

Framework reserved memory commonly contains live allocations plus reusable space;
do not add its full value to a live-tensor sum. Compare allocated/reserved timelines
with device-level usage. A large difference is a clue, not proof of reclaimable memory.

Measure relevant construction, first forward/backward/update, steady state,
large-shape batches, evaluation and checkpoint staging. Checkpoint size is a separate
inventory: transient activations/workspaces usually disappear at an update boundary,
while RNG, progress, data position and layout must be recoverable.

| OOM phase | Evidence to distinguish causes | Next action |
| --- | --- | --- |
| First forward/backward | Activation, logits, shape and workspace peaks | Microbatch or selective recompute; verify eligible kernels and loss path |
| First optimizer update | Lazy optimizer/master-state allocation | Supported state precision or minimal sharding |
| After many successful steps | Allocation growth, retained graphs/tensors, caches, shape churn | Remove unintended retention or stabilize allocation patterns; remeasure |
| One rank only | Uneven shards, expert routing, rank-specific evaluation/logging/save duties | Correct the offending per-rank peak |
| Evaluation/save/restore only | Full-state gather, evaluation batch, load upcast or staging | Bounded/sharded path appropriate to the operation |

Do not shrink model capacity or add devices until evidence identifies the binding term.

## Trace Dependencies, Not Just Stage Totals

Observe read/decode/tokenize/augment, collate, host/device transfer, forward,
backward, optimizer, collectives and checkpoint work. Synchronization can occur
inside backward or materialization; the trace is not necessarily a serial chain.

Use representative shape distributions and per-rank timelines. Separate startup,
compilation and first-state allocation from steady state, retaining those costs for
short or frequently restarted runs. Time completed device work; synchronizing each
operator can destroy the overlap being measured. Compare profiled and ordinary
windows to detect measurement perturbation.

| Observation | Distinguishing evidence | Candidate action |
| --- | --- | --- |
| Empty device queue | Loader/decode/collate/transfer times and tails; CPU/worker contention | Repair the limiting input stage or bounded prefetch |
| Bandwidth-heavy hot region | Actual bytes, layout and materialization/reuse | Reduce movement or improve fusion/reuse |
| Compute-heavy region | Precision-matched achieved rate, shapes, selected kernels | Improve eligible compute path or batching within the contract |
| Low compute and bandwidth with gaps | Dispatch, tiny kernels, graph breaks, host synchronization | Remove launch/materialization dependencies |
| Collective waits | First late producer, input/compute skew, payload and link evidence | Fix originating delay before tuning collectives |
| Sustained degradation at unchanged shapes | Clocks, power/thermal state, contention or allocation growth | Separate runtime growth from platform health |

Elapsed critical-path time and resource occupancy differ. Overlapped input, compute
and communication durations cannot simply be summed into step latency.

## Feed The Measured Consumption Rate

Estimate demand from actual bytes per local batch and batch frequency across workers;
separate raw reads, decoded tensors and transfer bytes. Inspect metadata requests,
shuffle locality, CPU transformation cost, per-shard skew and tails. Prefetch hides
variance only when average service capacity suffices; it cannot fix a rate deficit.

Tune worker count, pinned buffers, staging or overlap against host capacity and the
measured limiting stage. Sequential shards or local staging may reduce read overhead
but incur preparation/storage costs. Preserve sample coverage and transformation
meaning. Packing, truncation, dropping data or changing augmentation needs the
model/data owner's agreement because it changes the experiment.

Exit with a measured peak or bounded estimate, the first binding dependency and one
causal next action. Source basis: Volume I, Model Training, Optimization Principles
and Hardware Acceleration; Volume II, Distributed Training and fleet data paths.
