# Integration And Larger Tests

Use when: unit tests cannot cover service boundaries, deployment configuration, real dependencies, load behavior, browser/device behavior, workflow fidelity, or emergent system behavior.

## Core Ideas

- Larger tests exist to address fidelity gaps.
- Fidelity is the degree to which a test reflects the real behavior of the system under test.
- Higher fidelity usually costs more in time, infrastructure, flakiness, debugging effort and ownership complexity.
- The right larger test is the smallest test with enough fidelity to cover a specific risk.

## Common Gaps Unit Tests Miss

- Dependency behavior that test doubles do not accurately represent.
- Configuration and deployment wiring.
- Database, queue, cache and network integration.
- Load, stress, timing and resource exhaustion.
- Browser, device, OS or GUI behavior.
- Long-running workflows and multi-step state transitions.
- Unanticipated inputs, side effects and emergent behavior.
- Compatibility between versions, services and configs.

## Larger Test Anatomy

Define each larger test by:

- SUT: what system or slice is under test.
- Data: generated, fixture, copied, anonymized, sampled or production-like.
- Action: user flow, API call, event, scheduled job or load profile.
- Verification: assertions, state checks, metrics, diffs, manual review or graders.
- Environment: local hermetic stack, sandbox, staging, canary or production prober.
- Owner: who maintains the test and responds to failures.

## Types

- Integration test: verifies that a small set of components works together.
- Contract test: verifies provider/consumer expectations at a boundary.
- System/E2E test: verifies a critical flow through a realistic system.
- Deployment configuration test: starts the service with release config and checks health.
- Load/stress/performance test: verifies behavior under volume or resource pressure.
- A/B diff regression test: compares old and new behavior over sampled traffic or metrics.
- Exploratory testing: humans intentionally search for surprising failures.
- Production prober/monitor: checks live behavior and alerts on actionable failures.

## Practices

- Keep integration tests narrow: one boundary or workflow concern at a time.
- Make large tests hermetic when possible. If not possible, isolate them from blocking presubmit.
- Version important configuration and test it with the code that consumes it.
- Use realistic data, but document privacy, sampling and bias limitations.
- If a large test finds a bug, add a smaller regression test when possible.
- Keep manual exploratory findings from disappearing: convert important discoveries into automated regression tests.

## Anti-Patterns

- A broad E2E suite as compensation for missing unit/integration tests.
- Large tests without owners.
- Shared state between tests that creates correlated failures.
- Manual regression plans that grow linearly with every feature.
- Ignoring configuration because "code tests passed".
- Treating production-only monitoring as a substitute for pre-release validation.

## Checklist

- What fidelity gap does this test cover?
- Which lower-level tests already cover the edge cases?
- Can the test be split into smaller boundary checks?
- Is the environment stable and reproducible enough for the intended CI stage?
- Is failure triage clear from logs, traces, diffs or metrics?
- Is the data realistic enough for the risk?
- Who owns the test, and what happens when it fails?

## Sources

- [Martin Fowler, The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
- [Google Testing Blog, Just Say No to More End-to-End Tests](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html)

## Cross-Links

- [02-test-pyramid-and-feedback-loops.md](02-test-pyramid-and-feedback-loops.md)
- [04-test-doubles.md](04-test-doubles.md)
- [06-ci-cd-quality-gates.md](06-ci-cd-quality-gates.md)
