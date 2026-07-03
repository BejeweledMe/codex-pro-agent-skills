# Unit Tests

Use when: testing business logic, module behavior, public APIs, edge cases and fast presubmit checks.

## Core Ideas

- Unit tests are valuable because they are fast, deterministic, focused and cheap to run frequently.
- The main quality bar is maintainability. A test should fail when behavior breaks, not when harmless implementation details change.
- Good unit tests are examples of how the unit is meant to be used.
- Tests should optimize for reader understanding. Clever tests are usually expensive tests.

## Test Behavior Through Public APIs

Prefer testing the unit the way its users use it:

- Call the public API of the unit.
- Set up state through supported entry points.
- Assert externally observable state or output.
- Avoid private methods, internal storage formats and implementation-only helper calls.

This makes tests less brittle. If a refactor changes internals but behavior stays the same, tests should usually stay green.

## State Over Interactions

Prefer state/output assertions over verifying exact internal call sequences.

Use state testing when:

- The final state is observable.
- The output is the product contract.
- Multiple internal implementations would be valid.

Use interaction testing only when:

- The interaction itself is the externally important side effect.
- A real implementation or fake is unavailable.
- You are checking a state-changing dependency call that cannot be observed otherwise.

## Write Clear Tests

A maintainable test should be:

- Complete: it contains all information needed to understand the behavior.
- Concise: it omits irrelevant setup and noise.
- Focused: it tests one meaningful behavior.
- Named by behavior, not by implementation method.
- Diagnostic: failure message tells what went wrong.

Use the common Given/When/Then shape when it improves readability:

```text
Given a user with an expired subscription
When they request a premium action
Then the action is denied and the upgrade prompt is shown
```

## DAMP Over Excessive DRY

Production code often benefits from DRY. Test code often benefits from DAMP: descriptive and meaningful phrases.

Prefer:

- Small local duplication if it makes each test readable.
- Test builders for irrelevant defaults.
- Helpers that express domain meaning.

Avoid:

- Shared setup that hides the actual scenario.
- Logic-heavy test helpers.
- Parameterized tests that make failures hard to understand.

## Coverage

Coverage is a diagnostic, not a goal. It can reveal untested areas, but it cannot prove that meaningful behavior was asserted. A high-coverage suite can still miss important edge cases or assert implementation details.

## Anti-Patterns

- Testing private methods directly.
- Naming tests after methods instead of behavior.
- Verifying every collaborator call in ordinary logic tests.
- Building large hidden fixtures that no reader can inspect quickly.
- Testing implementation structure so refactors rewrite the suite.
- Chasing 100% coverage without evaluating assertion quality.

## Checklist

- Does the test verify a behavior users or callers care about?
- Does it use the unit through its public API?
- Would a harmless refactor keep the test green?
- Is state/output asserted instead of internal interaction where possible?
- Is setup minimal but understandable?
- Can a new engineer understand the test without reading a hidden fixture maze?
- Does the failure message point to the broken behavior?

## Sources

- [Martin Fowler, The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)

## Cross-Links

- [04-test-doubles.md](04-test-doubles.md)
- [02-test-pyramid-and-feedback-loops.md](02-test-pyramid-and-feedback-loops.md)
