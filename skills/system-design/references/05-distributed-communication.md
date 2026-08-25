# Distributed Communication

## End-To-End Deadlines

Every remote call can be slow, unavailable, duplicated, or partially completed. Define an end-to-end deadline at the entry point and propagate the remaining budget downstream.

- Connection and request timeouts must fit inside the caller's remaining deadline.
- Reserve time for serialization, queues, retries, and response handling.
- Cancel work that no longer benefits the caller where cancellation is safe.
- Measure outbound rate, errors, and latency per dependency and operation.

A timeout means the caller stopped waiting; it does not prove the remote operation did not happen.

## Retries

Retry only transient failures and only when the operation is safe to repeat or carries an idempotency identity.

Use:

- Bounded attempts and a retry budget.
- Exponential backoff with jitter.
- Deadline awareness.
- Server hints when trustworthy.
- One deliberate retry layer on a call path where possible.
- Load shedding or circuit breaking when the dependency is saturated.

Nested retries multiply traffic. If each of several layers retries independently, a small failure can become a large request storm.

## Idempotency And Deduplication

For retried commands:

- Give each logical operation a stable identity.
- Define the deduplication scope, lifetime, and stored result.
- Make parameter mismatch under the same key an error.
- Persist deduplication state atomically with the protected state change when correctness requires it.
- Distinguish idempotent state transitions from non-idempotent external effects.

Natural idempotency such as `set value to X` is preferable to fragile deduplication where the domain allows it.

## Queues And Streams

Define the contract explicitly:

- Delivery: at-most-once, at-least-once, or an application-level effective-once outcome.
- Ordering: none, per key, per partition, or global.
- Retention and replay window.
- Consumer group, fan-out, and ownership model.
- Acknowledgment and visibility semantics.
- Retry schedule, maximum attempts, and dead-letter handling.
- Schema compatibility and event identity.
- Lag, queue depth, age of oldest item, and processing latency.

End-to-end exactly-once effects require coordination with the destination state and external side effects; a transport guarantee alone is insufficient.

## Backpressure And Overload

- Bound queues, in-flight work, connection pools, and per-tenant concurrency.
- Propagate overload rather than buffering without limit.
- Use admission control and priority classes to protect critical work.
- Pause or slow producers when consumers cannot keep up, where the protocol allows it.
- Shed optional or low-priority work before critical work.
- Ensure autoscaling uses a signal that reflects pending work and accounts for startup delay.
- Define what happens when the backlog exceeds retention or the drain time violates freshness targets.

## Coordination

Avoid distributed coordination where partitioned ownership or deterministic conflict resolution can solve the problem. When coordination is required:

- Use leases with expiration rather than assuming a process remains leader forever.
- Use fencing tokens so a stale leader cannot continue mutating protected state.
- Treat clocks as imperfect; do not infer a total event order from wall time alone.
- Make lock scope, timeout, renewal, failure, and recovery explicit.
- Ensure the coordination system's availability does not silently cap the whole service.
- Test pause, restart, network partition, duplicate leader, and delayed message scenarios.

## Communication Review

- Is the interaction required on the critical synchronous path?
- What is the remaining deadline at each hop?
- Can the operation complete after the caller times out?
- Are duplicates, reordering, partial batches, and poison messages safe?
- Where is backpressure applied and what is bounded?
- How are retries prevented from amplifying an outage?
- What state proves ownership when leaders or workers overlap?
