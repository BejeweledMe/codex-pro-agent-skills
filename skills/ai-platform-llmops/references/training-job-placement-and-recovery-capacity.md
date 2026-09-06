# Training-job placement and recovery capacity

Use this reference for shared training infrastructure: admission, gang/topology placement, quota, preemption, capacity sharing, and recovery. The training owner proves actual updates, collectives, checkpoint consistency, and restart semantics. Platform success means that a viable job can make and recover useful progress on the supplied allocation.

## Obtain the execution contract

Ask $neural-training-systems for the minimum viable group, fixed atomic parallelism units, per-rank device/host resources, rank/group mapping constraints, message regime and topology sensitivity, data consumption, checkpoint/restore state sizes and durability, and allowed resize/restart behavior. Include the model owner’s target quality, deadline, batch/data-order constraints, and tolerated lost progress where relevant.

Get measured load/rendezvous/warmup and useful step/progress curves for viable shapes. A fleet controller must not change world size, synchronization mode, effective batch, or sharding merely to fill spare devices. Elasticity is available only when the execution owner declares the transition valid and supplies its cost and recovery checks.

## Admit a viable allocation

For a fixed synchronous job, coordinate all required ranks and supporting resources as one admission decision. Partial allocation can hold scarce accelerators while the job waits for missing participants and produces no progress. Verify how the deployed scheduler actually implements group admission and cleanup; do not assume a collection of pending/running Pods gives atomic gang behavior.

Check feasible device type/profile, topology domain, CPU/RAM, network, input/storage, quota, and priority together. Preserve enough capacity for rendezvous, checkpoint exit, and recovery where the contract requires it. Release or reclaim failed partial reservations through the supported controller behavior so they do not become stranded allocation.

Compare compact and available placement using calendar time to useful progress. Waiting for a fast topology can be justified for a long communication-heavy job; immediate spread placement may be better when runtime slowdown is small or the job is short. Use measured queue/start and runtime curves rather than a universal compactness rule. Validate representative collectives and per-rank tails with the training owner; logical rank numbering does not establish locality.

## Explain the queue before changing policy

| Observation | Evidence to distinguish causes | Action and recovery check |
| --- | --- | --- |
| Free devices, job cannot start | Typed inventory, largest compatible shape, quota, gang/host/storage requirements | Correct capability/topology/quota mismatch; verify full viable admission |
| High allocated time, little progress | Startup/rendezvous, input, collective, checkpoint/replay, zombie and rank-health timeline | Repair the first blocked stage with its owner; confirm useful progress after reallocation |
| Long queue after many small jobs | Shape fragmentation, duration distribution, reservation/borrowing and priority history | Compare reservation/backfill/placement policy against actual wait and fairness; avoid unvalidated eviction |
| One rank slows every step | Physical health, input skew, shared links, per-rank trace | Isolate or replace the cause using the declared restart path; verify target-quality trajectory |
| Repeated resize/preemption, poor completion | Transition duration, lost progress, restore/load and stable useful interval | Reduce policy churn or protect a viable interval; check time/cost to quality |

Expose queue reason and age by workload/tenant alongside allocated, active, and productive capacity. Near-full occupancy is not a universal target: heavy-tailed durations, gang sizes, and topology constraints can create a steep waiting-time increase.

## Preempt with an exit and recovery budget

Compare the value of released capacity with the victim’s checkpoint, replay/lost work, reload, warmup, deadline, and transition costs. Verify the actual interruption notice and failure model. A panic checkpoint is only an opportunistic path if the complete required state can become usable within that window; do not count it as the only durable recovery plan.

Provide CPU, RAM, network, and storage resources while the victim exits. Evicting the very resources needed to checkpoint defeats graceful preemption. Ask the execution owner which checkpoint is coherent and durable, when resources can be relinquished, and how partially completed exit is handled. The scheduler cannot certify checkpoint contents from a successful write event.

If borrowing serving capacity for training, use explicit reclaim rules and verified transition times. Reclaiming and loading models on a minutes-long path cannot protect a seconds-long serving burst. Keep serving ready capacity and the agreed admission/fallback behavior sufficient for that gap. Preserve the training job’s checkpoint and minimum viable group obligations when reclaiming.

For elastic allocation, compare the expected stable interval of benefit against transition cost, and maintain fixed atomic units and execution semantics. Do not repeatedly resize to chase small utilization changes. Stop a policy experiment if productive progress or the protected workload contract deteriorates.

## Budget recovery across physical domains

Measure detection → capacity wait/allocation/restart → load/reshard → warmup/validation. Include failures of a node, rack/power/fabric domain, storage path, and shared software where relevant. Independent per-device hazards are only a first-order model; they omit correlated interruptions and common causes.

Spot or interruptible economics belongs to the whole gang: one lost mandatory participant can stop progress and trigger group restoration. Diversifying synchronous ranks across zones can add communication cost and new failure behavior; use verified topology and execution evidence before treating it as resilience.

Separate input reads, checkpoint burst writes, background durable copies, and restore concurrency. Reserve restore bandwidth and feasible replacement shape for the intended recovery scenario; many failed jobs restoring together can saturate storage and delay all recovery. Local staged checkpoints are only as durable as their surviving failure domains and completed durable copy.

Choose spare/warm capacity versus queued cold replacement from measured recovery objectives and economics. Fast replacement is not always the safe path: suspected silent corruption may require an earlier known-good checkpoint selected by the training owner. Platform supplies capacity and artifact availability for that path.

Verify a representative restart or use recent applicable recovery evidence: placement must become viable, all required state must load, and the training owner must confirm resumed progress and quality semantics. A recreated Pod or rendezvous success is insufficient. Return observed recovery duration, lost work, resource contention, and remaining failure-domain limits.
