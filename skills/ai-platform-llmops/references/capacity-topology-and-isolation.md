# Capacity, topology, and isolation

Use this reference when apparent fleet capacity differs from feasible placement, when choosing a physical envelope, or when sharing AI infrastructure. Capacity means sustained useful work under the workload and isolation contract, not the sum of advertised slots.

## Turn workload requirements into a feasible shape

Record the affected phases: predictive serving, prefill/decode, training, ingest, checkpoint, restore, or edge adaptation. Get the execution owner’s per-worker peak state and resource requirements, including temporary allocations and host work. For prediction include feature/embedding access and preprocessing; for image/video include decode expansion and sustained input rate; for generation include prompt/output distribution and state locality. A model that fits by weight size may still fail during load or execution.

Then map requirements against separate envelopes:

| Envelope | Evidence | Decision it changes |
| --- | --- | --- |
| Compute and memory | Supported runtime/operator/precision path, measured phase throughput, per-worker peak memory and bandwidth | Compatible hardware and allocation size; runtime owner proves representation and execution |
| Host and data path | CPU/RAM, decode/transform time, host-device transfers, input starvation and tails | CPU/NUMA/data staging placement, preprocessing capacity |
| Fabric | Actual rank/replica map, message sizes/cadence, traffic matrix, per-cut load and degraded-link tails | Which nodes can form a viable group and which workloads can coexist |
| Storage | Input consumption, metadata operations, checkpoint bursts, durable-copy and restore rates | Cache/staging, shared bandwidth reservation, restore concurrency |
| Facility | Rack power/cooling, PDU, cable reach/optics, space and thermal behavior under soak | Realizable density, failure domains, sustained delivery and expansion limits |

Hardware peaks are useful only as explicitly normalized bounds. Distinguish precision, dense versus sparse execution, payload versus line rate, GB/s versus Gb/s, per-link versus aggregate, and one-way versus bidirectional values. Verify the deployed operator path and achieved work; no hardware generation name establishes a fleet speedup.

## Maintain a typed accelerator inventory

For each placement domain distinguish physical device count and identity, exclusive allocation, MIG profile, time-sliced slot, time-sliced MIG instance, advertised resource name, capability labels, driver/runtime compatibility, health, and current occupants. Keep the physical owner of advertised shares visible.

Reconcile scheduler-reported capacity and allocatable resources with current device-plugin health, node/device observations, reservations, occupants, and feasible topology. Report timestamps and uncertainty: Kubernetes capacity is a scheduling representation, not a live physical inventory or a guarantee of immediately usable devices. An unhealthy device or stale label can leave reports inconsistent with execution.

For device-plugin extended resources, verify the installed Kubernetes request/limit rules. In the captured GPU interface, specify GPU quantities in `limits`; omitted requests default to limits, and requests and limits must be equal where both are set. A GPU request without its limit is not supported by that interface. Advertised time-slicing units can still represent oversubscribed physical access. Scheduler accounting does not establish proportional hardware capacity. Include driver, toolkit, plugin, feature discovery, and monitoring versions when diagnosing node enablement. Treat MIG profile/mode changes as capacity transitions with the actual implementation's disruption and drain behavior.

Time slicing advertises oversubscribed access; it does not allocate proportional compute or isolate memory and faults like independent GPUs. MIG is a different partitioning mechanism whose profile, support, residual shared domains, and runtime compatibility must be verified. Neither label alone proves the required tenant boundary.

When a Pod stays pending despite free GPUs, inspect scheduler events, requested resource names/quantities, labels/affinity, taints, quota, device-plugin health, sharing mode, host resources, and topology constraints. Separate aggregate free count from a compatible contiguous shape. For a training gang, use [the training reference](training-job-placement-and-recovery-capacity.md).

Bin packing scores incoming placements; it does not live-compact running Pods. Record the configured scoring strategy and resource weights because they determine which shape is favored. Compact placement can improve local communication and preserve large shapes, but can concentrate noisy neighbors and failures. If defragmentation requires eviction, model the affected workloads’ drain, state, recovery, and interruption cost before changing placement.

## Verify topology instead of inferring it

Consume the runtime’s parallelism and traffic contract. High-frequency latency-sensitive communication generally benefits from the fastest verified local domain; wide exchanges require per-cut bandwidth and skew evidence. These are placement hypotheses, not instructions to choose TP/PP/DP/EP here.

For an execution plan already supplied by its owner, test placement hypotheses: frequent latency-sensitive tensor-parallel traffic within the fastest compatible local domain; pipeline stages close enough for activation transfers; data-parallel exchanges on sufficient scale-out bandwidth; expert all-to-all against relevant fabric cuts and skew. Confirm with its measured traffic matrix; do not change the execution plan merely to fit placement.

A fast port or healthy average switch does not prove useful job bandwidth. Check actual paths, rail/group mapping, contention, queueing, loss/recovery, and worst required participant. A fabric cut matters only for traffic crossing it. Compare representative placements with the same execution plan; record both queue-to-start and runtime, since waiting for an ideal shape can outweigh its runtime benefit.

Investigate gray hardware when one required worker or replica remains slow: correlate clocks, power/thermal throttling, ECC/link signals, host/input skew, and runtime state. Under the operating authority, remove a suspected domain from new placement or route around it, then verify user/job progress and loss of reserve capacity. Avoid a fleet restart based on one aggregate utilization chart.

## Provision the data and recovery path

Size input supply from achieved consumption by concurrent workers, then account separately for decode expansion, metadata, shuffle, host-device transfer, and variance. Prefetch can cover temporary variability; it cannot repair a sustained supply deficit.

Sequential shards and local staging can reduce metadata pressure and remote tails when reuse justifies staging delay, space, egress, and endurance. Check assignment and freshness with the data owner. Sparse recommendation workloads can be constrained by hot feature/embedding shards and host memory rather than dense compute; preserve their locality and skew evidence.

Reserve for checkpoint write bursts, background durable copies, and concurrent restores without starving input or serving. Local staging with asynchronous durable copy creates a durability window and shared-link contention. Measure end-to-end restoration on the intended placement; a storage throughput benchmark alone does not demonstrate recoverability.

## Choose and verify tenancy controls

Identify whether sharing is among trusted teams, SaaS customers, or untrusted model/tool workloads. Tie controls to the assets and attack paths: workload identity and least-privilege access, namespace/RBAC, quotas, storage lifecycle, route allowlists, network restrictions, sandboxing, and dedicated nodes/control planes/clusters where required. Hardware sharing and control-plane separation solve different problems.

For NetworkPolicy, inspect the CNI’s enforcement and the selected namespaces/Pods. Policies combine additively; verify intended denied and allowed paths, including DNS and any host-network exceptions. L3/L4 policy does not provide encryption or application identity. Sandbox isolation reduces some host-kernel exposure but still depends on supported device access, host maintenance, resource limits, and network controls.

Treat model loaders, plugins, adapters, and cache artifacts as code/data trust boundaries. Put public engine access behind an authenticated route allowlist and protect distributed worker/control traffic according to the deployed runtime's trust assumptions. Disable or restrict development, profiler, plugin, runtime-adapter, and tool-server surfaces for untrusted callers. Restrict artifact-cache writers and verify integrity and approved origin before loading. These controls need target-version and threat-model verification; a signature alone is not release authorization. Test whether the intended peer/tenant can actually access routes, storage, and devices, using authorized checks. Pass unproven isolation or privacy requirements to the security owner rather than relabeling sharing as a guarantee.

## Compare delivered work and realizable economics

Distinguish allocated capacity, compute-active capacity, and productive progress. For serving report completed work meeting the relevant latency/quality/policy contract per elapsed interval; for training report progress or time/cost to the model owner’s target quality. Do not use one unqualified goodput denominator for both.

Include waiting, idle reserve, staging/egress, checkpoint/replay, recovery, operations, and energy in a like-for-like cost comparison. A utilization improvement saves money only if it changes paid runtime, removes or avoids capacity, reduces an actual bill, or creates separately quantified value. Retain uncertainty and demand scenarios.

Power/cooling are feasibility inputs. TDP is not measured workload energy. Attribute IT versus facility energy, idle/load interval, quality and work unit, region/time assumptions, and any excluded lifecycle scope. Lower energy per result does not establish lower total impact if demand rises. Use current measured and facility-supplied inputs for procurement; do not reuse dated SKU prices, carbon totals, or universal cooling thresholds.

Verification should show a feasible placement, representative sustained execution, the required isolation behavior, and recovery with realistic contention. Scale that evidence to the requested change; a single quota repair needs no procurement study.
