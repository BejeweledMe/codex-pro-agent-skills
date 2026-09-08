# Product Design Anti-Patterns

Related: [operating model](02-product-operating-model.md), [discovery](03-discovery-and-opportunity-solution-trees.md), [AI UX](06-ai-ml-product-ux.md), [design systems](09-design-systems-as-product.md), [checklists](12-agent-product-design-checklists.md)

## Feature Roadmap As Strategy

Symptom: strategy is a list of features and dates.

Why it fails: outputs do not guarantee outcomes. Teams lose room to discover better solutions.

Fix: connect work to outcomes, target users, opportunities and assumptions while retaining prioritization and coordination around consequential dates. Distinguish candidate scope, forecasts and promises; a published feature list can become a perceived commitment even when called a hypothesis. Preserve existing commitments until properly changed. Report baseline, intended outcome, observed effect and what changes next; see [operating model](02-product-operating-model.md) and [metrics](11-business-outcomes-and-product-metrics.md).

## Solution-First Discovery

Symptom: team starts with `build chatbot`, `add dashboard`, `make new onboarding`.

Why it fails: solution may not address real opportunity.

Fix: for an unresolved product choice, establish the user need, compare alternatives and assess assumptions. A specified implementation can reuse accepted decisions and evidence; it does not automatically need new discovery.

## Design As A Request Queue

Symptom: designers receive fixed requirements and return polished screens while others choose the solution.

Why it fails: staffing a design function does not provide early understanding, alternatives or influence over the experience.

Fix: for solution discovery, involve design in user learning, constraints and alternative exploration before detailed polish; iterate with product and engineering. Centralized design capabilities and bounded production work remain legitimate. See [roles](02-product-operating-model.md).

## Opportunity From Internal Opinion

Symptom: opportunities are brainstormed from team opinions.

Why it fails: internal teams bring bias and half-truths.

Fix: use customer stories, interviews, observation and contextual signals. Support/sales/analytics can inspire but often need follow-up.

## Company-Wide OST

Symptom: one massive opportunity solution tree for the whole company.

Why it fails: Product Talk frames OST as a tool for one product trio and outcome; company-wide trees become unwieldy.

Fix: use KPI tree or company-wide experience map for strategy view; use OST per team/outcome.

## Asking Users To Design The Product

Symptom: interviews ask `what feature do you want?`.

Why it fails: users often cannot predict future behavior or design good solutions.

Fix: ask for stories, behavior, context, workarounds, meaning and decision criteria.

## Validation Theater

Symptom: tests exist but cannot change the decision.

Why it fails: evidence becomes decoration.

Fix: define the decision, assumption, suitable method and possible next actions. Prespecify criteria for confirmatory decisions; preserve changes and new hypotheses in exploratory learning. Label a fictional future customer letter as a framing device, never as an actual customer response or proof of demand. See [validation](05-validation-and-assumption-tests.md).

## AI Because Possible

Symptom: team adds AI because AI is trendy or available.

Why it fails: AI increases uncertainty, maintenance, privacy and error risks.

Fix: prove unique AI value against simpler approaches. Keep non-AI fallback.

## Hidden AI Limits

Symptom: UI presents AI output as certain and complete.

Why it fails: users overtrust, make poor decisions and lose trust after failure.

Fix: explain capabilities, limits, uncertainty, correction and fallback.

## Numeric Confidence Without Comprehension

Symptom: UI shows `92% confidence` and assumes users understand.

Why it fails: confidence can mislead. Users may not know how to act.

Fix: test comprehension. Use labels, warnings, explanations, review gates or alternatives where better.

## Full Automation In High-Risk Flow

Symptom: system acts without review in a high-stakes context.

Why it fails: user responsibility, legal risk, financial or emotional stakes may require control.

Fix: augment first. Add preview, edit, approve, undo, manual mode and audit trail.

## Design System As Finished UI Kit

Symptom: system is considered done after components exist in Figma.

Why it fails: no code, docs, governance, release, contribution or adoption.

Fix: treat design system as product infrastructure with users, metrics, support and maintenance.

## Metrics Without Outcome

Symptom: reports show page views, component count, model score, shipped features.

Why it fails: activity is not impact.

Fix: connect metrics to user behavior, business results, quality, speed, consistency and guardrails.

## Documentation Afterthought

Symptom: docs are written late, incomplete or only for designers.

Why it fails: adoption and correct usage collapse.

Fix: docs are part of the product. Include purpose, usage, examples, code, accessibility, changes and migration.

## No Ownership After Launch

Symptom: team ships and moves on.

Why it fails: products, AI models and design systems drift.

Fix: assign owners for monitoring, feedback, maintenance, support, deprecation and future changes.
