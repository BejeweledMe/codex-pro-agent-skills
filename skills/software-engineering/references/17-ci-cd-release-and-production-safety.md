# CI CD Release And Production Safety

Use when: designing CI, release processes, deployment safety, feature flags, or
feedback loops that connect code changes to production confidence.

## Core Ideas

- CI decides what tests and checks run, when they run, and how quickly developers receive useful feedback.
- CI becomes more necessary as codebases age and scale because manual integration cannot keep up.
- Presubmit should optimize for fast, reliable feedback; post-submit and release candidate stages can run broader and more expensive checks.
- CI feedback should be accessible, understandable, actionable, and owned. The book's comparison to production alerting is explicitly exploratory; CI restoration remains an engineering responsibility.
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

## Restore A Red Mainline

Fast presubmit is deliberately incomplete. Broader post-submit evidence is useful
only when failures have a response path. Name a project/build restoration owner
or rotation with the authority to coordinate a revert or repair. A small repository
may use its maintainer; a separate role is not mandatory.

On a shared failure, retain the failing revision, test/configuration identity,
original result, failure age, and last known good candidate. Identify likely
changes while restoring the shared signal. Prefer reverting a suspected change
when reversal is safe; if state or compatibility makes reversal unsafe, choose
the smallest controlled repair and record that constraint.

Pause unrelated submissions to the affected broken mainline until trustworthy
feedback is restored. Recovery work may proceed. Do not normalize commits on red
or equate a passing rerun with restoration. Use the flake policy in
[09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
when evidence indicates nondeterminism.

Verify the repair at the new revision with the affected checks and necessary
broader evidence. Track time-to-green, failure recurrence, and unrelated
commits-on-red to improve the response path. SRE takes responsibility for live
incident and reliability decisions when production is affected.

## Shared-CI Responsibility

When infrastructure passes CI but a product breaks, first ask whether that product
behavior was represented in common CI. If it was absent, the product owner supplies
the missing behavior evidence; a private test did not establish a shared signal.
If common CI should have caught the failure, repair the test, selection, or
environment that produced misleading evidence with its owner.

The infrastructure owner still owns compatible change or migration support.
This distinction assigns preventive work; it is not permission to leave users
broken while teams debate blame. Verify that the repaired shared signal catches
the recurrence.

## Preserve The Tested Candidate

A release candidate binds source revision, static configuration, resolved
dependencies, build inputs/toolchain, produced artifact identity, and applicable
test/review evidence. Use existing release records to keep these attributable.
Branch names and mutable tags alone do not establish that identity.

Distinguish promoting the latest fully green revision ("green head") from using
the actual head while accepting bounded red periods ("true head"). State the
project's candidate policy and restoration obligation. Selecting the latest
revision does not inherit evidence from an earlier green one.

Promote the same artifact through stages. Before exposure, compare its identity
and bound inputs with the tested candidate and reject unexplained skew.
Environment-specific configuration and relevant state versions must be explicit;
their differences and applicable checks accompany the promotion record.

A rebuild creates a new build execution and candidate record. Reuse earlier
functional evidence only when output identity and all inputs relevant to that
evidence are verified; the new build still needs its own attributable execution
record. Changed dependencies or static configuration require reassessment of the
affected evidence. Stop promotion on mismatch, recover the known candidate or
qualify the changed one, and verify the identity actually deployed. Artifact
identity preserves evidence continuity; it does not prove safety.

Software engineering owns this candidate/evidence contract.
`$platform-devops-engineering` executes build, storage, promotion, reconciliation,
and infrastructure rollback. Pass candidate/config/state identity, required
evidence, transition constraints, and the known recovery target. SRE owns
reliability acceptance using rollout observations.

For security requirements on this chain, use
[20-secure-development-lifecycle-hooks.md](20-secure-development-lifecycle-hooks.md).

Source basis: *Software Engineering at Google*, Continuous Integration and Continuous
Delivery; *Building Secure and Reliable Systems*, end-to-end change integrity.
Role names, release cadence, and historical Google thresholds are examples.

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
