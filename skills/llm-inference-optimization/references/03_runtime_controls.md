# Runtime Controls

## Batching And Scheduling

Compare static, bounded dynamic, and continuous batching on the real length mix. More
throughput can increase queue delay, head-of-line blocking, starvation, or tail
latency. Record token/sequence budgets, maximum wait, priority behavior, cancellation,
preemption, and fairness. Admission control must reject, defer, or route overload
predictably rather than accept requests until memory failure.

For autoregressive requests, continuous batching can refill work as sequences finish.
Where supported, chunked prefill can trade prompt-processing progress against decode
interference. Measure TTFT and token-gap tails together across prompt/output classes;
a decode-friendly setting can make long prompts wait too long.

Distinguish request admission from backend scheduling. For example, Triton's instance
rate limiter coordinates declared execution resources; it does not establish public
API quotas or tenant admission. Select static/dynamic versus stateful/iterative
scheduling from the backend's execution contract before tuning its batch parameters.

## Admission And Bounded Overload

Admit against predicted work and state, then schedule within that envelope:

1. Validate model/bundle compatibility, prompt/context and output limits, deadline,
   priority, tenant entitlement, and cancellation state.
2. Estimate uncached prefill work, remaining decode work, incremental KV bytes/pages,
   and uncertainty from class-specific measurements. Keep prefill and decode demand
   distinct; equal token counts need not imply equal service demand.
3. Compare predicted queue wait plus remaining service and completion overhead with
   the remaining deadline. Check token/sequence budgets, KV reservation or growth
   limits, and per-tenant work/state limits together.
4. Admit, defer within a bounded queue, reject explicitly, or request a compatible
   route allowed by product policy. Recheck deadline and cancellation before starting
   deferred work. Return a reason that distinguishes deadline, state, tenant, and
   unavailable-capacity limits.
5. Update estimates from observed work and state growth. Record prediction misses,
   preemption/recomputation, and per-class outcomes; reduce admission when estimates
   cease to describe the workload.

Set queue bounds in requests and estimated work/state where relevant, plus maximum
wait or age. A small queue of very long requests can exceed a large queue of short
ones in both service demand and retained memory. Define tenant fairness in work/state
terms appropriate to the contract, with bounded waiting for lower-priority classes.
Do not silently shorten a requested answer or reduce its quality to make admission
appear successful; acceptable degradation comes from the product owner.

If routing is part of the request path, expose predicted remaining prefill/decode
work, compatible KV/prefix locality, replica health, and measured available capacity
to the platform router. An idle connection does not imply spare execution capacity.
Keep a controlled fallback when session affinity points to an unhealthy replica.
Use tenant work/state quotas and bulkheads where needed to contain noisy neighbors;
platform ownership covers cluster isolation and fleet routing implementation.

Bound retry attempts and total retry time under the original deadline. Coordinate
gateway/client budgets so retries do not multiply across layers; use backoff/jitter
for retryable overload and stop on cancellation, expired deadlines, or permanent
limits. Deduplicate work where the request contract permits it. Cancellation must
stop queued/executing work and reclaim KV state promptly, not merely close a socket.

Verify overload and recovery with the representative burst and length mix. Observe
queue age, rejected/retried work, state growth, class starvation, and goodput while
demand is high and after it falls. Success requires bounded backlog, enforced limits,
released state, and recovery of admitted classes without a retry storm. Do not wait
for scaling to make these controls effective.

## Remove Wasted Work First

Before changing model precision or topology, test whether the workload can use bounded
context/output limits, prefix/cache reuse, an appropriate smaller verified route,
request deduplication, constrained output, or removal of redundant calls. Preserve
product correctness and authorization when caching or routing.

Prefix reuse needs stable shared content and compatible model/tokenizer/template,
adapter, position/state representation, and policy. Define tenant/authorization
boundaries, freshness, invalidation, and eviction behavior. Measure both warm hits
and cold misses; a high hit rate does not prove the miss path meets its contract.
For stale or cross-tenant reuse, disable or partition the affected cache, repair the
key/invalidation contract, and verify isolation and miss-path recovery before reuse.

## Execution And Topology

Choose runtime, compilation, parallelism, cache/offload, and accelerator topology from
the actual bottleneck, model format, hardware support, operational visibility, and
failure recovery. Data, tensor, pipeline, and sharding strategies exchange memory
pressure for communication, scheduling, and recovery complexity. Measure per-rank
memory, communication time, inference-iteration/request variance, failure behavior,
and quality; do
not choose topology from parameter count alone.

Start with a viable replica. Tensor/pipeline parallelism can address fit or request
latency; data-parallel execution and additional replicas address aggregate demand.
For MoE expert parallelism, inspect token/expert skew and actual transfer paths.
Measure message sizes, rank placement, link contention, slow-rank tails, and exposed
communication on the request critical path. Claimed overlap is useful only when
timelines show it hides time without moving the bottleneck.

For latency-sensitive tensor-parallel communication, a fast verified local
interconnect is a useful starting hypothesis. Pipeline stages exchange activation
traffic and create coupled failure groups. Confirm both against the target topology
and trace; more ranks need not improve the binding stage. Include CPU/tokenizer
capacity and host scheduling gaps when GPU workers are starved.

State the engine's memory, compute, and fault-isolation requirements in the platform
handoff. Physical GPUs, hardware partitions, and time-sliced slots are different
capacity types; time-slicing alone does not provide proportional compute or memory
and fault isolation.

Prefill/decode disaggregation is conditional: compare specialization gains against
KV transfer or rebuild, queue handoff, state compatibility, and recovery tails.
Include cache misses and failures in the comparison. Retain or restore a combined
path if whole-request goodput and tails regress. The runtime defines viable execution
and state-transfer requirements; AI platform implements fleet placement and routing.

Estimate a single transfer as setup latency plus bytes divided by effective bandwidth,
then measure serialization, queueing, staging, contention, and tail behavior on the
actual fabric. Compare the resulting time with saved prefill work or specialization
gain, using one request boundary; bytes multiplied by latency is not transfer time.
Verify pool imbalance, failed transfers, and starvation behavior as well as warm
successful requests.

Speculative decoding is a throughput/latency experiment: measure accepted-token rate,
draft-model overhead, workload distribution, and final-output quality. It is not a
universal speedup.

Also report draft and verifier state footprints, verification cost, batch regime,
and accepted output tokens per wall-clock second. Count rejected draft work as
consumed capacity. An improved acceptance fraction alone does not prove a serving
gain; disable speculation or return to the previous verified configuration if its
overhead worsens the target class.

## Runtime Evidence For Scaling

Request execution and inference scheduling stay here. `$ai-platform-llmops` owns
replica provisioning, the scaling controller, registry, fleet routing, and placement;
`$platform-devops-engineering` owns generic Kubernetes/IaC implementation. Supply
the signals and experiments needed for those decisions:

| Runtime evidence | Capacity interpretation and limit |
|---|---|
| Offered/admitted work and arrival mix | Report uncached prompt work, expected output work, lengths, bursts, and prediction error. Raw QPS or least-connections can hide variable service demand. |
| Queue depth, age, and growth by class | Persistent growth can indicate a service deficit; first distinguish tenant limits, scheduler stalls, and unavailable compatible replicas. |
| KV occupancy, growth, eviction, preemption, and active sequences | State can bind before compute. Report the limits under which the measured service curve remains valid. |
| Rejections, cancellations, and retry attempts | Rejections expose unmet demand; retries can amplify it. Separate original demand from attempts and permanent policy limits from capacity rejection. |
| Per-replica service curves and health | Report goodput/tails versus load and mix on viable topology, including cold/warm and cache-miss behavior. A single aggregate utilization target is insufficient. |
| Forecast mix and readiness timeline | Show whether extra compatible capacity can arrive before deadlines expire, and which uncertainty or stage dominates the delay. |

Account for the full response:

`T_scale = T_detect + T_decide + T_provision + T_load + T_warm + T_ready`.

Timestamp detection, the controller decision, resource provisioning, artifact load,
initialization/compilation and warm execution, and final readiness/routing eligibility.
Use non-overlapping stage intervals for the sum; if work overlaps, report the measured
critical path rather than double-counting spans. Include failed attempts and tail
delay where they affect available capacity. Process liveness is insufficient: the
correct compatible rank group must be loaded and able to execute representative work.

Compare this timeline with burst duration and remaining request deadlines. When
reactive capacity arrives too late, provide evidence for the platform owner's choice
of forecast-based capacity, warm reserve, or controller changes while local admission
and shedding contain overload. Return measured results for delayed provisioning,
loading failures, saturation, and draining so the platform can validate hysteresis
and scale-down policy.

P99 is an outcome guard. It contains a low-load service floor and nonlinear queueing,
and can rise through network, validation, gray replicas, or changed lengths. Compare
low-load phase timings and load-response curves before attributing it to capacity.
Do not derive replicas from `observed P99 / target P99`. Little's Law describes
stable averages at a consistent boundary; `arrival rate * latency SLO` is not a
replica formula, and an unstable backlog has no steady-state sizing interpretation.

For a handoff, provide the exact bundle, workload and service curves, per-rank
memory/device/interconnect requirements, state locality/compatibility, admission
limits, load/warm/readiness delay, and drain/cancellation behavior. State the requested
platform decision and the observation that will establish recovery. A full queue
beside idle GPUs requires requested-versus-available topology and readiness evidence;
free device count alone does not prove a viable replica can be placed.

The platform returns actual placement, controller/routing behavior, and observed
capacity/readiness constraints. Re-measure execution on that placement. SRE owns
SLO and incident policy; product ownership determines acceptable fallback behavior.
