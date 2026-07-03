# Agent Operating Model And Skill Outline

Related: [reference index](00_README.md), [business thinking](01-business-thinking.md), [presentation checklist](10-presentation-review-checklist.md)

## Purpose

This file describes how a future Codex skill should use the knowledge folder. It is not the skill itself, but a blueprint for one or more skills around business/product consulting for software development.

## Trigger Situations

Use this knowledge when the user asks for:

- product strategy;
- PRD, RFC, deck, memo or executive summary;
- business value analysis;
- market or product opportunity analysis;
- UI/UX review with product/business lens;
- developer productivity measurement;
- AI-assisted development rollout;
- organization, ownership, platform or team design;
- future risks and second-order effects;
- "think like a consultant" review of a software/product decision.

## Agent Workflow

1. Classify the request: communication, problem framing, product/market analysis, productivity, AI adoption, org design, risk review.
2. Read only relevant references.
3. Write an answer-first recommendation or problem statement.
4. Use SCR/SCQA to frame context and tension.
5. Use MECE/issue tree when the problem needs decomposition.
6. Use SPACE for developer productivity claims.
7. Use DORA for AI-assisted development claims.
8. Use Team Topologies for ownership, dependencies and flow.
9. Add risks, guardrails and open questions.
10. Produce a decision-ready output.

## Routing

- Communication or deck: read [02](02-scr-scqa-communication.md), [03](03-pyramid-principle.md), [10](10-presentation-review-checklist.md).
- Ambiguous product task: read [01](01-business-thinking.md), [04](04-mece-issue-trees.md), [05](05-product-discovery-and-market-analysis.md).
- UI/UX review: read [05](05-product-discovery-and-market-analysis.md), [10](10-presentation-review-checklist.md), then route to the [product-design reference](../../product-design/references/00-index.md).
- AI/dev productivity: read [06](06-developer-productivity-space.md), [07](07-ai-assisted-development-dora.md), [09](09-risk-and-second-order-effects.md).
- Org/architecture/platform: read [08](08-team-topologies-fast-flow.md), [09](09-risk-and-second-order-effects.md).

## Output Standards

Every substantial answer should include:

- recommendation or main finding;
- situation and complication;
- evidence or assumptions;
- alternatives or trade-offs;
- business/user value;
- risk and guardrails;
- next decision or next test.

For review tasks, lead with risks and missing decisions.

When mixing source-backed facts with applied product guidance, use this discipline:

```text
Source-backed:
Applied extension:
Assumptions:
Open questions:
```

This prevents the agent from attributing practical engineering heuristics to a source that only supports the underlying framework.

## Quality Bar

- Do not hide behind frameworks. Use them only when they clarify the decision.
- Do not invent market facts without current evidence.
- Do not use a single productivity metric.
- Do not claim AI ROI without workflow and quality guardrails.
- Do not propose organization changes without ownership and flow implications.
- Mark extensions beyond sources as `extension`.

## Future Skill Split

One broad skill is enough for the first version:

- `business-product-consulting`: problem framing, communication, market/product analysis, metrics, risk, org flow.

Possible split if it grows:

- `executive-communication-and-decks`;
- `product-market-analysis`;
- `developer-productivity-and-ai-adoption`;
- `org-design-team-topologies`.
