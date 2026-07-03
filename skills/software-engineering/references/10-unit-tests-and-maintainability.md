# Unit Tests And Maintainability

Use when: writing unit tests, reviewing test quality, reducing brittle tests, or
choosing between behavior-oriented and implementation-oriented assertions.

## Core Ideas

- Maintainable tests should stay valid when behavior is unchanged, even if implementation changes.
- Tests should usually interact through public APIs or stable observable behavior.
- State testing is generally more robust than interaction testing because it avoids over-specifying internal calls.
- Clear tests are complete and concise: they show setup, action, and expected behavior without hiding important logic.
- Test names and structure should communicate behavior, not method internals.
- Tests can be DAMP rather than maximally DRY: clarity and local readability often matter more than removing every repetition.
- Shared setup and helpers are useful only when they make tests easier to understand.

## Practices

- Name tests after the behavior and condition being verified.
- Test public behavior instead of private implementation details.
- Prefer assertions on final state or output when that captures the contract.
- Keep test logic simple; avoid loops, conditionals, and clever computation in assertions.
- Use clear failure messages and assertion libraries that explain expected versus actual values.
- Keep shared fixtures minimal and obvious.
- Duplicate small amounts of test data when it makes each case self-contained.
- Define test infrastructure only when it reduces repeated incidental complexity.

## Anti-Patterns

- Tests that fail after harmless refactoring.
- Tests that mirror implementation methods one-for-one instead of user-visible behavior.
- Overly DRY test helpers that hide what matters.
- Complex logic inside tests that can contain bugs of its own.
- Shared setup where each test depends on invisible state mutations.
- Assertion messages that force maintainers to debug the test before debugging the code.

## Agent Checklist

- Would this test still pass after an implementation-only refactor?
- Is the test written against public behavior?
- Does the name explain the behavior under test?
- Can a reader understand setup, action, and expected result locally?
- Is repeated data improving clarity or hiding behind a helper?
- Does the failure output identify the problem quickly?

## Cross-Links

- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
- [11-test-doubles-fakes-and-mocks.md](11-test-doubles-fakes-and-mocks.md)
- [07-code-review-and-change-history.md](07-code-review-and-change-history.md)
