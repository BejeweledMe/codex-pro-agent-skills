# Larger Tests And System Behavior

Use when: validating interactions across components, production-like behavior,
configuration, load, rollouts, disaster recovery, or user-visible system behavior.

## Core Ideas

- Larger tests catch gaps that unit tests cannot: configuration, real dependencies, load, emergent behavior, and environment assumptions.
- Higher fidelity increases confidence but also cost, speed, flakiness, and ownership burden.
- The best larger test is often the smallest possible test that crosses the relevant boundary.
- System under test boundaries must be chosen deliberately; too large becomes slow and hard to debug, too small misses the risk.
- Test data and environment realism matter because production failures often come from combinations not present in unit tests.
- Larger tests need owners, maintenance, understandable failures, and workflow placement.
- Production-like validation includes probers, canary analysis, disaster recovery drills, and carefully bounded experiments.

## Practices

- Identify which unit-test gap the larger test addresses before adding it.
- Reduce the SUT to the smallest boundary that still exposes the risk.
- Prefer hermetic or controlled dependencies when possible; use record/replay or test doubles only with known fidelity limits.
- Test deployment configuration, not only application code.
- Include load, stress, performance, and failure behavior when those are product risks.
- Make failures actionable: logs, traces, clear assertions, and owned dashboards.
- Run expensive or less deterministic tests where they fit CI/CD without blocking routine development unnecessarily.

## Anti-Patterns

- Adding broad end-to-end tests because confidence feels low but no specific risk is named.
- Relying on production-only discovery for configuration and integration bugs.
- Building large tests that fail often but nobody owns.
- Making tests so realistic that they are too slow or expensive to run.
- Ignoring test data quality and assuming synthetic fixtures represent users.
- Treating canary or probing as a replacement for earlier tests instead of a later signal.

## Agent Checklist

- What behavior cannot be validated by unit tests?
- What is the smallest SUT that exposes the risk?
- How realistic must dependencies, data, and environment be?
- Who owns failures and flakiness?
- Where should this test run: presubmit, post-submit, release candidate, canary, or production probe?
- Does the test produce enough evidence for a release or rollback decision?

## Cross-Links

- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
- [11-test-doubles-fakes-and-mocks.md](11-test-doubles-fakes-and-mocks.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
- [18-managed-compute-and-production-abstractions.md](18-managed-compute-and-production-abstractions.md)
