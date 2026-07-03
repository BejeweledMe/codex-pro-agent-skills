# Product Discovery And Market Analysis

Related: [business thinking](01-business-thinking.md), [MECE issue trees](04-mece-issue-trees.md), [risk](09-risk-and-second-order-effects.md), [product design reference](../../product-design/references/00-index.md)

## Purpose

Product and market analysis asks whether a solution is worth building, for whom, why now and under what constraints. It prevents teams from treating a market, user segment or product bet as a generic feature request.

## Direct Source

The source set does not provide a full market analysis methodology. It provides the communication and problem-structuring layer: SCR/SCQA for framing, Pyramid Principle for synthesis, MECE for segmentation, SPACE/DORA for productivity impact, and Team Topologies for organizational feasibility.

## Extension For Product Development

Use this file as a bridge between consulting structure and product discovery. For deeper UI/UX and discovery methods, use the [product-design reference](../../product-design/references/00-index.md).

## Product Discovery Questions

- Who is the user, buyer, operator and blocker?
- What job, pain or desired progress is involved?
- What is the current workaround?
- Why does the current solution fail?
- What triggers urgency?
- What would count as first value?
- What alternatives compete with this solution?
- What adoption friction exists?
- What business model or operational constraint matters?
- What risk would make the solution unacceptable?

## Market Analysis Questions

- Which segment has the strongest pain and ability to adopt?
- What category or substitute does the buyer compare us against?
- Is the market pull strong enough to overcome switching cost?
- What external timing matters: regulation, platform shift, competitor launch, budget cycle, AI capability change?
- What distribution or sales channel is realistic?
- What proof would make the opportunity more credible?
- What would show that the market is not ready?

## A Lightweight Market/Product Memo

```text
Recommendation:
Target segment:
Situation:
Complication:
User pain:
Business value:
Alternatives and competitors:
Adoption friction:
Risks:
Evidence we have:
Evidence we need:
Next decision:
```

## Evidence Ladder

Prefer stronger evidence before large irreversible work:

1. Internal stakeholder opinion.
2. Support/sales anecdotes.
3. Qualitative user interviews.
4. Behavioral product data.
5. Concierge/manual test.
6. Prototype or fake-door test.
7. Limited release with guardrails.
8. Full release with instrumentation.

## UI/UX Review Through Business Lens

When reviewing UI/UX, do not only check visual quality. Ask:

- Does the interface make the user's decision easier?
- Does it expose the business-critical action clearly?
- Does it reduce cognitive load or push complexity to the user?
- Are error states tied to recovery, not only messages?
- Are metrics instrumented for task success and failure?
- Does the UX create support burden or compliance risk?
- Does it align with the product outcome, not just the design system?

## Red Flags

- "Users" means everyone.
- The solution is described before the problem.
- Market size is used as proof of demand.
- Competitors are ignored because "our UX is better".
- The memo has no adoption friction.
- No one names the buyer or budget owner.
- UI review stops at layout and misses task success.

## Example Prompts

- "Write a product/market memo using SCR and MECE segments."
- "Identify the current workaround and adoption friction for this feature."
- "Review this UI through user value, business value and support burden."
- "What evidence would make this product bet worth building?"
