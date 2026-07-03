---
name: product-design
description: Use when designing, reviewing, validating, debugging, or improving products, product discovery, UI/UX, AI/ML product experiences, design systems, product metrics, business outcomes, assumption tests, user research plans, opportunity-solution trees, feature proposals, product requirements, UX reviews, launch/readiness plans, governance, adoption, and long-term product maintenance.
---

# Product Design

Use this skill to design or review products end to end. Treat product design as the connection between customer outcomes, business results, discovery evidence, usability, feasibility, viability, UI/UX quality, AI trust, design systems, metrics, release safety, and maintenance.

## Core Rule

Do not start from a screen, component, model, or feature. First clarify the user, context, desired outcome, opportunity, evidence, assumptions, risks, success metrics, guardrails, fallback, ownership, and maintenance path.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/00-index.md` for broad product design work or to choose a route.
- For shared vocabulary, read `references/01-terminology.md`.
- For organization, empowered teams, outcomes over output, product roles, and value/usability/feasibility/viability risks, read `references/02-product-operating-model.md`.
- For product discovery, opportunity-solution trees, outcome -> opportunities -> solutions -> assumptions, and discovery anti-patterns, read `references/03-discovery-and-opportunity-solution-trees.md`.
- For interview planning, research questions, story-based interviews, user evidence, and synthesis, read `references/04-user-research-and-interviewing.md`.
- For validation plans, assumption tests, experiment selection, AI validation, UI validation, and readiness to build, read `references/05-validation-and-assumption-tests.md`.
- For AI/ML product UX, AI-vs-non-AI decisions, data needs, explainability, automation, model errors, and feedback loops, read `references/06-ai-ml-product-ux.md`.
- For calibrated trust, confidence, user control, correction, undo, fallback, granular feedback, and global controls, read `references/07-calibrated-trust-and-human-control.md`.
- For UI/UX product quality, states, accessibility extensions, instrumentation, design system fit, and implementation quality, read `references/08-ui-ux-product-quality.md`.
- For design systems as product infrastructure, design tokens, components, docs, users, ownership, and AI support, read `references/09-design-systems-as-product.md`.
- For design system governance, contribution, adoption, buy-in, documentation, automation, and metrics, read `references/10-design-system-governance-adoption-metrics.md`.
- For business outcomes, product metrics, guardrails, leading/lagging indicators, AI metrics, and design system metrics, read `references/11-business-outcomes-and-product-metrics.md`.
- For concrete review and design checklists, read `references/12-agent-product-design-checklists.md`.
- For red flags and failure modes, read `references/13-anti-patterns.md`.

## Workflow

1. Classify the request:
   - New product or feature: read `00`, `01`, `02`, `03`, `05`, `11`, then topic files.
   - Product discovery: read `03`, `04`, `05`, `11`, `13`.
   - User research plan: read `04`, then `03`, `05`, and `11` if the research drives prioritization.
   - AI/ML product or assistant UX: read `06`, `07`, `05`, `08`, `11`, `13`.
   - UI/UX review or frontend implementation: read `08`, then `07` for AI flows, `09` for design-system fit, and `12` for checklists.
   - Design system work: read `09`, `10`, `11`, `13`.
   - Metrics, validation, or launch readiness: read `05`, `11`, `12`, and topic files for the relevant surface.
   - Fact-checking or source-sensitive work: read `14` and `sources` before making strong claims.
2. Identify blocking unknowns. Ask only when missing information changes the decision; otherwise state assumptions.
3. Separate outcome, opportunity, solution, and assumptions.
4. Evaluate value, usability, feasibility, and viability before committing to a solution.
5. Produce practical recommendations with validation, metrics, guardrails, fallback, ownership, and maintenance.
6. Mark any recommendation not grounded in the references as `external extension`.

## Output For New Product Or Feature Design

Include:

- User, context, and job/problem.
- Business problem and desired outcome.
- Current evidence and source quality.
- Opportunities and selected target opportunity.
- Candidate solutions, including simpler non-AI/non-custom alternatives when relevant.
- Critical assumptions and validation plan.
- Value, usability, feasibility, and viability risks.
- UI/UX requirements, states, accessibility, instrumentation, and design-system fit.
- AI capabilities, limits, feedback, correction, fallback, and controls when AI is involved.
- Product metrics, business metrics, guardrails, and thresholds.
- Rollout, support, monitoring, ownership, maintenance, and future-change plan.

## Output For Product Or UX Review

Lead with risks and missing decisions:

- Outcome and user-context gaps.
- Unsupported opportunities or solution-first thinking.
- Weak or missing value/usability/feasibility/viability validation.
- AI trust, uncertainty, correction, or fallback gaps.
- UI state, accessibility, instrumentation, and implementation gaps.
- Design-system governance, adoption, or component-fit risks.
- Metric and business-impact gaps.
- Concrete fixes, experiments, and questions to unblock the work.

## Output For AI/ML Product UX

Prioritize:

1. Decide whether AI is needed and compare non-AI baselines.
2. Define user benefit, data needs, model-quality risks, and error costs.
3. Design expectations: capabilities, limits, uncertainty, explanations.
4. Preserve control: dismiss, correct, edit, undo, retry, manual path.
5. Plan feedback loops, tuning, monitoring, behavior-change communication, and fallback.
6. Connect model metrics to user and business outcomes.

## Output For Design Systems

Include:

- System users and repeated product needs.
- Current artifacts: design, code, tokens, docs, examples, tests.
- Governance model and decision rights.
- Contribution path and quality gates.
- Adoption blockers and migration plan.
- Metrics across adoption, quality, speed, consistency, community, and business impact.
- Documentation, release notes, versioning, deprecation, support, and ownership.

## Quality Bar

- Do not equate output with outcome.
- Do not call a need an opportunity until it is backed by customer evidence or clearly marked as an assumption.
- Do not jump from opportunity to one solution without alternatives and assumption tests.
- Do not add AI without proving unique AI value and designing uncertainty, correction, fallback, and control.
- Do not call a UI product-ready without non-happy-path states, accessibility basics, instrumentation, error handling, and ownership.
- Do not call a design system mature because it has a UI kit or component package; require adoption, governance, docs, release process, and metrics.
- Do not overclaim source coverage. Rosenfeld notes are based only on public pages/samples, and zeroheight survey data must keep its sample limitations.
