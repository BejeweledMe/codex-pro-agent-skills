# Memory And Capacity

## Account For More Than Weights

Capacity includes model weights, KV cache, runtime/allocator overhead, temporary
activations/workspace, request buffers, adapters, and replication or parallelism
effects. Context length, completion length, active sequences, and cache policy compete
for the same capacity. Use estimates to form hypotheses, then verify them with runtime
telemetry.

For a conventional attention cache with equal key/value dimensions, logical KV bytes
are approximately
`2 * layers * kv_heads * head_dim * bytes_per_element * sum(retained_tokens_per_sequence)`.
For equal sequence lengths, the sum becomes
`active_sequences * tokens_per_sequence`. Use the actual KV-head count for
grouped/multi-query attention. Sliding windows, layer-specific state, prefix sharing,
paging, compression, and rank sharding/replication require an adjusted ledger.
Logical bytes omit page slack, metadata, quantization scales, and allocator effects;
do not use the approximation as an admission rule without measuring the deployed
runtime.

Maintain the ledger per rank/device as well as per replica. One rank can exhaust
memory while aggregate free memory appears adequate. Distinguish live allocations,
reserved pools, usable free blocks, and temporary peaks; identify whether KV capacity
is preallocated or grows on demand. State GB versus GiB.

Measure communication/request buffers, adapter combinations, cold compilation and
warm execution workspace, eviction/offload/recomputation, and cancellation cleanup.
Reserve measured headroom for variability and recovery. Platform capacity planning
also needs the footprint of simultaneous old/new bundles during replacement or
rollback; spare memory in a running replica does not prove that replacement fits.

## Per-Phase And Per-Precision Ledger

| Entry | Prefill | Decode | Precision and placement evidence |
|---|---|---|---|
| Weights | Resident or loaded as required | Reused across iterations | Stored weight format, compute/accumulation dtype, rank sharding or replication, scales/metadata |
| KV/state | Prompt state written or reused | State grows with generated tokens for each live hypothesis | KV dtype is independent of weight dtype; actual layer/head/rank layout, page slack, shared blocks, retained prefixes |
| Activations/workspace | Shape/chunk-dependent peaks | Per-iteration work across active sequences | Activation dtype, attention/temporary workspace, graph capture and compilation buffers |
| Runtime/adapters | Pools, buffers, loaded adapters | Same plus changing active adapter mix | Live versus reserved pools and adapter workspace; allocator behavior |
| Communication and offload | Collective/transfer buffers and staging | Repeated collectives, KV movement, reloads | Actual placement of host/device buffers, duplication, overlap and peaks |
| Speculation | Draft weights and initialization | Draft/verifier KV and verification workspace | Separate artifact, dtype, and residency entries; rejected draft work still consumes resources |

Map each component to its actual owner rank. KV may be sharded, replicated, or
partitioned differently from weights; neither a uniform head slice nor division by
world size is a general per-device fit rule. Beam or branching hypotheses can
increase live state beyond the logical request count. Diagnose reservation and
fragmentation from usable blocks and failure-time telemetry, not a reserved-minus-
allocated gap alone.

## Capacity Procedure

1. Fix the workload classes and service limits: maximum context/output, concurrency,
   request deadline, priority/fairness rule, and overload behavior.
2. Measure weight residency, real peak memory, KV occupancy, evictions, rejected/OOM
   requests, queueing, TTFT, decode rate, and quality per class.
3. Decide whether the constraint is capacity, tail behavior, cost, or a non-memory
   stage. Then test the smallest targeted lever.

More context or concurrency is not free capacity. If a user contract requires both,
plan an explicit route, limit, or degraded response rather than relying on an OOM retry.

## Convert The Ledger Into Admission Evidence

Estimate incremental state from prompt tokens, the bounded completion allowance,
cache reuse that is actually compatible and resident, and the deployed page/layout
rules. Predict output length from representative class evidence, retaining prediction
error and hard context/output caps. An expected output length is not a memory safety
guarantee.

Choose an explicit reservation rule: reserve to the allowed limit where feasible,
or allow bounded growth with an enforced check before allocating more state.
Define the preemption, deferral, or explicit termination behavior when growth cannot
be accommodated. Include its recomputation and latency costs in the service curve.
Combine the state check with work/deadline/tenant admission in
[runtime controls](03_runtime_controls.md).

Verify the rule on concurrent long prompts and long completions, mixed adapters,
cache misses, page fragmentation, and cancellation. Confirm both peak fit and timely
state reclamation. A policy that avoids OOM through repeated eviction may still fail
the goodput and tail contract.

Cache offload exchanges residency for host capacity and transfer time. Measure bytes,
effective transfer rate, contention, and reload tails. Lower-precision KV needs the
long-context quality checks in [quantization](04_quantization.md); additional token
capacity alone does not justify accepting more concurrent work.
