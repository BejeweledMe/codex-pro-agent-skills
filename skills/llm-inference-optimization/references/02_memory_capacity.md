# Memory And Capacity

## Account For More Than Weights

Capacity includes model weights, KV cache, runtime/allocator overhead, temporary
activations/workspace, request buffers, adapters, and replication or parallelism
effects. Context length, completion length, active sequences, and cache policy compete
for the same capacity. Use estimates to form hypotheses, then verify them with runtime
telemetry.

For a standard multi-head attention approximation, KV-cache bytes scale roughly with
`2 * active_sequences * tokens_per_sequence * layers * kv_heads * head_dim *
bytes_per_element`. Architectures with grouped/multi-query attention, paging, sharing,
or compression change the constant; do not use the approximation as an admission rule
without measuring the deployed runtime.

## Capacity Procedure

1. Fix the workload classes and service limits: maximum context/output, concurrency,
   request deadline, priority/fairness rule, and overload behavior.
2. Measure weight residency, real peak memory, KV occupancy, evictions, rejected/OOM
   requests, queueing, TTFT, decode rate, and quality per class.
3. Decide whether the constraint is capacity, tail behavior, cost, or a non-memory
   stage. Then test the smallest targeted lever.

More context or concurrency is not free capacity. If a user contract requires both,
plan an explicit route, limit, or degraded response rather than relying on an OOM retry.
