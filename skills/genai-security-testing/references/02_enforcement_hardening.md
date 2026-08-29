# Enforcement And Hardening

## Access Before Retrieval

Resolve caller identity and access attributes before candidate documents become visible. Test negative access cases and aggregate/differential queries, not just direct document requests. Preserve policy verdicts and filtered-result counts without logging protected content.

## Pre-Execution Policy

For a side-effecting tool, validate schema, ownership, permitted operation, argument provenance, business rules, current state, limits, and required approval before execution. Keep enforcement outside the model's natural-language reasoning where possible.

## Least Agency

Use the smallest tool set, permission scope, data exposure, network egress, token/cost budget, and action radius that serves the task. Use separate service identities, short-lived credentials, sandboxed environments, allow-listed destinations, rate limits, and a capability revocation path.

## Guardrails

Place controls at input, retrieval, tool/action, and output boundaries according to the threat. A fast lexical rule can be an early signal, not the sole control. Prefer deterministic validation for structured policy and reserve nuanced model/classifier checks for cases that require them.

## Irreversible Effects

Use propose -> deterministic validate -> authorized approve -> least-privileged execute for effects that cannot be reliably undone. Avoid approval fatigue by presenting the effect, target, evidence, and risk clearly, and by not asking for confirmation on routine reversible work.
