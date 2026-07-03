# Agent Checklists For Product Design

Related: [terminology](01-terminology.md), [operating model](02-product-operating-model.md), [discovery](03-discovery-and-opportunity-solution-trees.md), [AI UX](06-ai-ml-product-ux.md), [design systems](09-design-systems-as-product.md), [anti-patterns](13-anti-patterns.md)

## Universal Product Design Checklist

- Who is the user, buyer and affected stakeholder?
- What is the business problem?
- What is the desired product or business outcome?
- What evidence supports the opportunity?
- What alternatives were considered?
- What assumptions are most risky?
- How will value, usability, feasibility and viability be checked?
- What metric changes should happen?
- What guardrails protect users and business?
- What happens if the solution fails?
- Who owns measurement, support and maintenance?

## Discovery Readiness

- Target customer and value proposition are explicit.
- Desired outcome is defined.
- At least several customer stories or equivalent evidence exist.
- Opportunities are not solutions in disguise.
- Support/sales/analytics signals have context.
- Opportunity space has been mapped enough to compare choices.
- Target opportunity is selected.
- Multiple solutions were considered.
- Assumptions are listed and prioritized.

## Interview Planning

- Business problem written in non-UI/non-solution terms.
- Research question explains what must be learned about users.
- Stakeholders were interviewed or assumptions captured.
- Participant criteria match real behavior/context.
- Questions focus on concrete past stories.
- Interview plan avoids pitching preferred solution.
- Notes distinguish observation, quote, interpretation and implication.
- Synthesis will feed opportunities or assumptions, not just a report.

## Validation Plan

- Critical assumptions named.
- Test method fits assumption type.
- Pass/fail threshold defined before test.
- Sample and context are credible.
- Evidence can change decision.
- Guardrail metrics included.
- Unknowns and accepted risks documented.
- Next action after pass/fail is clear.

## AI Feature Readiness

- AI provides unique value over simpler approaches.
- Non-AI baseline considered.
- Data needs and data risks are explicit.
- False positive and false negative costs are understood.
- Precision/recall or quality tradeoff is tied to UX.
- User sees capabilities and limits.
- Confidence/uncertainty UI was tested for comprehension.
- User can dismiss, correct, undo or override.
- Fallback exists for low confidence, timeout, unsafe or missing output.
- Feedback loop and tuning plan exist.
- Model/behavior changes are communicated.

## UI/UX Review

- Primary user task is obvious.
- Screen hierarchy matches task priority.
- Empty/loading/error/partial states exist.
- Long content and mobile constraints do not break layout.
- Accessibility basics are covered.
- Error copy gives a path forward.
- User can recover from mistakes.
- Privacy and permissions are understandable.
- Design system components are used where appropriate.
- Instrumentation captures task success and failure.

## Design System Review

- The need is repeated across teams/products.
- Existing component/pattern alternatives were checked.
- User teams and jobs-to-be-done are clear.
- Design and code artifacts stay aligned.
- Docs include when to use/not use, examples and accessibility.
- Contribution process is clear.
- Release notes and migration plan exist.
- Ownership and maintenance are assigned.
- Adoption is measured in design and code.
- Metrics include quality, speed, consistency or business impact.

## Business Outcome Review

- Business outcome and product outcome are separated.
- Product outcome is within team influence.
- Leading indicators and lagging metrics are defined.
- Guardrails prevent local optimization.
- Metric instrumentation exists.
- Reporting explains decision implications.
- Success, failure and neutral outcomes have next actions.

## Release And Maintenance

- Rollout plan exists.
- Rollback or fallback exists.
- Monitoring covers user, system and business signals.
- Support team knows what changed.
- Docs and release notes are ready.
- Owners are named.
- Future changes and deprecation path are understood.

## Agent Output Standard

When producing product design recommendations, include:

1. `Problem and outcome`.
2. `Evidence and assumptions`.
3. `Options considered`.
4. `Recommended solution`.
5. `Validation plan`.
6. `UX and implementation requirements`.
7. `Metrics and guardrails`.
8. `Risks, fallback and maintenance`.
