# Risk And Second-Order Effects

Related: [business thinking](01-business-thinking.md), [AI-assisted development](07-ai-assisted-development-dora.md), [Team Topologies](08-team-topologies-fast-flow.md), [presentation checklist](10-presentation-review-checklist.md)

## Purpose

Consulting-quality work includes the downside. A recommendation is incomplete if it only names benefits and ignores future costs, changed incentives, support burden, failure modes and reversibility.

## Core Idea

Ask not only "will this work?" but:

- What gets easier?
- What gets harder?
- Who pays the cost?
- What behavior will this incentivize?
- What breaks at scale?
- What will we regret in 3, 6 or 12 months?

## Risk Categories

- `Product risk`: wrong problem, low adoption, poor UX, trust loss.
- `Business risk`: weak ROI, bad pricing fit, sales/support mismatch.
- `Engineering risk`: complexity, reliability, security, performance, data quality.
- `Operational risk`: support load, manual processes, on-call, incident response.
- `Organization risk`: unclear ownership, handoffs, cognitive overload, incentives.
- `AI risk`: hallucinated outputs, unsafe automation, eval gaps, privacy leakage.
- `Reversibility risk`: hard rollback, migrations, contract commitments, user confusion.

## Second-Order Effect Checklist

- If adoption succeeds, what bottleneck appears next?
- If adoption fails, what sunk cost remains?
- Does the solution create new manual work?
- Does it shift work to support, QA, security or another team?
- Does it make metrics look better while user value is unchanged?
- Does it reduce one risk by increasing another?
- Does it create a dependency that slows future delivery?
- Does it require new monitoring, documentation or training?
- Can we roll back without damaging trust?

## Guardrails

Define before launch:

- primary success metric;
- quality guardrail;
- user trust or satisfaction guardrail;
- reliability/security guardrail;
- support/operations guardrail;
- owner;
- investigation threshold;
- rollback threshold.

## Example Risk Note

```text
Recommendation: enable AI draft replies for support agents.
Benefit: faster first response for repetitive tickets.
Risks: wrong tone, incorrect policy advice, privacy exposure, reviewer overtrust.
Second-order effect: reply volume may rise faster than QA can review.
Guardrails: sample review, policy violation rate, customer CSAT, escalation rate.
Rollback: disable for policy-sensitive ticket categories.
Owner: support tooling and support ops jointly.
```

## Red Flags

- Only optimistic case is described.
- "Risk" section is generic.
- No rollback condition.
- No owner after launch.
- No metric catches harm.
- Hidden work is treated as free.
- Team dependency is mentioned but not managed.

## Example Prompts

- "List second-order effects of this product decision."
- "Add downside, guardrails and rollback to this recommendation."
- "Find hidden work created by this AI feature."
- "Review this plan for future ownership and support cost."
