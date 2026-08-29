# Capability Selection

## Start With The Failure

Write a task contract before selecting a pattern: user action, allowed and forbidden
outcomes, facts the system may use, freshness and citation needs, privacy boundary,
language/modality, traffic, latency/cost budget, and fallback. Build task-specific
cases that expose the important errors.

Use the least complex path that closes a measured gap:

| Observed need | First candidate | Do not use it as a substitute for |
|---|---|---|
| Deterministic transform, fixed schema, known rules | Code, rules, or structured validation | Ambiguous judgment or missing knowledge |
| Fluent generation with stable public knowledge | Prompt plus output validation | Fresh, private, or access-controlled facts |
| Fresh, attributable, or permissioned evidence | RAG | A behavior or capability gap in the model |
| Stateful tool use, uncertain route, replanning, recovery | Agent workflow | A fixed sequence that can be a pipeline |
| Stable domain behavior/format after simpler paths fail | Model adaptation | Missing corpus governance, evaluation, or access control |

The table chooses an architectural pattern, not its detailed implementation. Delegate
RAG, agents, and adaptation to their primary skills once selected.

## Combination Is A Design Choice

Patterns can coexist. A support product may use RAG for facts, a small bounded agent
for account actions, and an adapted model for a stable format. For every component,
state the evidence it contributes, the failure it can introduce, its owner, and the
fallback when it is unavailable.

Avoid a component that has no measurable role. A model that already meets the task
does not need RAG merely because a corpus exists; a deterministic lookup does not
need an agent merely because tools are available.

## Decision Evidence

Compare alternatives on the same task slices. Record task quality, groundedness or
access correctness where applicable, latency distribution, cost per completed task,
failure mode, and operating complexity. A general benchmark, token price, or model
name is only a shortlist input, not the decision.
