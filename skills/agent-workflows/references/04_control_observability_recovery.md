# Control, Observability, And Recovery

## Hard Limits

Set maximum steps, deadline, token/cost budget, concurrency, retry count, and repeated-action threshold. Define a progress predicate and stop condition in executable state/control logic, not only in natural-language instructions.

## Trace Contract

Record run and task IDs; state transition; prompt/model/config version; tool selection and redacted arguments/results; handoffs; policy verdicts; latency; token/cost; error; and terminal reason. Avoid logging secrets or protected data; retain evidence references when raw values cannot be stored.

## Recovery

Decide whether to resume from checkpoint, replay an idempotent stage, route to a deterministic fallback, produce a partial result, or request human review. Test recovery against interrupted runs and partial external effects.

## Release

Release model, prompt, tool schema, workflow definition, policy, and runtime configuration as an attributable bundle. Use a canary or limited route when warranted. Roll back to a previously verified bundle and convert confirmed production failures into redacted regression cases with `$agent-llm-evals`.
