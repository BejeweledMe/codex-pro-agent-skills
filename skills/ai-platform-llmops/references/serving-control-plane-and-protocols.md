# Serving control plane and protocols

Use this reference to implement or diagnose the platform path around predictive and GenAI runtimes. The execution owner determines within-replica scheduling and service capability. The platform decides which compatible replicas exist, become eligible, receive work, and retire.

## Separate contracts along the path

Trace gateway authentication/limits → router → model API → engine/workers → hardware/state/dependencies. Record identity, bundle/version, readiness, deadlines/cancellation, streaming and error behavior at each hop. Also trace the controller’s desired state → scheduled allocation → artifact load → warmup → eligible endpoint. An endpoint can exist before it can serve the intended bundle.

Choose deployment mode from actual request path and operating requirements. With KServe, inspect the target release’s control/data plane and compare Standard and Knative mode for gateway/activator path, scaling integration, startup delay, streaming, supported runtime, and operational dependencies. Do not select a mode solely from a generic promise of serverless behavior; model download and warmup can dominate startup.

| Surface | Verify independently |
| --- | --- |
| V2/Open Inference Protocol predictive serving | Tensor names/shapes/dtypes, metadata, health/readiness, request/response compatibility |
| OpenAI-compatible GenAI endpoint | Supported operations/fields, tokenizer/template mapping, stream framing and termination, status/media/errors, cancellation |
| Triton model-serving interface | Backend/model configuration and transaction behavior; runtime owner chooses batching and instance scheduling |
| Metrics and traces | Signal type, units, labels, phase boundaries, versions, sampling and sensitive-data handling |

For predictive serving, consume the model configuration's tensor shape/dtype, maximum batch, state/sequence semantics, transaction behavior, and runtime-owned instance/scheduler limits. Stateless dynamic batches, stateful sequences, streaming workloads, and hot feature shards have different service curves. Baseline the actual endpoint with a protocol-appropriate load generator before changing platform capacity; batching-window or instance-scheduling tuning remains with the runtime owner. Compare deployments at the same input mix, quality floor, arrival process, concurrency, and latency boundary.

Compatibility of one surface does not imply the others. Probe the actual client-to-runtime route: direct runtime success with gateway failure implicates a different boundary than model load failure. Verify errors and streaming as well as a short successful request. Current operation details belong to the target runtime/protocol documentation.

## Obtain the runtime-to-platform contract

Before capacity or scaler policy, obtain enough of the following to address the task:

- Exact bundle, hardware/resource shape, topology, precision, and permitted workload classes.
- Measured offered-load versus completion/goodput, queue/tail and rejection curves under the class mix, with the quality floor and measurement boundary.
- State/resource pressure and effective admission limits, including context/output limits or predictive input-shape constraints; overload and cancellation behavior.
- Locality and compatibility constraints for cache/session/sequence state and whether move, rebuild, or drain is supported.
- Artifact download/load, compile/warmup, readiness, drain, and failure recovery distributions on the intended hardware and storage path.

For LLMs this includes KV, prefill/decode, and token-work signals without transferring their tuning ownership. For stateless predictive models, request shape and batch cost may suffice. Speech/video sessions and feature-sharded recommenders require their own state/locality contract; do not impose an LLM scheduler on every model.

## Make readiness and drain represent useful capacity

Keep process liveness, startup progress, and traffic readiness distinct. Protect a legitimately slow startup from restart loops. Readiness should establish that the expected artifact and required runtime state can serve the advertised operation; avoid announcing generic process health as model readiness.

Compare configured probes with observed load/warm durations, dependencies, and failure behavior. Liveness coupled to an external dependency can cause correlated restarts when that dependency fails. A failed semantic quality gate should stop a release or route, not automatically become a process-restart loop.

During removal, cease new routing, account for endpoint propagation, and apply the runtime’s drain/cancel/state-transfer contract to in-flight work. A streaming session cannot be assumed to resume on a different replica. Observe remaining eligible capacity and finish or explicitly terminate within the agreed deadlines before releasing resources. Generic probe, disruption, and shutdown mechanics use the platform/SRE owners as needed.

## Route among eligible replicas

First filter by authorized tenant/model/region, exact compatible bundle, readiness, health, and resource/state feasibility. Then compare predicted remaining work, queue age, locality benefit, and capacity headroom using available runtime signals. Request count or least-connections can misrepresent variable-length or stateful work.

Locality can avoid rebuild/transfer cost but overload a hot replica. Determine when queue delay outweighs reuse, and how the router handles stale state/health signals. Include cache authorization and compatible state keys; never route across an access boundary to obtain a cache hit. Runtime owners validate transfer/rebuild and cache semantics.

Evaluate routing with the actual mixed workload: hot prefixes/features, long and short requests, cancellations, tenant bursts, and a degraded replica where relevant. Measure class/tenant tails, rejects, duplicated/retried work, and goodput. A local routing improvement is not proven if it shifts overload to another tenant or failure domain. Product owners define alternate models/providers and degradation; the fleet router only uses their approved routes.

## Design a controller with its delays visible

Account for detection, decision, provisioning, artifact load, warmup, and endpoint readiness. Track desired, pending, allocated, loaded, ready, draining, and unavailable capacity separately. Scaling requests are not capacity delivered.

Use measured work/demand and queue/state signals that causally relate to capacity, plus forecast where justified. P99 is an outcome guard with a service floor and nonlinear queue component, not a universally inverse capacity signal. Little’s Law describes average occupancy at a named stable stage; it does not calculate replicas or guarantee a tail SLO.

Choose minimum ready capacity, warm tier/reserve, limits, stabilization/hysteresis, and scale-down policy from service curves, arrival variability, failure reserve, and startup distributions. If demand rises faster than ready capacity can arrive, prewarming or forecasted capacity may help; use the approved admission/shedding/degradation behavior while capacity catches up. Preserve runtime-owned admission budgets and coordinate gateway limits and bounded retries so accepted work does not become an unbounded queue.

Avoid competing controllers acting independently on the same replica count. Name the control authority and how runtime, replica, node, and quota controllers interact. For scale-down, consider sessions/cache, drain time, correlated maintenance, and the cost of rewarming if demand returns.

Verify the response to a realistic burst and decline: offered mix, queue age, ready capacity timeline, rejects/retries, tails, and cost. Use already available traces or a scoped controlled experiment. Stop expansion if resource pressure, errors, or the user contract worsens. Do not continue adding replicas when the bottleneck is a feature service, protocol failure, artifact download path, or incompatible shape.

## Diagnose platform versus runtime failures

| Symptom | Discriminating evidence | Next action and verification |
| --- | --- | --- |
| Queue full with idle devices | Pending reasons, typed resources, quota/topology, ready bundle coverage | Repair feasibility or readiness; confirm eligible capacity and progress before runtime tuning |
| Scale-out happened, SLO did not recover | Full scale timeline, offered/retried work, load/warm events, downstream trace | Correct signal/delay/dependency; replay the relevant burst and confirm recovery |
| Ready endpoint fails for one client | Mode, exact route/method/media/status, streaming and model metadata | Repair protocol/gateway contract; test through the affected client path |
| High occupancy, low useful completions | Tenant/class queue age, rejections/cancellations, gray replica, stage trace | Distinguish routing/interference from within-engine scheduling; pass localized evidence |
| Repeated starts never deliver capacity | Artifact access/load, resource peaks, startup/probe events | Repair compatibility/startup envelope; observe a full load-to-ready cycle |

Correlate user journeys with portfolio/model versions, service and infrastructure signals. Preserve client versus server latency and token metric boundaries; Effective and Active benchmark metrics have different denominators that must be defined from the tool version. HTTP success, aggregate tokens/s, Prometheus availability, and OTel instrumentation each prove different things. Avoid logging raw prompts/features or tenant data when bounded identifiers and stage metadata suffice.
