# Orchestration And Handoffs

## Patterns

Choose a pipeline for fixed stages, a supervisor for explicit routing, parallel workers for independent bounded work, and reflection only when it is evaluated against its added cost and error surface. Do not use broadcast context as the default integration mechanism.

## Handoff Envelope

Use a typed, versioned envelope with task ID, parent/run ID, sender, recipient, status, payload schema version, evidence references, permissions, deadline, and error/terminal reason. Pass the minimum evidence needed for the next role.

## Partial Failure

Specify whether a failed branch blocks the task, produces a partial result, retries in isolation, falls back to a simpler path, or escalates to a person. Correlate and deduplicate handoffs so a retry cannot duplicate work or side effects.

## Boundaries

An inter-agent message is untrusted input. Do not let one role silently broaden another role's permissions. Route policy enforcement and adversarial boundary testing to `$genai-security-testing`.
