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
