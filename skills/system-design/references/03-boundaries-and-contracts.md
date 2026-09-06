# Boundaries And Contracts

## Choose Boundaries Deliberately

A boundary creates an interface, ownership obligation, failure mode, deployment concern, and compatibility cost. Split a component only when the boundary provides material value such as:

- Different scaling or latency profile.
- Independent lifecycle or release cadence.
- Strong ownership or security boundary.
- Isolation of failures, resources, or regulated data.
- A stable domain capability used by multiple consumers.

Keep capabilities together when they share transactions, change together, are operated by the same small team, or would otherwise communicate heavily. A modular monolith can preserve logical boundaries without creating network and operational costs.

When splitting a transaction-owning component, identify which invariant would
cross the new boundary. Compare keeping that decision together with distributed
commit or an explicit asynchronous workflow. Moving an in-process call or event
onto a network introduces partial failure, durable handoff, and recovery
obligations; the interface shape alone does not preserve the original guarantee.
An in-process event bus can separate responsibilities without providing durable
delivery or independent execution.

Keep source modules, deployment units, runtime workers, and transaction boundaries
distinct. A worker pool can isolate CPU work while retaining shared process or
dependency failure; its queue, transfer cost, cancellation, and shutdown still
need an owner. Infrastructure boundaries should reflect co-change, blast radius,
ownership, and recovery needs. Separate durable data from replaceable compute
when that reduces transition risk. Synchronized releases are evidence of
remaining coupling, not proof that every boundary is invalid.

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

## Guarantees Across Boundaries

Trace the critical operation from accepted intent to its final observable effect.
For the affected boundaries, identify:

- The authoritative command and stable logical operation identity, distinct from a trace or individual attempt ID.
- What each acknowledgment proves: receipt, durable intent, local commit, publication, or completion at the destination.
- Which changes share one atomic boundary and which can remain pending, fail independently, or require compensation.
- How dependent observations cross channels. Receiving an event does not prove that a separately read replica or object store already exposes the referenced state.
- Which participant can establish the outcome after a lost response, and how late completion, duplicate attempts, and reconciliation are represented.
- The order, freshness, retention, deletion, and recovery obligations passed downstream.

For example, accepting an order, reserving inventory, charging a provider, and
updating a search view are distinct outcomes unless a mechanism actually binds
them. Define visible intermediate states and the point at which the caller may
rely on each result. An asynchronous chain with an atomic root and deduplicated
downstream work can preserve a particular business invariant only with the
required ordering, processing, and recovery assumptions. It does not establish
atomic visibility or strict serializability across the chain.

Choose coordination or compensation from the invariant and consequence. Identify
all conflicting claims and how the design prevents their incompatible acceptance.
Keeping the conflict decision in one transactional scope or ordered partition is
often the simplest solution. Compensation is suitable only where the domain
accepts the intermediate outcome and correction cost; it cannot undo every
external consequence.

Use [distributed-guarantees-and-recovery.md](distributed-guarantees-and-recovery.md)
when these guarantees depend on retries, authority changes, or replay.

HTTP/OpenAPI artifact identity, serialization, status/error representation, and
HTTP consumer compatibility belong to `$api-contract-engineering`. Pass the
operation, invariant, participating versions and consumers, precondition/retry
obligations, and observed mismatch. Backend owners implement the lifecycle;
system design retains the cross-service promise.

## Synchronous Or Asynchronous

Prefer synchronous interaction when the caller needs an immediate answer, the dependency can meet the end-to-end deadline, and failure semantics are simple enough to expose directly.

Prefer asynchronous interaction when work can complete later, bursts need buffering, producer and consumer lifecycles should be decoupled, fan-out or replay matters, or the operation may exceed a request deadline.

Asynchrony does not remove coupling. It moves coupling into schema evolution, delivery semantics, lag, ordering, retention, replay, and operational ownership.

## Compatibility And Evolution

- Favor additive changes before removals.
- For extensible evolution and replay paths, favor consumers that tolerate unknown fields and preserve fields that must survive round trips; make providers explicit about required fields. Define exceptions in the contract: extensibility does not imply permissive validation of security-sensitive or business-critical input.
- Do not reuse fields with changed meaning.
- Version only when compatibility cannot be preserved; versions create a migration obligation.
- Discover consumers through code search, access logs, schema registry, dependency data, and owner records.
- Prevent new use of deprecated contracts once a replacement exists.
- Track adoption, deadline, fallback, and final cleanup.

Compatibility is directional and path-specific. Include the version pairs that
can coexist during deployment, persisted-message consumption, replay, and restore:

| Path | Required question |
| --- | --- |
| Old writer, new reader | Do absence, defaults, units, and meaning remain correct? |
| New writer, old reader | Can the old reader handle the new form under the declared contract? |
| Read-modify-write or republishing intermediary | Does decode, mapping, bridging, re-encoding, and storage/publication preserve data that must survive? |
| Rollback or restore | Can the returning software interpret data and workflow history already produced by the newer version? |

Additive shape alone does not establish compatibility. An old intermediary may
silently erase a new field even when endpoint schemas permit it. Preservation
depends on the actual encoding, runtime, and mapping path. Check changed side
effects and semantics as well as successful decoding.

Keep retained data and workflow history in the compatibility scope until their
retention and rollback obligations end. Use
[10-evolution-and-maintainability.md](10-evolution-and-maintainability.md) for the
staged expand-and-contract plan. For a small optional-field change, examine the
affected paths directly; a separate compatibility dossier is unnecessary.

## Boundary Review

- Can the owning team operate this component independently?
- Is there a clear source of truth and transaction owner?
- Does the boundary reduce coupling or merely convert function calls into remote calls?
- How many network hops are on the critical path and what deadline remains at each hop?
- What happens when the provider is slow, unavailable, or returns a partial result?
- Can the contract evolve without coordinating every consumer at once?
- Is the operational cost proportional to the value of independence?
