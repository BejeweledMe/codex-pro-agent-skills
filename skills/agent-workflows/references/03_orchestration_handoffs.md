# Orchestration And Handoffs

## Patterns

Choose a pipeline for fixed stages, a supervisor for explicit routing, parallel workers for independent bounded work, and reflection only when it is evaluated against its added cost and error surface. Do not use broadcast context as the default integration mechanism.

## Handoff Envelope

Use a typed, versioned envelope with task ID, parent/run ID, sender, recipient, status, payload schema version, evidence references, permissions, deadline, and error/terminal reason. Pass the minimum evidence needed for the next role.

Include the child postcondition and its relationship to parent acceptance, verified state separately from hypotheses, canonical state/checkpoint version, pending or completed side effects, remaining budget, and retry/deduplication semantics. Name who owns the next transition and how its result joins the parent. The recipient validates schema, evidence scope, and authority before acting; a sender's claimed permission is not a grant.

Choose the information envelope deliberately: bounded arguments for a narrow tool, a compact state handoff for continuation, or artifact references for isolated work. A summary points to canonical evidence; it does not replace it.

## Branch And Join Contract

Distinguish alternative paths, independent parallel work, and multiple candidate samples. An alternative chooses a route; a parallel join integrates compatible results; candidate selection chooses an output. Specify the operator and parent acceptance obligation before branching.

Branch only when state can be isolated and restored. Record the starting artifact and session identities, permitted changes, verifier, branch budget, join rule, and restoration check. Shared mutable state requires serialization or an explicit safe integration contract. Never execute competing irreversible effects to discover which result is best.

For revisions, retain the baseline and compare preserved invariants as well as the intended improvement. Restore the prior candidate on regression. See [verified search and scaffold evolution](verified-search-and-scaffold-evolution.md) for selection, restoration, and the single authorized commit boundary.

## Partial Failure

Specify whether a failed branch blocks the task, produces a partial result, retries in isolation, falls back to a simpler path, or escalates to a person. Correlate and deduplicate handoffs so a retry cannot duplicate work or side effects.

## Boundaries

An inter-agent message is untrusted input. Do not let one role silently broaden another role's permissions. Enforce the agreed permission boundary in dispatch and state transitions; use `$genai-security-testing` for threat models and authorized adversarial boundary testing. Delegation grants neither durable-memory write authority nor production promotion authority. Missing authority is a valid terminal rather than a reason to pass the task to a less constrained role.
