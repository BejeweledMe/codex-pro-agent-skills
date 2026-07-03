# Test Pyramid And Feedback Loops

Use when: deciding the balance between unit, integration and E2E tests, or diagnosing a slow/flaky suite.

## Core Ideas

- The test pyramid is a cost model, not a religious ratio.
- Lower-level checks are valuable because they are usually faster, more reliable and easier to debug.
- Higher-level checks are valuable when they provide fidelity that lower layers cannot provide.
- The more high-level a check is, the fewer of those checks you should have and the more deliberate each one should be.

## Size And Scope

Keep two dimensions separate:

- Size: resources required to run the test, such as process, machine, network, database, browser, time and external systems.
- Scope: amount of behavior or code validated, such as one function, a module, service boundary, workflow or full system.

Small size and narrow scope often go together, but not always. A broad API behavior can sometimes be tested in a small hermetic environment. A single method can become medium-sized if it needs filesystem, browser or local server infrastructure.

## Feedback Loop Properties

A useful feedback loop is:

- Fast: developers can run it before or during a change.
- Reliable: failures usually mean real signal, not flaky infrastructure.
- Failure-isolating: the failure narrows where to look.
- Actionable: logs, assertion messages or traces explain what changed.
- Trusted: the team fixes failures quickly and does not normalize red builds.

E2E tests often simulate users better, but they usually lose on speed, reliability and localization. Keep them for cases where user-level fidelity is the actual risk.

## Practical Test Pyramid

Use this as a starting shape, not a universal law:

- Many unit and small tests for business logic, edge cases and module contracts.
- Some integration and contract tests for boundaries between components.
- Fewer system/E2E tests for critical flows that require real wiring, UI, browser, device, external system or workflow fidelity.
- Exploratory/manual testing for issues automation misses, especially usability, surprising paths and human judgment.
- Monitoring and production feedback after release.

Google Testing Blog gives 70/20/10 as a rough starting point for unit/integration/E2E. Another common heuristic is 80/15/5 by narrow, medium and large scope. Treat both as heuristics. The correct mix depends on architecture, risk, team maturity and release process.

## Anti-Patterns

- Inverted pyramid: relying mostly on E2E tests.
- Hourglass: many unit tests and many E2E tests, but weak integration/contract coverage.
- Duplicating every lower-level edge case in E2E tests.
- Treating UI automation as the only acceptance test path.
- Running unreliable broad tests in PR checks and training engineers to rerun blindly.

## Checklist

- Can this failure be caught with a smaller, faster test?
- Does this high-level test cover a real fidelity gap?
- Does the suite include enough integration/contract coverage to avoid an hourglass?
- Are E2E tests limited to critical user journeys and system wiring risks?
- Does every flaky test have owner, classification and remediation path?

## Sources

- [Google Testing Blog, Just Say No to More End-to-End Tests](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html)
- [Martin Fowler, The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)

## Cross-Links

- [03-unit-tests.md](03-unit-tests.md)
- [05-integration-and-larger-tests.md](05-integration-and-larger-tests.md)
