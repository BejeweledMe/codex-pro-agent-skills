# Control, Observability, And Recovery

## Hard Limits

Set maximum steps, deadline, token/cost budget, concurrency, retry count, and repeated-action threshold. Define a progress predicate and stop condition in executable state/control logic, not only in natural-language instructions.

Account for generation, retrieval, tool execution, revision, verification, routing, and review in the total budget. Reserve enough capacity for required verification and safe stopping. Repetition without new evidence or a changed hypothesis is stagnation; stop or choose a justified recovery path. Do not extend limits merely because no candidate passed.

## Protected Control Plane

The candidate may change only the declared mutation target. Keep evaluator code/configuration, permission policy, authoritative telemetry and execution records, resource limits, release holdout, and promotion authority outside its writable scope. Enforce this through the host, tool permissions, and execution environment rather than a prompt prohibition alone.

The workflow may submit observations and proposed changes through bounded interfaces; it cannot rewrite the authoritative record, weaken its gate, or approve itself. A proposed evaluator or policy improvement follows a separate authorized change process with its own evidence. `$agent-llm-evals` owns harnesses, graders, calibration, and gates; the authorized release owner decides promotion.

## Trace Contract

Record run and task IDs; state transition; prompt/model/config version; tool selection and redacted arguments/results; handoffs; policy verdicts; latency; token/cost; error; and terminal reason. Avoid logging secrets or protected data; retain evidence references when raw values cannot be stored.

Link observations to evidence and verification verdicts. For stateful effects, include operation identity, external session, pre/postcondition, state/checkpoint version, and whether the outcome is confirmed or unknown. For revisions and promotion, link baseline/candidate identities, comparison evidence, authorization, and the resulting version. Record observable actions and outcomes, not hidden reasoning.

## Recovery

Decide whether to resume from checkpoint, replay an idempotent stage, route to a deterministic fallback, produce a partial result, or request human review. Test recovery against interrupted runs and partial external effects.

Before resuming, check the checkpoint against canonical artifacts, recorded external effects, remaining budgets, and current authority. Resolve uncertain effects through authoritative reconciliation or protected idempotent replay under the [retry contract](02_tools_state_contracts.md#retry-and-compensation); keep dependent work blocked until its required outcome is established. Replaying a transcript does not restore a browser session, transaction, or external record. If exact restoration is impossible, mark affected state unknown and use a safe recovery path, fallback, or blocking terminal. See [durable memory and context lifecycle](durable-memory-and-context-lifecycle.md).

## Failure Diagnosis

Locate the first invalid transition before changing the model or adding agents. Distinguish workflow/model error from tool, environment, stale-state, permission, and evaluator failure.

| Symptom | Distinguishing evidence | Action and verification |
| --- | --- | --- |
| Tool reports success but task is incomplete | Requested postcondition versus authoritative external state | Repair semantic validation or await actual completion; verify the intended result |
| Same action repeats | Error class, operation identity, and progress predicate | Bound retry; resolve uncertain effects under the [retry contract](02_tools_state_contracts.md#retry-and-compensation); stop when no safe recovery or progress path remains |
| Resume pursues an obsolete goal | Ledger, checkpoint, artifact versions, and current task contract | Reconcile state and rebuild context before further effects |
| Revision removes working behavior | Baseline/candidate invariant results | Restore known-good state and localize the regression |
| Score improves without accepted outcomes | Search scores versus independent acceptance evidence | Stop optimization and investigate verifier exploitation with `$agent-llm-evals` |
| Candidate changes checks, logs, or limits | Protected configuration and external execution records | Reject the candidate; restore trusted controls before another run |

Preserve tool execution status separately from the task acceptance verdict. Supply task classes, attributable traces, confirmed and unknown effects, restoration results, and baseline/revision comparisons to `$agent-llm-evals`; that owner defines metrics, graders, calibration, and release evidence.

## Release

Release model, prompt, tool schema, workflow definition, policy, and runtime configuration as an attributable bundle. Use a canary or limited route when warranted. Roll back to a previously verified bundle and convert confirmed production failures into redacted regression cases with `$agent-llm-evals`.

Include the applicable dispatcher, context/memory policy, state/checkpoint compatibility, evaluation evidence, and release authorization in that attribution. The search winner is a candidate until the independent acceptance gate and authorized promotion decision pass. Existing scoped authorization may cover promotion; search or read authority alone does not.

Before rollback, check that the previous bundle remains compatible with current state and permitted access. Restoring workflow code must not silently restore revoked permissions, superseded memory, or expired evidence. Route generic storage recovery to `$system-design` and operational incident/reliability decisions to `$sre-reliability-engineering`, carrying the affected bundle, state, effects, and recovery evidence.
