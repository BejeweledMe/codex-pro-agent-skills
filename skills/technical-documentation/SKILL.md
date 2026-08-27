---
name: technical-documentation
description: Create or revise architecture and design docs, API references, runbooks, and troubleshooting guides for practical technical use.
---

# Technical Documentation

Use this skill when the deliverable is documentation that helps someone understand, implement, operate, or repair a technical system. Choose the document shape that matches the reader's job; do not include template sections without useful content.

## Architecture or design document

Cover the problem and context, goals and non-goals, constraints, proposed design, interfaces or data flow, alternatives and trade-offs, risks, and validation or rollout. Record decisions and unresolved questions when they affect implementation.

## API reference

Describe the purpose, endpoint or operation, authentication and authorization requirements, input contract, output contract, error behavior, constraints, and a representative example. State versioning, idempotency, pagination, rate limits, or lifecycle behavior only when applicable.

## Runbook

Start with the trigger, scope, safety conditions, and prerequisites. Provide diagnostic checks, ordered actions, expected observations, verification, rollback or recovery, and escalation criteria. Distinguish commands that observe state from actions that change it.

## Troubleshooting guide

Start with recognizable symptoms and preconditions. Use diagnosis branches that help the reader narrow causes, then provide resolutions and validation. Call out known gaps, escalation paths, and evidence needed for further diagnosis.

## Documentation discipline

Document only confirmed behavior and explicitly marked proposals. Preserve conditions, permissions, and failure modes that make instructions safe and executable. Prefer examples, diagrams, code, and tables when they reduce ambiguity; keep them consistent with the described contract.
