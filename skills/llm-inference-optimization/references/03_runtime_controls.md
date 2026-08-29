# Runtime Controls

## Batching And Scheduling

Compare static, bounded dynamic, and continuous batching on the real length mix. More
throughput can increase queue delay, head-of-line blocking, starvation, or tail
latency. Record token/sequence budgets, maximum wait, priority behavior, cancellation,
preemption, and fairness. Admission control must reject, defer, or route overload
predictably rather than accept requests until memory failure.

## Remove Wasted Work First

Before changing model precision or topology, test whether the workload can use bounded
context/output limits, prefix/cache reuse, an appropriate smaller verified route,
request deduplication, constrained output, or removal of redundant calls. Preserve
product correctness and authorization when caching or routing.

## Execution And Topology

Choose runtime, compilation, parallelism, cache/offload, and accelerator topology from
the actual bottleneck, model format, hardware support, operational visibility, and
failure recovery. Data, tensor, pipeline, and sharding strategies exchange memory
pressure for communication, scheduling, and recovery complexity. Measure per-rank
memory, communication time, step/request variance, failure behavior, and quality; do
not choose topology from parameter count alone.

Speculative decoding is a throughput/latency experiment: measure accepted-token rate,
draft-model overhead, workload distribution, and final-output quality. It is not a
universal speedup.
