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
