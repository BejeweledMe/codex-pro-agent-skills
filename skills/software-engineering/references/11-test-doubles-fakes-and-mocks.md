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

## Authoritative Fakes And Real-Adapter Evidence

For a shared dependency, prefer a supported fake maintained by the team that owns
the API implementation. That team owns its modeled behavior, supported versions,
known omissions, and updates when the real contract changes. A caller-created
imitation is local test support until its fidelity has evidence.

Run common behavioral cases against the fake and a controlled real implementation.
Choose cases from the promised contract: successful operations, relevant failures,
state transitions, and persistence or transaction outcomes where applicable.
Assert externally meaningful results, not identical internal call sequences.

When the fake passes and the real adapter fails, compare version, configuration,
fixture, and contract assumptions before changing either implementation. Add the
case that exposes drift to the shared evidence, repair the responsible side, and
verify both. Agreement on shared cases only establishes the behaviors exercised.

Keep targeted real-adapter integration checks for behavior the fake cannot prove,
such as serialization, actual commit/rollback, error mapping, or environment wiring.
Use an owned, repeatable integration target with controlled data and configuration.
Record/replay can help when a fake is too expensive, but recordings have versions
and fidelity limits; refreshing them requires an owned environment.

Use
`$api-contract-engineering` for disputed observable OAS/wire compatibility and
`$database-engineering` for engine guarantees. These handoffs do not remove the
implementation team's obligation to maintain its adapter and fake.

Use-case tests with fakes can cover orchestration and preconditions quickly;
domain tests remain useful for intricate or combinatorial rules. Adapter tests
prove the mapping and effect boundary, while a small number of edge-to-edge tests
prove wiring and parsing. Choose by the missing behavior evidence, preserving
the size/scope distinction in
[09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md).

Source basis: *Software Engineering at Google*, Test Doubles; *Architecture
Patterns with Python* (Cosmic Python), testing and adapter hardening. Shared
fake/real cases do not imply a particular consumer-driven contract-testing tool.

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
