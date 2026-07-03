# CI CD Release And Production Safety

Use when: designing CI, release processes, deployment safety, feature flags, or
feedback loops that connect code changes to production confidence.

## Core Ideas

- CI decides what tests and checks run, when they run, and how quickly developers receive useful feedback.
- CI becomes more necessary as codebases age and scale because manual integration cannot keep up.
- Presubmit should optimize for fast, reliable feedback; post-submit and release candidate stages can run broader and more expensive checks.
- CI feedback is a form of alerting: it must be accessible, understandable, actionable, and owned.
- Continuous delivery is safer when changes are small, isolated, measured, and reversible.
- Feature flags, release trains, staged rollout, and telemetry let teams evaluate changes before full exposure.
- Faster delivery is safer only under discipline: tests, automation, monitoring, rollback, and cultural habits.

## Practices

- Keep presubmit checks fast enough that developers use them continuously.
- Run broader suites post-submit to catch interactions without blocking every local change.
- Make CI logs and failure ownership clear.
- Optimize flaky or expensive tests instead of ignoring them.
- Use feature flags to separate code deployment from user-visible behavior.
- Ship small batches on predictable release trains where appropriate.
- Use staged rollout, canaries, and production telemetry to make release decisions.
- Roll back or roll forward quickly when evidence shows harm.

## Anti-Patterns

- Relying only on presubmit and missing failures that happen after integration.
- CI failures nobody owns.
- Test logs that are too noisy to debug.
- Rare, large releases that combine many unrelated risks.
- Synthetic-only qualification when production diversity matters.
- Feature flags without cleanup or usage monitoring.
- Claiming speed improves safety while skipping the controls that make it true.

## Agent Checklist

- Which checks belong in presubmit, post-submit, release candidate, and production stages?
- Is feedback fast, clear, and actionable?
- Who owns broken builds and flaky tests?
- Can the change be isolated behind a flag?
- What production signals decide rollout, rollback, or cleanup?
- Is release size small enough to diagnose and reverse?

## Cross-Links

- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md)
- [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md)
- [18-managed-compute-and-production-abstractions.md](18-managed-compute-and-production-abstractions.md)
