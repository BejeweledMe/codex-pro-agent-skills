# Boundaries And Contracts

## Choose Boundaries Deliberately

A boundary creates an interface, ownership obligation, failure mode, deployment concern, and compatibility cost. Split a component only when the boundary provides material value such as:

- Different scaling or latency profile.
- Independent lifecycle or release cadence.
- Strong ownership or security boundary.
- Isolation of failures, resources, or regulated data.
- A stable domain capability used by multiple consumers.

Keep capabilities together when they share transactions, change together, are operated by the same small team, or would otherwise communicate heavily. A modular monolith can preserve logical boundaries without creating network and operational costs.

## Contract Checklist

For each API or event define:

- Consumer and provider owners.
- Request or event schema, validation, defaults, and size limits.
- Authentication, authorization, tenant context, and audit needs.
- Success, partial success, and error semantics.
- Idempotency key or deduplication identity for retried writes.
- Ordering and concurrency expectations.
- Deadline, timeout, retryability, and rate limits.
- Pagination, filtering, consistency, and freshness behavior.
- Versioning, compatibility window, deprecation, and migration path.
- Observability fields such as correlation and trace identifiers.

Treat documented and observable behavior as potential contract surface. Consumers may depend on ordering, error codes, timing, defaults, or field presence even when these were not intended guarantees.

## Synchronous Or Asynchronous

Prefer synchronous interaction when the caller needs an immediate answer, the dependency can meet the end-to-end deadline, and failure semantics are simple enough to expose directly.

Prefer asynchronous interaction when work can complete later, bursts need buffering, producer and consumer lifecycles should be decoupled, fan-out or replay matters, or the operation may exceed a request deadline.

Asynchrony does not remove coupling. It moves coupling into schema evolution, delivery semantics, lag, ordering, retention, replay, and operational ownership.

## Compatibility And Evolution

- Favor additive changes before removals.
- Make consumers tolerant of unknown fields and providers explicit about required fields.
- Do not reuse fields with changed meaning.
- Version only when compatibility cannot be preserved; versions create a migration obligation.
- Discover consumers through code search, access logs, schema registry, dependency data, and owner records.
- Prevent new use of deprecated contracts once a replacement exists.
- Track adoption, deadline, fallback, and final cleanup.

## Boundary Review

- Can the owning team operate this component independently?
- Is there a clear source of truth and transaction owner?
- Does the boundary reduce coupling or merely convert function calls into remote calls?
- How many network hops are on the critical path and what deadline remains at each hop?
- What happens when the provider is slow, unavailable, or returns a partial result?
- Can the contract evolve without coordinating every consumer at once?
- Is the operational cost proportional to the value of independence?
