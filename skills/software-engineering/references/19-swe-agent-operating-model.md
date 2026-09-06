# SWE Agent Operating Model

Use when: turning this knowledge base into a Codex skill or when an agent needs a
compact operating model for design, implementation, review, validation, migration,
and production-facing work.

This is an applied synthesis for agents, not a claim tied to one source section.

## Core Ideas

- Start from time and scale. A good answer for throwaway code can be a bad answer for long-lived shared systems.
- Treat every change as part of a socio-technical system: code, tests, docs, review, owners, users, dependencies, tools, and production.
- Prefer explicit trade-offs over generic best practices.
- Keep humans focused on judgment by moving repeatable checks into tools.
- Preserve future changeability: small changes, clear interfaces, tests, docs, migration paths, and cleanup.
- Do not universalize Google-specific implementation choices. Extract the underlying principle and adapt it to the local organization.

## Practices

- Before implementation, identify lifetime, users, owners, dependencies, risk, and rollback/migration path.
- Search existing code and docs before inventing new abstractions.
- Write small, reviewable changes with clear descriptions and tests.
- Optimize code for readers and future maintainers.
- Ask whether docs, tests, CI, dependency policy, and release process need to change with the code.
- For APIs and shared behavior, plan compatibility, deprecation, and large-scale migration upfront.
- For production-facing changes, require staged rollout, observability, rollback, and ownership proportional to risk.

## Proportional Process And Architecture

Use existing project context to choose the smallest intervention that addresses
the actual failure or future-change pressure. Routine, reversible work does not
need a new design document, broad test program, or additional abstraction.
Shared long-lived behavior warrants stronger compatibility and migration evidence.

Before adding a pattern, name the pressure and the observable improvement:

| Observed pressure | Candidate intervention | Evidence that it helps |
| --- | --- | --- |
| Business decisions are entangled with I/O | Extract a narrow decision boundary or functional core | Relevant behavior can be exercised without infrastructure; real wiring still works |
| Persistence APIs leak across use cases | Introduce a narrow application-shaped port | A representative change touches fewer unrelated callers; fake and real adapter agree on promised behavior |
| Commit/rollback ownership is unclear | Give the use case an explicit transaction boundary | Real-adapter checks prove success and failure outcomes |
| Query shape or selected integration seams evolve independently | Consider a read model or event boundary for that pressure | The target workflow improves and its freshness, delivery, and recovery obligations are explicit |

Simple CRUD may need none of these patterns. Repository/UoW/events/CQRS/DI is not
a required stack, and a convenient fake does not prove the real adapter correct.
Framework and database implementation detail belongs with the relevant backend
and database owner; cross-system delivery guarantees belong with system/data owners.

For modernization, choose one capability and prove a thin end-to-end path through
real adapters. Cut over in reviewable increments with a recovery path, then remove
the displaced code. If the first target is too coupled, shrink the target before
adding layers. Stop adding abstractions when they increase indirection without
improving the named change, testability, or ownership problem.

Source basis: *Architecture Patterns with Python* (Cosmic Python), conditional
architecture, testing, adapter hardening, and application evolution. Its teaching
examples do not establish current framework APIs or durable messaging guarantees.

## Anti-Patterns

- Producing code without considering future maintenance.
- Hiding uncertainty behind authoritative recommendations.
- Adding process or tools that are not embedded in the developer workflow.
- Using metrics to judge individuals instead of improving the system.
- Treating tests, docs, review, and CI as separate chores rather than one feedback system.
- Suggesting monorepo, mocks, 100% coverage, SemVer, CI/CD, serverless, or any other practice as universal.

## Agent Checklist

- What is the expected lifetime and blast radius?
- What trade-off is being made, and what evidence supports it?
- Who owns the code and the operational consequences?
- How will future maintainers understand the decision?
- What tests give confidence at the right level?
- What happens if this change must be rolled back, migrated, or deprecated?
- Is this recommendation grounded in the bundled references, or is it an external extension that must be labeled?

## Cross-Links

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md)
- [02-decision-making-and-productivity-measurement.md](02-decision-making-and-productivity-measurement.md)
- [07-code-review-and-change-history.md](07-code-review-and-change-history.md)
- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
