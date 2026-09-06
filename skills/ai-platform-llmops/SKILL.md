---
name: ai-platform-llmops
description: Build, diagnose, and operate shared AI infrastructure for predictive and GenAI serving (KServe, Triton, vLLM Production Stack), accelerator capacity, replica controllers, model registry releases, training-job placement, and edge fleet rollout. Runtime tuning and training update semantics stay with their execution owners.
---

# AI Platform and LLMOps

Make evaluated model bundles run on compatible, observable, recoverable capacity. This skill owns the platform around predictive models, GenAI runtimes, training jobs, and supported edge fleets. Use the smallest relevant procedure; a routine serving configuration change does not require a fleet redesign.

## Start at the responsible layer

Identify whether the unresolved decision concerns serving protocol/control plane, capacity/placement/isolation, registry/release, replica controller/routing, training-job infrastructure, or edge rollout. Trace the affected path through gateway, router, model API, runtime workers, hardware/data dependencies, and telemetry before changing it.

For the affected workload, obtain its bundle/version, shape and phase, useful outcome and quality/latency/deadline contract, tenant and state boundary, feasible execution shape, and recovery constraint. Treat absent measurements as explicit assumptions to resolve with a focused observation, not invented capacity.

## Working loop

1. Pin the affected bundle, population, deployment mode, physical domain, and time window. Separate desired controller state from observed allocation, loaded state, readiness, and useful work.
2. Find the first infeasible, delayed, or incompatible boundary using placement events, runtime contracts, dependency versions, and per-domain evidence.
3. Select the smallest relevant policy or implementation change. Explain the displaced cost: locality, isolation, startup time, failure concentration, state migration, or quality/deadline exposure.
4. Verify the changed path with representative workload evidence and its applicable failure/recovery case. Preserve a compatible prior bundle and capacity during rollout where the recovery contract requires them.
5. Return the change or diagnosis, supporting evidence, remaining assumptions, stop/rollback condition, and responsible owner. Do not call a platform ready solely because Pods run or requests return HTTP 200.

## Reference routing

Read only the reference needed for the task; [the index](references/00_README.md) gives the complete map.

- Pending workloads, accelerator inventory, topology, procurement, facility limits, or tenancy: [capacity, topology, and isolation](references/capacity-topology-and-isolation.md).
- Predictive/GenAI endpoints, KServe modes, readiness, replica provisioning, routing, scaling, or telemetry: [serving control plane and protocols](references/serving-control-plane-and-protocols.md).
- Model registry, dependency compatibility, multi-region releases, portfolio health, rollback, or retirement: [registry and fleet rollout](references/registry-compatibility-and-fleet-rollout.md).
- Training queues, gang placement, quota, preemption, elastic allocation, or recovery reserves: [training-job placement and recovery capacity](references/training-job-placement-and-recovery-capacity.md).
- Device cohorts, connectivity/version skew, local adaptation lifecycle, or federated participation operations: [edge fleet rollout](references/edge-fleet-rollout.md).

## Ownership contracts

- Runtime owners supply measured workload/service curves, resource and state needs, admission/overload limits, locality, load/warmup, readiness, and drain constraints. This skill implements replica provisioning, controller policy, and routing among compatible eligible replicas. LLM KV, batching, parallelism, quantization, and request-level scheduling belong to $llm-inference-optimization; CV execution belongs to $computer-vision-inference-optimization; other predictive runtimes retain their relevant owner.
- $neural-training-systems owns memory/update/collective semantics and coherent checkpoint/restart execution. This skill supplies feasible gang/topology, quota, exit resources, checkpoint/restore bandwidth, and recovery capacity. A scheduler must not infer convergence-safe resize from free devices.
- $ml-system-design, $llm-system-design, and the modality owners define objectives, model/data quality, product routing, acceptable degradation, and release evidence. This skill enforces their compatible release and route constraints across the fleet; it does not choose a new model or quality threshold to clear an infrastructure alarm.
- $platform-devops-engineering owns generic Kubernetes/IaC, images, identity, infrastructure apply, and reconciliation mechanics. This skill adds AI artifact, accelerator, workload, and fleet semantics.
- $sre-reliability-engineering owns SLO acceptance, incident command, on-call, and recovery judgment. Supply impact, exact versions, placement/failure domain, observations, mitigation, rollback compatibility, and remaining capacity. Security controls and privacy claims use the relevant security owner; independent assurance belongs to $security-review.

Keep these handoffs local and concrete. Naming a neighboring skill does not require loading it for an already resolved decision.
