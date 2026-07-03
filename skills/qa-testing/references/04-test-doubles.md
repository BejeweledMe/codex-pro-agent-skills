# Test Doubles

Use when: a dependency is slow, expensive, nondeterministic, hard to create, unavailable, unsafe to call, or difficult to force into rare error states.

## Core Ideas

- A test double replaces a real dependency in a test.
- Test doubles help create fast and reliable tests, but they reduce fidelity if they do not behave like the real dependency.
- Prefer realism over isolation when the real implementation is fast, deterministic and easy to construct.
- If a real implementation is unsuitable, a well-maintained fake is usually better than ad hoc stubbing or broad mocking.

## Decision Guide

1. Use the real implementation if it is fast, deterministic and simple.
2. Use a fake if the real dependency is too heavy but the API has stable behavior that can be represented locally.
3. Use stubbing for narrow cases where a specific response or rare error must be simulated.
4. Use interaction testing only when the interaction itself is the important state-changing effect and state cannot be observed directly.

## Fakes

A fake is a lightweight implementation of an API that behaves like the real implementation for test purposes, such as an in-memory database or fake filesystem.

Good fakes:

- Match the public API contract.
- Are maintained by or with the API owner.
- Have contract tests that run against both real and fake implementations where feasible.
- Cover important error and edge cases without pretending to be production.

## Stubs And Mocks

Stubbing defines a dependency response inline in a test. It is useful for targeted conditions, but overuse creates tests that merely confirm the test author's imagined dependency behavior.

Mocking frameworks reduce boilerplate, but they make it easy to create brittle tests:

- Tests can duplicate implementation details.
- Refactors can break tests without breaking behavior.
- Mock behavior can diverge from the real API contract.
- Interaction assertions can become change detectors.

## Interaction Testing

Interaction testing is justified when:

- A call changes state outside the system under test.
- No observable final state is available.
- The dependency is too slow or unsafe and no fake exists.

Keep interaction tests narrow:

- Verify only necessary state-changing interactions.
- Avoid exact ordering unless ordering is part of the contract.
- Avoid verifying non-state-changing reads.
- Do not overspecify irrelevant parameters.

## Anti-Patterns

- Mocking value objects or simple deterministic dependencies.
- Stubbing many functions to create a fragile imagined world.
- Using stale fakes with no contract coverage.
- Verifying every internal collaborator call.
- Using production services in tests that should be safe, hermetic and repeatable.

## Checklist

- Can the real implementation be used safely?
- If using a fake, who maintains it and how is fidelity checked?
- If using stubs, is the stub limited to one clear behavior?
- If verifying interactions, is the interaction state-changing and product-relevant?
- Does the double make the test faster without hiding the risk being tested?

## Sources

- [Martin Fowler, The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)

## Cross-Links

- [03-unit-tests.md](03-unit-tests.md)
- [05-integration-and-larger-tests.md](05-integration-and-larger-tests.md)
