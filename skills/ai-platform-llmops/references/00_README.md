# Reference map

| Unresolved decision | Read | Main evidence to return |
| --- | --- | --- |
| Which capacity can actually execute this workload? | [Capacity, topology, and isolation](capacity-topology-and-isolation.md) | Typed inventory, feasible shape, measured physical envelope, isolation behavior |
| How should compatible replicas become ready, receive work, and scale? | [Serving control plane and protocols](serving-control-plane-and-protocols.md) | Protocol path, runtime contract, controller timeline, routing/drain evidence |
| What can be released or rolled back across dependent models and regions? | [Registry and fleet rollout](registry-compatibility-and-fleet-rollout.md) | Complete dependency bundle, affected consumers, exposure and recovery evidence |
| Can a training job start, exit, and recover as a viable allocation? | [Training placement and recovery capacity](training-job-placement-and-recovery-capacity.md) | Gang/topology feasibility, queue cause, exit and restore resources |
| How should a heterogeneous or disconnected device fleet evolve? | [Edge fleet rollout](edge-fleet-rollout.md) | Cohorts, compatible local state, rollout convergence, frozen fallback |

## Evidence and freshness

The durable framework comes from Machine Learning Systems, Volume II, especially its compute/network/storage co-design, orchestration, serving, edge, fleet MLOps, and practical capacity/recovery discussions. Its scenario numbers are not default hardware, price, energy, or scheduling settings. Compare measurements at the same quality floor, workload, precision, dense/sparse convention, boundary, units, and time window.

Implementation anchors include [vLLM Production Stack](https://docs.vllm.ai/en/latest/deployment/integrations/production-stack/), [vLLM Metrics](https://docs.vllm.ai/en/stable/usage/metrics/), [vLLM Security](https://docs.vllm.ai/en/stable/usage/security/), and [KServe documentation](https://kserve.github.io/website/). Verify the target release before relying on modes, metrics, routes, scaler integration, operator/device-plugin behavior, or health semantics. Stable and preview documentation can describe different deployments.

For concrete Kubernetes, NVIDIA GPU Operator/MIG/sharing, CNI, sandbox, Triton, autoscaler, and OpenTelemetry changes, inspect the deployed versions and current primary documentation for the affected mechanism. Do not infer a KServe-to-OpenTelemetry GenAI mapping or isolation guarantee from an object or vocabulary match. [NIST SP 800-218A](https://csrc.nist.gov/pubs/sp/800/218/a/final) is relevant to AI development governance, but specific control mappings require the actual applicable text and evidence.

Revisit measurements and compatibility when the bundle, resource mode, protocol, topology, tenant boundary, scaler, region, device tier, or demand mix changes. Refresh only the facts needed for the task; an acquisition gap does not prohibit normal engineering work.
