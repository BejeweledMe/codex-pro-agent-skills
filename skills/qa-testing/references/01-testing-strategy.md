# Testing Strategy

Use when: designing QA for a new feature, reviewing a test suite, or deciding which checks belong in PR, CI, release and production.

## Core Ideas

- Testing is infrastructure for safe change, not a ritual for producing green badges.
- A useful quality system answers four questions: what can break, how expensive is the break, how quickly will we know, and who acts on the signal.
- Test strategy should start from risks, not tools. The right check for a pricing bug, a UI alignment issue, a data migration issue, and a browser compatibility issue will differ.
- Tests gain value only when engineers trust them. Slow, flaky, unclear or ownerless tests erode that trust.

## Quality Portfolio

Think in layers:

- Static checks: lint, type checks, schemas, dependency policy, security scanning.
- Unit tests: narrow behavior, fast feedback, public API contracts.
- Contract and integration tests: boundaries with databases, APIs, queues, tool implementations and external services.
- Larger tests: fidelity gaps such as configuration, load, browser/device behavior and emergent system behavior.
- Human review: exploratory testing, transcript review, SME grading, rubric calibration.
- Production feedback: monitoring, A/B tests, user feedback, bug reports, incident reviews.

No single layer should pretend to cover all risk.

## Practices

- Define the risk before defining the test.
- Prefer the smallest reliable check that gives the required confidence.
- Put fast, deterministic, high-signal checks close to the developer workflow.
- Move slower, broader and less deterministic checks to post-submit, nightly, release candidate or staging stages.
- Keep a separate path for production monitoring and real-user feedback; synthetic tests do not replace production signals.
- Treat test data as product data: realistic, versioned, explainable and refreshed from real failures.
- Track ownership for suites, individual critical tests, test data, fixtures, environments and failure triage.

## Decision Map

- If the behavior is pure logic: start with unit tests.
- If the risk is a boundary between components: use integration or contract tests.
- If the risk is a service contract provided to another team: add provider and consumer contract coverage where possible.
- If the risk is configuration or deployment wiring: test code and config together in CI/CD.
- If the risk requires real system fidelity: use a larger test, but keep scope small.
- If the risk is user-perceived quality, ambiguity or domain judgment: calibrate with human review.
- If the risk appears only under real traffic: use monitoring, canary, A/B and incident-derived regression tests.

## Anti-Patterns

- "Seems to work" as an evaluation strategy.
- Adding E2E tests because lower layers are missing or poorly designed.
- Making all checks block PRs, regardless of speed or flakiness.
- Keeping flaky tests in a blocking path without owner and fix plan.
- Optimizing for coverage percentage without checking whether the tests represent meaningful behavior.

## Checklist

- What user, business, safety or engineering risk is covered?
- What is the price of a false positive, false negative, timeout, wrong tool call or unsafe response?
- Is this the smallest reliable check with enough fidelity?
- Is the failure actionable from logs, trace, assertion message or diff?
- Is there an owner for fixing the test, data, harness and production bug?
- Does the suite include happy path, edge cases, negative cases and regression cases from real failures?
- What production signal will detect cases not represented in the test suite?

## Sources


## Cross-Links

- [02-test-pyramid-and-feedback-loops.md](02-test-pyramid-and-feedback-loops.md)
- [06-ci-cd-quality-gates.md](06-ci-cd-quality-gates.md)
- [07-checklists-and-templates.md](07-checklists-and-templates.md)
