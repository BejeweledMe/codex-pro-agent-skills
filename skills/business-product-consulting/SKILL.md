---
name: business-product-consulting
description: "Use for product and engineering strategy, business cases, market or portfolio choices, operating-model and ownership decisions, executive recommendations, and structured tradeoff analysis. For user discovery, UX, design systems, or product requirements, use product-design as the primary owner."
---

# Business Product Consulting

Use this skill to make product engineering work decision-ready: clarify business context, user value, stakeholder decision, metrics, risks, organizational flow, and communication storyline before proposing implementation.

## Core Rule

Do not start from the feature, screen, model, library, architecture, or implementation. First clarify the situation, complication, stakeholder, decision, desired outcome, alternatives, business/user value, risks, metrics, ownership, and next test or ask.

## Hierarchy And Handoffs

This skill owns decision framing above the feature: stakeholder choice, business
value, alternatives, market and portfolio logic, operating model, organization,
second-order effects, and an executive-ready recommendation. Start here when a leader
or team must choose a direction rather than design a specific experience.

Use `$product-design` as the primary owner when the unresolved question is user
research, opportunity discovery, UX behavior, interaction design, design-system work,
or product requirements. Use this skill afterwards to synthesize the business
decision from that evidence. Do not use a strategic memo as a substitute for discovery
evidence.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/00_README.md` for broad business/product consulting work.
- For translating a ticket into business/user value, stakeholder decision, outcomes, constraints, non-goals, or realized economics, read `references/01-business-thinking.md`.
- For executive updates, PRDs, RFCs, strategy memos, postmortems, emails, and concise narrative framing, read `references/02-scr-scqa-communication.md`.
- For answer-first communication, storyline, synthesis, argument quality, and executive summaries, read `references/03-pyramid-principle.md`.
- For problem decomposition, root-cause analysis, issue trees, workstreams, segmentation, roadmap options, and taxonomy design, read `references/04-mece-issue-trees.md`.
- For product discovery, market/opportunity analysis, value proposition, adoption friction, competitor/alternative framing, and UI/UX review through product/business outcomes, read `references/05-product-discovery-and-market-analysis.md`.
- For developer productivity, dev tooling, platform/productivity claims, engineering metrics, and avoiding vanity metrics, read `references/06-developer-productivity-space.md`.
- For AI-assisted software development, agentic coding, AI tool rollout, evals, guardrails, governance, and value-stream impact, read `references/07-ai-assisted-development-dora.md`.
- For organization design, team ownership, platform/product boundaries, cognitive load, dependencies, and fast flow, read `references/08-team-topologies-fast-flow.md`.
- For downside analysis, future impact, hidden work, support burden, operational risk, rollback, and guardrails, read `references/09-risk-and-second-order-effects.md`.
- For reviewing decks, memos, RFCs, demo narratives, UI/UX narratives, and leadership updates, read `references/10-presentation-review-checklist.md`.
- For creating or updating a future skill, routing behavior, output discipline, or agent operating model, read `references/11-agent-operating-model-and-skill-outline.md`.

## Workflow

1. Classify the request:
   - Ambiguous product/engineering task: read `01`, then `04`, `05`, and `09` as needed.
   - PRD, RFC, deck, memo, executive update, or presentation review: read `02`, `03`, and `10`.
   - Product/market analysis or opportunity framing: read `01`, `04`, `05`, and `09`.
   - UI/UX review: read `05` and `10`, then use the product-design skill/knowledge when deeper UI/UX methods are needed.
   - Developer productivity or tooling: read `06`, plus `09`.
   - AI-assisted development or agents in engineering workflows: read `07`, then `06` and `09`.
   - Org design, ownership, platform, architecture dependencies, or team flow: read `08`, then `09`.
2. Identify blocking unknowns. Ask only if the missing information changes the decision; otherwise state assumptions.
3. Start with an answer-first recommendation or a crisp problem statement.
4. Use SCR/SCQA to frame context and urgency.
5. Use MECE/issue trees only when decomposition clarifies the decision.
6. Connect every recommendation to user value, business value, metrics, risks, and ownership.
7. Separate `Source-backed`, `Applied extension`, `Assumptions`, and `Open questions` when the answer mixes framework facts with product-engineering inference.

## Output For Product Or Business Framing

Include:

- Situation and complication.
- Stakeholder and decision needed.
- User/customer/buyer/operator affected.
- Desired product and business outcome.
- Alternatives and trade-offs.
- Evidence, assumptions, and uncertainty.
- Success metrics and guardrails.
- Risks, second-order effects, and rollback/owner.
- Recommended next test or next decision.

## Output For Communication Review

Lead with storyline quality and missing decisions:

- Main answer or recommendation.
- Whether SCR/SCQA is clear.
- Whether the Pyramid Principle holds: one governing thought, grouped reasons, evidence, and `so what`.
- Whether MECE grouping is clean enough for the decision.
- Missing risks, trade-offs, metrics, or asks.
- Concrete rewrite or outline.

## Output For Developer Productivity Or AI Adoption

Include:

- Current bottleneck and value stream.
- SPACE dimensions or DORA AI capability being improved.
- Expected benefit and failure mode.
- Quality, security, privacy, review, and eval guardrails.
- Metrics across outcome, flow, quality, satisfaction, and rework.
- Rollout, rollback, owner, and downstream impact.

## Output For Org, Platform, Or Architecture Flow Review

Include:

- Value stream and owning team.
- Team types and interaction modes where useful.
- Cognitive-load and handoff risks.
- Platform-as-product or thinnest viable platform considerations.
- Dependencies, service boundaries, team API, and owner.
- How the relationship should evolve as learning changes.

## Quality Bar

- Do not present frameworks as proof. Use them to structure evidence and decisions.
- Do not claim market facts, competitor facts, legal facts, pricing facts, or current tool status without current evidence.
- Do not call productivity improved from activity metrics alone.
- Do not recommend AI rollout without evals, human review policy, guardrails, and ownership.
- Do not recommend org/platform changes without explicit owner, interaction mode, cognitive-load impact, and fast-flow rationale.
- Mark ideas beyond the bundled sources as `Applied extension` or `external extension`.
