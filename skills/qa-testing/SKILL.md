---
name: qa-testing
description: Use when designing, reviewing, validating, debugging, or improving classic software QA strategy and automated test suites. Trigger for autotests, unit tests, integration tests, contract tests, end-to-end tests, test pyramid decisions, flaky tests, test doubles, mocks, fakes, stubs, test coverage, test maintainability, CI/CD quality gates, release validation, exploratory testing, and production feedback for non-LLM software systems.
---

# QA Testing

Use this skill to design or review classic software QA and automated testing systems. Treat testing as an engineered feedback system: map risks, choose the smallest reliable checks with enough fidelity, place them in the right development/release stage, and keep failures actionable.

## Core Rule

Do not start from framework, coverage target, or E2E suite size. First clarify user-visible behavior, risk, price of failure, deterministic contracts, required fidelity, CI/CD stage, ownership, and the action expected when a check fails.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- Always start with `references/01-testing-strategy.md` for broad QA/test strategy.
- For test pyramid, test size/scope, E2E cost, and feedback-loop placement, read `references/02-test-pyramid-and-feedback-loops.md`.
- For unit tests, behavior testing, public APIs, state over interactions, DAMP, coverage caveats, and maintainability, read `references/03-unit-tests.md`.
- For test doubles, mocks, stubs, fakes, contract tests, and state-vs-interaction decisions, read `references/04-test-doubles.md`.
- For integration, contract, system, E2E, configuration, load, exploratory, and larger tests, read `references/05-integration-and-larger-tests.md`.
- For presubmit, post-submit, nightly, release-candidate, staging, canary, feature flags, rollback, and production quality gates, read `references/06-ci-cd-quality-gates.md`.
- For reusable templates and checklists, read `references/07-checklists-and-templates.md`.

## Workflow

1. Classify the request:
   - New QA strategy: read `01`, then `02`, `06`, and topic-specific files.
   - Existing test-suite review: read `01`, `02`, `03`, `04`, `05`, and `06`.
   - Unit test implementation/review: read `03`, and `04` if doubles are involved.
   - Integration/E2E strategy: read `05`, then `02` and `06`.
   - CI/CD or release gate design: read `06`, then `02` and `05`.
   - Flaky or slow suite diagnosis: read `02`, `05`, and `06`.
2. Identify blocking unknowns. Ask only when missing context changes the decision; otherwise state assumptions.
3. Map risks to quality layers: static checks, unit tests, contracts, integration, larger tests, exploratory testing, monitoring, and production feedback.
4. Prefer the smallest reliable check with enough fidelity. Escalate to broader tests only for risks lower layers cannot catch.
5. Make recommendations operational: owner, CI stage, data/setup, assertion, failure action, and maintenance loop.
6. Mark any idea not grounded in the references as `external extension`.

## Output For New QA Strategy

Include:

- Behavior and risk statement.
- Goals and antigoals.
- Price of failure and priority risks.
- Test pyramid proposal.
- Deterministic checks: static, unit, contract, integration, and larger tests.
- Test data and environment plan.
- CI/CD placement: local, presubmit, post-submit, nightly, release candidate, canary, production.
- Release thresholds, rollback criteria, monitoring, and feedback loop.
- Ownership, maintenance plan, risks, and open questions.

## Output For Review

Lead with risks and missing decisions:

- Critical quality risks.
- Missing or weak behavior/risk framing.
- Test pyramid imbalance or E2E overreach.
- Brittle unit tests, over-mocking, stale fakes, or weak contract coverage.
- Integration, configuration, load, environment, or ownership gaps.
- CI/CD stage mismatches, flaky blocking checks, or unclear failure actions.
- Concrete fixes and validation steps.

## Quality Bar

- Do not call a test strategy complete without risk mapping, layered checks, CI placement, ownership, and production feedback.
- Do not call unit tests maintainable if they test private implementation details or brittle interactions instead of behavior and state.
- Do not rely on E2E tests when smaller tests can catch the same risk faster and more clearly.
- Do not keep flaky tests in blocking paths without owner, classification, and remediation plan.
- Do not treat coverage percentage as proof that meaningful behavior is tested.
- Do not attribute detailed practices to external testing publications unless the user provides them; the bundled notes use only public page themes.
