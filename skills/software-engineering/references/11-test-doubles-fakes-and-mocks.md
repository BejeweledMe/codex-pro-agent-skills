# Test Doubles Fakes And Mocks

Use when: deciding whether to use a real implementation, fake, stub, mock, or
interaction test in order to keep tests useful and maintainable.

## Core Ideas

- Test doubles are tools for isolation, speed, determinism, or hard-to-construct dependencies, but they carry maintenance risk.
- Real implementations are often preferred when they are fast, deterministic, and easy to construct.
- Fakes can be valuable when they model behavior faithfully and are themselves tested.
- Stubbing can make tests unclear, brittle, and less effective when overused.
- Interaction testing is appropriate for some state-changing interactions, but it easily over-specifies implementation details.
- Seams such as dependency injection should be designed carefully so tests can substitute dependencies without warping production design.
- The more a double diverges from reality, the less confidence the test provides.

## Practices

- First ask whether a real implementation is practical.
- Use fakes for complex dependencies only when fidelity is good enough and maintained.
- Test fakes against the real contract where possible.
- Use stubs for narrow, simple cases where behavior is explicit and local to the test.
- Prefer state verification over verifying call sequences.
- When interaction testing is necessary, verify only meaningful externally relevant interactions.
- Avoid mocks for value objects, simple data structures, or dependencies that should be real.

## Anti-Patterns

- Defaulting to mocks because mocking is easy.
- Stubbing many calls until the test duplicates the implementation.
- Interaction tests that fail after internal refactoring with no behavior change.
- Fakes that are not tested and silently drift from real behavior.
- Designing production APIs mainly to satisfy a mocking framework.
- Overspecified call order and argument expectations that do not represent a real contract.

## Agent Checklist

- Can this test use the real implementation without becoming slow or flaky?
- If using a fake, how is its fidelity maintained?
- Is the test checking behavior or internal choreography?
- Are stubs local, simple, and obvious?
- Would this double hide integration failures that a larger test must cover?
- Does this seam improve design or only serve the test framework?

## Cross-Links

- [10-unit-tests-and-maintainability.md](10-unit-tests-and-maintainability.md)
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md)
- [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md)
