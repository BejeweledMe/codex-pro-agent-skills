# AI-Assisted Development With DORA

Related: [developer productivity SPACE](06-developer-productivity-space.md), [Team Topologies](08-team-topologies-fast-flow.md), [risk](09-risk-and-second-order-effects.md), [ML system design reference](../../ml-system-design/references/00_README.md)

## Purpose

AI in development should be treated as a socio-technical change, not an IDE plugin rollout. It can speed up work, but it can also amplify unclear ownership, poor review practices, weak tests, bad requirements and downstream chaos.

## Direct Source

DORA 2025 states that AI's primary role is as an amplifier: it magnifies an organization's existing strengths and weaknesses. The DORA page also emphasizes that returns come from focus on the underlying organizational system, not the tools alone.

Public DORA/Google summary pages also highlight the DORA AI Capabilities Model, Value Stream Management as a way to connect local gains to product performance, and team profiles for diagnosing different adoption contexts. This folder does not enumerate the full model because the full report content was not fully ingested.

## Extension For Product Development

For agents and AI coding tools, the practical rule is:

> AI improves a well-structured workflow and scales a poorly structured workflow.

Therefore evaluate AI adoption at workflow, team and value-stream level.

Ask which capability is being improved: developer fluency, review quality, value-stream visibility, governance, platform support, testing/evals or another organizational practice.

## AI Adoption Memo

```text
Use case:
User/team:
Current bottleneck:
Expected benefit:
Quality risk:
Security/privacy risk:
Review loop:
Evals/tests:
Metrics:
Guardrails:
Owner:
Rollout plan:
Rollback condition:
```

## What To Measure

- Developer experience and satisfaction.
- Lead time and wait time.
- Rework and review churn.
- Defect escape rate.
- Security and privacy incidents.
- Test quality and coverage relevance.
- Documentation quality.
- Support burden.
- Business/product outcome.

Tie metrics to value stream movement. Local speed is not enough if review, QA, security, operations or customer value become the new bottleneck.

Use [SPACE](06-developer-productivity-space.md) to avoid a one-dimensional view.

## Governance Questions

- Which code or data is allowed in AI tools?
- Which changes require human review?
- Which domains are high risk: payments, auth, security, legal, medical, finance?
- Are prompts, evals and outputs traceable enough for review?
- How are generated changes tested?
- Who owns failures introduced through AI assistance?
- What training or guidance do developers need?

## Value Stream Questions

- Where does work wait today?
- Does AI reduce a real bottleneck or just create more upstream output?
- Does faster code generation overload review, QA, security or support?
- Does it improve the product outcome or only activity?
- Does it reduce cognitive load or increase it?

## Red Flags

- AI adoption is justified by "faster coding" only.
- No evals, tests or review policy.
- Generated code is trusted because it compiles.
- Sensitive code/data flows into unmanaged tools.
- AI increases PR volume but slows review.
- No one measures defects, rework or downstream support.
- Teams use AI to compensate for unclear requirements.

## Example Prompts

- "Apply DORA 2025 thinking to this AI coding rollout."
- "Find what AI will amplify in this team's current system."
- "Design metrics and guardrails for agentic coding in this repo."
- "Separate tool adoption from organizational capability improvement."
