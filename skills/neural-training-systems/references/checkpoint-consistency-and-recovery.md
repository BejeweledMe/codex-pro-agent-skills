# Checkpoint Consistency And Recovery

Success is restored valid progress with known data coverage and bounded lost work.
A weights-only warm start may be useful, but it is a changed experiment rather than
an equivalent continuation.

## A Coherent State Cut

Prefer a completed optimizer-update boundary when suitable. All required state must
describe the same logical progress point:

| State | Consistency requirement |
| --- | --- |
| Model, persistent buffers, base/adapters and auxiliary/EMA weights | Correct artifact identities and update; include state needed for evaluation/export |
| Optimizer and master state | Parameter mapping, moments, counters, dtype and partition agree |
| Scheduler, precision scaler and progress | Same accepted update/sample/token boundary; distinguish attempted and completed updates |
| RNG/stochastic state | Relevant host/device/rank and transform/sampling generators |
| Data/sampler position | Dataset/transform/tokenizer identity, consumed boundary, shuffle/packing and assignment |
| Distributed layout | State ownership, shard mapping, shapes/dtypes and format/runtime compatibility |
| Algorithm/transformation state | Compression residuals, local-update counters, pruning masks or QAT observers/scales when used |
| Completion/durability metadata | Unique identity, logical cut, expected shard set, integrity and survival domain |

For mid-accumulation or in-flight pipeline saves, use a supported consistent protocol
that captures partial gradients/counters and required in-flight state, or replay from
a completed cut. Never combine post-update weights with pre-update optimizer/data state.

Prefetch can advance readers beyond consumed samples. Save or reconstruct the
consumed boundary; a reader cursor after the prefetch queue can skip data on resume.
If exact worker restoration is unsupported, define bounded replay and report duplicate
ranges. Streaming/iterable sources need a retained snapshot/offset contract with the
data owner; silently switching to available data changes the experiment.

## Publish Complete, Durable State

Use existing storage/checkpoint mechanisms to establish a logical cut, protect the
snapshot from concurrent mutation, write under a distinct identity, verify its
expected state/shard set and publish completion only then. Keep the previous
trustworthy checkpoint selectable. Readers must reject incomplete candidates.

Async serialization needs an immutable snapshot or equivalent protection. Do not
assume a multi-file rename, object listing or one rank's successful write commits
the whole checkpoint. Use storage-supported publication semantics and label the
durability level actually reached.

Local staging and background durable copy have different failure survival. Track
the window during which host loss destroys the newest staged state, copy interference
with input/training and memory/network/storage needed to complete it.

## Restore And Verify Continuation

Select the newest trustworthy compatible completed state, not the latest timestamp.
Verify integrity, data identity, destination capacity and supported format/layout
mapping, including temporary load/reshard memory. Establish viable process groups;
restore model, optimizer/schedule/scaler, data and RNG at the intended boundary before
the next batch. Arbitrary world-size changes do not imply supported resharding.

Compare interrupted and uninterrupted continuations from the same controlled state:
next sample/token identities, counters, finite values and selected loss/gradient/update
behavior, followed by bounded trajectory checks. Exact parity applies only where
supported; otherwise declare numerical tolerances. Readable files alone prove little.

When changing the checkpoint mechanism, exercise relevant partial-publication,
missing/corrupt-state and supported layout-change cases in the existing environment.
Keep the drill proportional to run cost; incomplete state should be rejected while
a prior valid state remains usable.

## Diagnose Before Retrying

| Evidence | Recovery path |
| --- | --- |
| Transient transport problem, plausible state | Bounded retry or supported group rebuild; reload if coherence cannot be established |
| Lost rank/host | Supported coherent replacement or validated checkpoint reload; an empty replacement cannot simply join |
| OOM/disk exhaustion | Fix the binding resource before repeating the run |
| Persistent straggler/gray failure | Separate input skew from device/host/link health; platform owns hardware action |
| Suspected silent corruption or correlated fault | Preserve evidence, quarantine suspect state, consider an earlier known-good checkpoint |
| Unexplained changed loss/sample order | Audit cut, RNG, consumed position, schedules/scaler and layout before accepting divergence |

Use detection → classification → supported warm recovery, cold load or earlier
rollback. Define a retry budget from deadline and lost-progress tolerance; repeated
loading of the same unexplained bad state is not recovery. SRE receives failure
class/domain, checkpoint identity, progress bounds and safe options for live incidents.

## Cadence, Preemption And Resize

Measure `T_recovery = T_detect + T_allocate/restart + T_load/reshard + T_warmup/validate`.
Include resource queue delay explicitly. Track lost/replayed work separately, along
with write pauses, durable-copy completion and interference; do not double-count
overlapped time.

Cadence follows measured job-relevant failure domains and full recovery costs.
`interval ≈ sqrt(2 × write_time × job_MTBF)` is only a first-order hypothesis for a
long job, stationary independent failures, stable write time and interval much smaller
than MTBF. Correlated rack, power, software or fabric failures require their own model;
fleet-wide MTBF is not automatically the job's MTBF.

Give platform the viable gang/fixed model-parallel units, checkpoint age/durability,
exit CPU/network/storage and transition cost. A notice-triggered save is useful only
if the whole consistent state can finish within the window; retain the periodic
durable recovery required by the failure contract. Assess interruption economics at
gang level. Avoid assuming instance risk or price describes the complete job.

Elastic resize needs supported state mapping, data/RNG assignment and explicit
effective-batch/schedule semantics. Account for replay, warmup and a stable interval
to amortize the transition. If semantics change, label the changed experiment with
modeling; platform owns the preemption/placement mechanism.

Source basis: Volume I, Model Training; Volume II, Fault Tolerance, Distributed
Training and Fleet Orchestration. Exact storage/runtime guarantees require verification.
