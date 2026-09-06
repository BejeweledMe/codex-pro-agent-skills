# Python Backend References

Choose by the boundary under investigation.

| Reference | Use when |
| --- | --- |
| [Framework and validation boundaries](django-fastapi-boundaries.md) | Input changes meaning, framework resources leak, overrides escape a test, or transactional work crosses a request or sync/async boundary. |
| [Async lifetime and capacity](asyncio-lifecycle-and-capacity.md) | Tasks outlive their owner, cancellation hangs, queues grow, or shutdown loses work. |
| [Persistence and durable effects](sqlalchemy-and-durable-side-effects.md) | Sessions fail intermittently, commits and jobs race, retries duplicate effects, or application migrations need review. |
| [Packaging and tests](packaging-and-tests.md) | Fixtures hide lifecycle defects, fake tests disagree with production, or source imports hide packaging errors. |
| [Domain services and Unit of Work](domain-services-and-uow.md) | Business rules, transaction ownership, persistence coupling, or query shape justify an application boundary. |

## Source Basis

The guidance uses these original works and documentation sections:

- Python documentation, **Coroutines and Tasks** and **Queues**: structured ownership, cancellation targets, timeout behavior, and unfinished-work accounting.
- Captured Django 6.1-era documentation, **Asynchronous support**, **Database transactions**, **Security in Django**, and **Tasks**: sync/async adaptation, request transaction scope, commit callbacks, and framework control limits; Tasks is new in 6.0.
- Pydantic documentation, **Models** and **Strict Mode**: output-model guarantees, coercion, extra fields, and validation bypass.
- A bounded snapshot of the official FastAPI repository documentation (reported version 0.141.1), **Lifespan Events**, **Testing Dependencies with Overrides**, and **Async Tests**: application resources and bounded test lifecycle guidance; this does not verify release behavior or live-site parity.
- SQLAlchemy documentation, **Session Basics** and **Transactions and Connection Management**: state, transaction ownership, SAVEPOINTs, and joining external test transactions.
- Alembic **Cookbook**, Celery **Tasks**, Python Packaging User Guide **Writing your pyproject.toml** and **Packaging Python Projects**, and pytest **Good Integration Practices**: their respective migration, worker, artifact, and test boundaries.
- *Architecture Patterns with Python* / *Cosmic Python*: domain modeling, Repository, Service Layer, Unit of Work, aggregates, events, CQRS, dependency injection, and incremental evolution.
- *Designing Data-Intensive Applications*, second edition, transaction/message effects and CDC/outbox/reprocessing discussions: durable intent and the limits of local atomicity.

Cross-library workflows here combine these mechanisms; they are not a claim that the sources supply a complete integrated application. Version and integration limits sit beside the affected guidance. Verify exact APIs against the project's installed versions and relevant official documentation when implementing version-sensitive behavior.
