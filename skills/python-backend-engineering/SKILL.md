---
name: python-backend-engineering
description: "Build, review, and debug Python services and background tasks using Django, FastAPI, asyncio, Pydantic, SQLAlchemy, Alembic, or Celery. Covers validation, transactions, resource lifetime, side effects, and Python packaging/tests; HTTP contract compatibility and database engine design have separate owners."
---

# Python Backend Engineering

Trace the affected request or task from input through business decisions, transaction outcome, external effects, and cleanup. Use the project's existing framework and tooling. Keep simple CRUD direct; introduce services, repositories, a Unit of Work wrapper, aggregates, or events when they solve a concrete correctness or coupling problem.

## Working approach

- Establish the expected result, actual entrypoint, relevant dependency versions, and failure path.
- Separate parsing/coercion from current-state preconditions, business invariants, authorization, and outbound serialization.
- Identify who creates the Session or transaction, commits, rolls back, and releases resources. Helpers must not silently commit part of one atomic use case.
- Locate effects relative to commit. Distinguish after-commit ordering from durable intent, duplicate handling, and recovery after uncertain success.
- For concurrent work, identify task ownership, admission limits, cancellation targets, and shutdown behavior.
- Verify the changed boundary with proportionate evidence: business behavior, framework lifecycle, real adapter/engine behavior, or installed artifact. A routine fix needs only the relevant checks.

## References

Read only what the task needs.

| Concern | Reference |
| --- | --- |
| Coercion, request scope, Django sync/async, FastAPI resources or overrides | [Framework and validation boundaries](references/django-fastapi-boundaries.md) |
| Task failures, timeout targets, queues, overload or shutdown | [Async lifetime and capacity](references/asyncio-lifecycle-and-capacity.md) |
| Session state, SAVEPOINTs, commit/enqueue races, workers or migrations | [Persistence and durable effects](references/sqlalchemy-and-durable-side-effects.md) |
| Fixture isolation, fake/real disagreement or package imports | [Packaging and tests](references/packaging-and-tests.md) |
| Domain/service separation, UoW, aggregates, retry, events or CQRS | [Domain services and Unit of Work](references/domain-services-and-uow.md) |
| Coverage and source basis | [Reference index](references/00_README.md) |

## Ownership

Keep Python implementation here when another skill supplies the adjacent decision. Named handoffs are optional and do not require another skill's files.

- `api-contract-engineering` owns HTTP/OAS, media, errors, and consumer compatibility. Pass operation identity, versions/consumers, and the runtime mismatch; implement parsing, serialization, and error adaptation here.
- `database-engineering` owns constraints, isolation, locks, plans, DDL, and restore. Pass the invariant, transaction timeline, relevant SQL, and engine/driver versions; retain Session ownership and application recovery here.
- `system-design` owns topology, authority, and cross-system promises. Pass commit/effect boundaries, operation identity, duplicates, and recovery needs. `data-engineering` owns maintained pipeline publication, event time, replay, and backfills; ordinary application jobs stay here.
- `application-security-engineering` designs controls and `security-review` assesses independent assurance. Python enforces selected controls at the actual handler, query, and effect boundary.
- `qa-testing` and `software-engineering` own general test strategy and change lifecycle. `platform-devops-engineering` owns deployment infrastructure; `sre-reliability-engineering` owns operational reliability acceptance. Supply the relevant application evidence.

Report the implemented behavior or finding, the boundary responsible, verification, and material recovery or version limits. For reviews, tie each finding to a concrete path and consequence.
