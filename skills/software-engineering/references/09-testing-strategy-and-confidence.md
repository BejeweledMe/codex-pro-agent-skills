# Testing Strategy And Confidence

Use when: designing test strategy, reviewing test coverage, debugging flaky tests,
or deciding which level of test is appropriate for a risk.

## Core Ideas

- Tests are not only bug detectors; they are infrastructure for safe change.
- A useful test suite balances size, scope, speed, determinism, fidelity, and maintainability.
- Small tests give fast, focused feedback. Medium and large tests catch integration and system behavior that small tests cannot.
- Test size and test scope are separate ideas: a small test can cover a narrow behavior, while larger tests involve more processes, systems, or environments.
- Coverage is a weak proxy. It can show untested areas, but it does not prove meaningful behavior is verified.
- Flaky tests are expensive because they train engineers to distrust CI and waste attention.
- Automated testing has limits; some risks still require exploratory, usability, production, or disaster-recovery validation.
- Improving testing is a cultural migration, not only a tooling change; education, repeated nudges, and workflow integration matter.

## Practices

- Test the behaviors you care about enough to preserve.
- Prefer the smallest test that gives the needed signal.
- Keep fast, deterministic tests near the developer workflow.
- Run slower, broader, less deterministic tests in later CI stages when they provide distinct value.
- Treat flakiness as a product defect in the test suite.
- Include failure cases, not only happy paths.
- Use code coverage as a diagnostic, not as a target.
- Review whether tests enable future refactoring instead of locking in implementation details.

## Enforceable Execution Budgets

When test labels determine workflow placement, define what the runner can observe
and enforce. Size describes execution resources; scope describes behavior covered.
A broad behavior test can still be small when its dependencies run in memory.

Use the project's existing runner and CI configuration to specify:

| Budget dimension | Local contract | Response to a violation |
| --- | --- | --- |
| Processes, threads, and machines | Allowed execution boundary for each size | Remove an accidental dependency or reclassify the test and its CI placement |
| Network and filesystem | Permitted endpoints, filesystem access, and fixture isolation | Report the dependency; isolate it or use a controlled integration stage |
| Time and waiting | Timeout and restrictions on sleeps or uncontrolled clocks | Diagnose blocking, scheduling, or time dependence before increasing the limit |
| Resource use | Relevant memory/CPU limits and cleanup expectations | Identify leaks or excess work; resize only when the risk requires it |

Keep local numeric budgets with the suite owner and runner configuration. Enforce
them mechanically where supported; record unsupported enforcement instead of
claiming a label guarantees isolation. Do not build a new runner merely to adopt
this classification. A legitimately larger test keeps its distinct evidence in
the appropriate stage.

Verify the contract through observed execution and actionable violation reports.
If a test exceeds its class, changing only its label or timeout is insufficient
without understanding the dependency and checking that its new placement still
covers the risk.

## Flake Containment And Restoration

Treat inconsistent outcomes for the same code and relevant inputs as a diagnostic
signal. Preserve the original failure, attempt count, environment, and test order;
a passing rerun does not establish that the first failure was harmless.

Distinguish shared state/order, clock or scheduling, network, fixtures, and
environment causes from a product race. The suite owner coordinates diagnosis;
the responsible implementation or environment owner repairs the cause. A product
race can produce intermittent results; do not classify every flake as a test defect.

Retries may temporarily contain disruption, with a bounded retry policy and visible
original results. Quarantine requires an owner, deadline, explicit lost coverage,
and a restoration criterion. Keep non-gating execution and reporting where safe
and useful; disabling execution must leave the lost signal visible. If the
quarantined test was the only evidence for a
critical behavior, supply alternate evidence or constrain the affected release.

Restore the test after the cause is repaired and relevant repeated runs support
stable behavior. Judge closure over a suitable observation window using flake
incidence, reruns, and investigation cost. Even a small per-test flake rate can
consume substantial attention across frequent large suites; correlated failures
must not be modeled as independent events.

Source basis: *Software Engineering at Google*, Testing Overview. Its resource
limits and historical flake rates are examples, not portable budgets or SLOs.

## Anti-Patterns

- Measuring quality by coverage percentage alone.
- Building a large slow suite that developers avoid running.
- Letting flaky tests remain red or ignored.
- Testing implementation structure so ordinary refactors require test rewrites.
- Using one type of test for every risk.
- Treating automated tests as a complete substitute for judgment.

## Agent Checklist

- What risk does this test address?
- Is this the smallest reliable test that gives the needed confidence?
- Is the test deterministic and fast enough for its workflow stage?
- Does the test verify behavior rather than implementation?
- Are important failure modes covered?
- If the suite is flaky, what ownership and fix path exists?

## Cross-Links

- [10-unit-tests-and-maintainability.md](10-unit-tests-and-maintainability.md)
- [11-test-doubles-fakes-and-mocks.md](11-test-doubles-fakes-and-mocks.md)
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
