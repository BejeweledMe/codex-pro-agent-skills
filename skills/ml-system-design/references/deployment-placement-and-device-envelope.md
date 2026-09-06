# Deployment Placement and Device Envelope

Related: [problem framing](02_problem_framing.md),
[serving](14_serving_inference_optimization.md),
[benchmark contract](benchmark-contract-and-claims.md),
[release and fallback](13_integration_api_release_fallbacks.md)

Use this reference when deciding where predictive work should execute. Placement
is an early product/data/quality decision because connectivity, data movement,
device capability and updates constrain the feasible model and feedback loop.
ML owns that decision and its acceptance; `$ai-platform-llmops` implements shared
infrastructure, scheduling, controllers and supported fleet rollout.

## Serving Regime Before Placement

Choose batch/precomputed, online or hybrid prediction from the user decision,
deadline and acceptable staleness. Real-time execution needs a demonstrated
benefit; a freshness allowance can make precomputation feasible on several tiers.
Then compare placement for the required regime.

## Start with Hard Constraints

Record the changed user decision, allowed population, quality floor, deadline,
freshness, action on uncertainty, expected load/duty cycle and maintenance horizon.
Then filter candidates using:

1. Permitted collection, transfer, retention and local processing boundaries,
   as established by the responsible owners.
2. Response deadline and connectivity: include network tail, outages and
   reconnection, not just model execution time. Check transfer energy separately:
   a path that meets its deadline can still exceed the power or battery budget.
3. Execution feasibility: supported operations/representation, peak memory,
   concurrent state and preprocessing/postprocessing.
4. Sustained throughput, power, battery, thermal and foreground-work constraints.
5. Update, observability, fallback and operational capability, including support,
   security updates, egress, distribution, labor and device replacement over the
   supported lifetime.

Do not turn illustrative device sizes or latency numbers into universal gates.
Use measured workload and target evidence.

## Compare Placement Options

| Placement | Useful when | Costs and failure conditions to evaluate |
| --- | --- | --- |
| Cloud | Central resources, updates and operations serve the workload within allowed data/network boundaries | Network tail/outage, transfer/egress cost, remote dependency and permitted data use |
| Edge/site | Local response or intermittent connectivity matters and local operations are supportable | Heterogeneous devices, physical access, local resource limits, sparse telemetry and rollout recovery |
| Mobile | User context, offline response or data minimization justifies device execution | Battery, thermal throttling, foreground contention, OS/runtime/delegate variation and update availability |
| TinyML/embedded | Always-on local decisions fit a constrained memory/power/duty-cycle envelope | SRAM and firmware limits, scarce telemetry, update recovery and limited model/operator support |
| Hybrid | Different stages benefit from different tiers | Cross-tier state/version skew, transfer delay, unavailable remote stages, telemetry/label gaps and coordinated rollback |

Choose the simplest option that satisfies the hard constraints and justified
ambition. A hybrid can train centrally and serve locally, perform local
preprocessing with remote prediction, or escalate selected cases to another tier.
The split is useful only if transfer, coordination and recovery costs preserve
the intended gain.

## Prove the Device Envelope

Define representative device tiers, including the weakest supported tier.
Check the actual exported artifact and runtime, with:

- weights plus peak activations/workspaces, preprocessing buffers, runtime
  overhead and concurrent state; serialized artifact size alone is insufficient;
- supported operators, shapes and precision, including slower fallback paths;
- end-to-end deadlines, sustainable throughput and input/feature freshness;
- sustained thermal/battery behavior, wakeup/cold start and foreground contention;
- interruption, connectivity loss, recovery and the intended fallback path.

Use [benchmark conditions](benchmark-contract-and-claims.md) to make runs
comparable. For visual workloads, the CV inference owner supplies target-device
or hardware-in-the-loop evidence; modality owners retain their quality and
slice criteria.

If the artifact fits but the sustained path fails, inspect memory peaks,
fallback operators, transfers and thermal/foreground conditions before buying
a larger device or shrinking the model. Change the candidate, tier, workload
or placement and verify the full quality/response envelope again.

## Make Hybrid Boundaries Explicit

For each tier boundary, record input/output meaning, timestamps and freshness,
feature/transform versions, decision policy, state ownership, telemetry and
label attribution. Name which work is allowed when a tier is unreachable.
Define whether stale cached results, local inference, deferral, refusal or
human review remains acceptable and for how long.

Release a compatible policy bundle: model and transforms, tier/routing choice,
runtime configuration, local-state compatibility, permitted adaptation if any,
monitoring and rollback destination. Keep a frozen known-good fallback where
local adaptation or intermittent updates can invalidate the active behavior.

Mixed versions during rollout or reconnection are expected possibilities.
Specify supported combinations and observed version identity rather than
assuming simultaneous fleet updates. Verify disagreement, stale-state,
partial-update and rollback behavior across tiers before expanding exposure.
AI platform owns cohort rollout, propagation and routing mechanics; ML supplies
quality gates and acceptable degraded behavior.

## Local Adaptation and Federated Limits

Local inference feasibility does not establish local training feasibility.
If adaptation is justified by measured product value, send execution and
coherent-restart work to `$neural-training-systems` and fleet policy to
`$ai-platform-llmops`. Define when adaptation pauses for foreground inference,
battery, thermal or connectivity conditions and how incompatible local state
returns to a validated fallback.

For federated proposals, account for cohort eligibility, participation/dropout,
rounds, downloads, uploads, retransmissions and energy. Compare lifecycle cost,
not one raw-data upload against one update. Device participation can bias
quality evidence toward well-connected, well-powered users.

Raw-data locality alone is not privacy. Updates, participation metadata and
downloads have their own exposure. Detailed secure aggregation, differential
privacy accounting and threat-control choices require appropriate specialist
evidence; do not infer those guarantees from placement.

## Acceptance and Handoff

Return a proportional decision record containing the selected placement,
rejected alternatives and binding constraints; supported population/device
tiers; benchmark and quality evidence; fallback and connectivity behavior;
update/state compatibility; remaining limits; and accountable owners.

Pass the workload, resource envelope, dependencies, rollout/rollback constraints
and recovery objectives to AI platform. Receive target/fleet feasibility,
version propagation and exercised recovery evidence. Pass SLO and incident
signals to SRE and feature/label/time semantics to data engineering. Verify
the implemented placement against the original product contract.

Revisit placement when the population, quality target, latency/freshness,
privacy boundary, workload, device/runtime, update cadence or fallback capacity
changes. Retirement must include old device cohorts and dependent local state,
not only removal of the central serving endpoint.

Source basis: *Machine Learning Systems, Volume I* on deployment paradigms and
target feasibility; *Volume II* on edge/federated operation and compatible fleet
release. Current devices, runtime APIs, prices and privacy guarantees require
targeted evidence; the durable guidance is the constraint and acceptance method.
