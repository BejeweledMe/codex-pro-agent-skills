# Parallelism, Collectives And Topology

Use the smallest viable full-model baseline when a single-device run cannot fit.
Establish the local constraint and representative per-rank ledger before selecting
a distributed mechanism; do not invent single-device timing for an infeasible model.

## Minimal Sufficient Partition

| Constraint | Candidate | Traffic/state obligation |
| --- | --- | --- |
| State fits; throughput needed | Replicated data parallelism, often DDP | Gradient reduction, global weighting/batch and slowest-rank pacing |
| Persistent state does not fit | Necessary state sharding, using applicable ZeRO/FSDP configuration | Specify sharded states, gathers/reductions, transient peaks and restore layout |
| Layer/operator needs partitioning | Tensor parallelism | Frequent intra-layer collectives, legal partition and verified fast locality |
| Layer stack needs partitioning | Pipeline parallelism | Stage balance, activation transfer, schedule, bubbles and residency |
| Sparse embedding state | Sharded lookup/parameter-server path | Hot keys, cache, sparse update consistency, host capacity and tails |
| Expert state | Expert parallelism | AllToAll, routing skew, expert capacity/drop behavior and quality |
| Several constraints | Justified combination | Overlapping process groups, memory, traffic competition and recovery |

A sharding name is not a fixed memory footprint or universal stage API. Offload
trades device capacity for host memory and transfer dependencies. For rectangular
DP×TP×PP, the product gives rank count; expert/sequence axes can reuse groups, so
specify actual membership rather than multiplying every named degree.

Pipeline bubbles depend on schedule and stage balance. More microbatches can improve
occupancy while changing activation residency and kernel efficiency. Model capacity,
drop policy and learning-policy changes need modeling-owner quality evidence.

## Declare Synchronization Semantics

| Scheme | Permits | Verify |
| --- | --- | --- |
| BSP | Coordinated updates from required participants | Reduction weighting, slowest-rank tails and consistent skip/failure behavior |
| SSP | Bounded progress skew | Enforced staleness, observed lag, convergence and restart |
| Asynchronous updates | Gradients from stale parameter versions | Stale-gradient policy, ordering, quality and coherent recovery state |
| Local SGD | Local updates between global exchanges | Sync interval, drift, steps to target and consistent checkpoint cut |

Reducing synchronization frequency changes optimization semantics. BSP itself does
not guarantee bitwise reproducibility. Keep batch, schedule and acceptable variation
explicit and compare time-to-quality.

## Primitive, Message And Physical Path

AllReduce reduces corresponding elements and returns the result to all participants;
verify sum/average conventions. ReduceScatter distributes reduced partitions;
AllGather assembles partitions. AllToAll exchanges routed partitions; point-to-point
transfers express pipeline dependencies.

For each group, record ranks, operation order, dtype/shape, payload, frequency,
producer readiness and consumer dependency. A hang can result from divergent flow,
mismatched shapes/order, stale membership or a missing rank. Increasing a timeout
does not fix those defects.

Map groups to devices, hosts, links and shared cuts. High-frequency TP traffic is a
candidate for the fastest local domain, PP needs stage-neighbor bandwidth, DP needs
scale-out capacity, and expert exchange needs bisection/skew evidence. Confirm with
the real traffic matrix and representative placement measurements. Free GPU count,
port labels or oversubscription ratios alone do not predict job performance.

The first-order transfer model `T(M) ≈ alpha + M/beta` uses effective startup and
bandwidth; rounds, cuts and congestion remain separate. Rings are hypotheses for
large dense payloads, trees/recursive algorithms for smaller latency-sensitive
messages, hierarchy for tiered links. A dense ring AllReduce sends approximately
`2(N−1)M/N` bytes per rank for an M-byte input; this is algorithmic volume, not a
physical lower bound or wall-time formula. Verify the implemented algorithm.

## Prove Useful Overlap

Identify the first late producer on per-rank traces. Separate waiting for participation,
collective execution and work hidden behind compute. Bucket fusion reduces startup
frequency but may delay readiness and increase buffer memory. Concurrent compute
and communication may contend for bandwidth; async APIs do not prove useful overlap.

Use matched windows and dependency traces, not a simple subtraction of unrelated
compute-only timing. Remeasure worst-rank/full-update latency after changing groups,
buckets or placement. Capture stacks/membership for hangs before bounded recovery;
send hardware/link/thermal degradation evidence to platform.

## Scaling And Platform Exchange

Distinguish fixed-global-work strong scaling from fixed-per-replica-work weak scaling.
`T1/(N × TN)` is strong-scaling efficiency only for the identical workload that fits
one worker. Report batch/accumulation, shapes, precision, schedule and data coverage.
More steps/s may still need more updates or incur greater queue/recovery cost.

Supply `$ai-platform-llmops` with the minimum viable gang, indivisible model-parallel
groups, per-rank CPU/memory/I/O, traffic/locality alternatives, checkpoint bursts and
exit/recovery cost. Fixed synchronous jobs require a whole viable group to progress;
platform implements admission/placement. Compare compact-placement waiting against
its measured runtime benefit. Connect changed membership/layout to
[checkpoint recovery](checkpoint-consistency-and-recovery.md) before calling it elastic.

Source basis: Volume II, Distributed ML Principles, Distributed Training, Collective
Communication and Fleet Orchestration. Current launch/collective/resharding controls
require the pinned implementation's documentation.
