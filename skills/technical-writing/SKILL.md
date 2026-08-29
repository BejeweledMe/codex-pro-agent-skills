---
name: technical-writing
description: Create or revise technical documentation, architecture and design docs, API references, runbooks, troubleshooting guides, benchmarks, experiment reports, and engineering analyses.
---

# Technical Writing

Use this skill when a technical reader needs either an executable technical document or an analysis whose conclusions can be checked against evidence. Choose the mode that matches the reader's job; do not include template sections without useful content.

## Hierarchy And Handoffs

This is the primary owner for creating or substantively revising a technical
documentation or engineering-analysis artifact. Use
`information-research-synthesis` or `information-source-summary` only when the
evidence contract itself needs their specialized handling before the document is
drafted. Use `information-editing` as primary for a local copyedit, faithful rewrite,
or compression of an accepted technical document that leaves its technical contract
intact. Use `audience-adaptation` to adjust depth without removing contracts,
conditions, or failure behavior the document must preserve.

## Documentation mode

For architecture or design documents, cover the problem and context, goals and non-goals, constraints, proposed design, interfaces or data flow, alternatives and trade-offs, risks, rollout or validation, decisions, and unresolved questions when relevant.

For API references, describe the purpose, operation or endpoint, authentication and authorization, input and output contracts, errors, constraints, and a representative example. State versioning, idempotency, pagination, rate limits, or lifecycle behavior only when applicable.

For runbooks, start with the trigger, scope, safety conditions, and prerequisites. Give diagnostic checks, ordered actions, expected observations, verification, rollback or recovery, and escalation criteria. Distinguish state-observing commands from actions that change state.

For troubleshooting, start with recognizable symptoms and preconditions. Use diagnosis branches to narrow causes, then give resolutions, validation, known gaps, escalation paths, and evidence needed for deeper diagnosis.

Document only confirmed behavior and explicitly marked proposals. Preserve permissions, conditions, and failure modes that make instructions safe and executable.

## Analysis mode

Use this mode for evaluations, benchmarks, experiments, architecture assessments, and engineering research reports. Support a fast conclusion-first read and a technical review of the evidence.

Use the sections that fit: summary, problem, scope and criteria, method, results, analysis, risks and limitations, recommendation, and next validation or implementation step.

Keep results distinct from interpretation whenever they can be confused. Include the conditions that make a metric meaningful, such as data and split, system version, hardware, load, threshold, configuration, or time window. Use tables for comparable measurements and plots for trends or distributions.

Do not turn the report into a lab notebook. Include failed experiments only when they explain a conclusion, rule out a realistic option, or expose a material risk.
