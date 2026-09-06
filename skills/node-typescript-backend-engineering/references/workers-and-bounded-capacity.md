# Workers, Bounded Capacity, and Correlation

## Decide Whether to Offload

| Work | Starting choice | Evidence needed |
| --- | --- | --- |
| Short, bounded computation | Main thread | Worst-case duration under concurrent request load. |
| Occasional computation divisible into small steps | Partition and yield to the event loop | Maximum step time and scheduling overhead; merely awaiting an already-resolved Promise may not give I/O useful progress. |
| Repeated CPU-intensive JavaScript | Reused bounded worker pool | Queue wait, transfer cost, execution time, memory, and request latency. |
| Separate executable or stronger process isolation | Child process/pool | Startup, IPC, RSS, exit, and supervision behavior. |
| Ordinary network/database I/O | Existing async I/O with admission limits | Downstream capacity and wait time; workers rarely remove this bottleneck. |

Choose pool size from measured demand, CPU quota, memory, task distribution, and latency goals. `os.availableParallelism()` is an input, not a universal formula. Worker threads are not a security sandbox.

## Define a Task Protocol

Prefer an established pool that satisfies the needed contract; inspect its failure and cancellation behavior before adding a custom pool.

Each task needs an identity, validated payload, submission context, deadline, and one owner of its result. Where workers can be replaced or slots reused, include a generation or equivalent ownership token.

Track queued and running tasks separately:

- Admit lazily into a bounded queue; cap waiting bytes as well as count for large payloads.
- Include queue wait in the deadline. Remove cancelled/expired jobs before dispatch.
- Use an application readiness handshake when worker initialization exceeds runtime startup. `online` alone does not establish dependency readiness.
- Handle result, task failure, `error`, and `exit`. A worker crash must settle all affected callers; do not leave promises pending.
- Retry only when the task's effect contract permits it. Replacement needs a budget/backoff to avoid a crash loop.
- Observe late messages but reject stale ownership before publishing a result.

A caller timeout does not make a busy worker idle. Keep its capacity occupied until work completes, cancellation is acknowledged, or termination completes. A tight CPU loop cannot receive a cancellation message until it yields; cancellation may require cooperative checks or terminating the worker.

Worker termination is asynchronous. Await it before considering the worker gone or releasing its resources. Inspect inherited preload/`execArgv` behavior: an unconditional worker spawn in a preload can recursively create workers.

During drain, stop submission, remove or finish queued work according to policy, allow bounded completion, then cancel/terminate and await remaining workers. Route late external effects to reconciliation; a generation check only controls local result acceptance.

## Review Data Movement

| Mechanism | Ownership consequences | Action |
| --- | --- | --- |
| Structured clone | Does not preserve arbitrary prototypes, accessors, non-enumerables, or private state; unsupported values can fail | Use explicit data messages and validate them on receipt; reconstruct behavior in the receiver. |
| Transferable `ArrayBuffer` | Ownership moves and all sender views sharing that buffer are detached | Verify exclusive ownership and ensure the sender will not reuse any alias. |
| `SharedArrayBuffer` | Memory remains shared | Use a defined synchronization protocol; sharing does not provide atomic application updates. |
| Pooled Node `Buffer` | Cloning may include the backing pool rather than just the intended slice | Use deliberately owned, bounded payload storage; inspect backing-buffer size and sensitivity. |

Count clone/transfer/reorder overhead in the benchmark. Do not assume zero-copy or that a message contains only the visible slice.

Worker `resourceLimits` cover selected JavaScript-engine memory, not all external allocations or process-wide OOM. Measure total RSS and external buffers in addition to per-worker heap.

Worker stdio can wait on the receiving event loop. With `stdout: true`, arrange explicit consumption; output is not automatically piped to the parent. Do not use worker log arrival as a reliable readiness signal.

## Preserve Correlation Across Boundaries

Use `AsyncLocalStorage.run()` at the request/task entry boundary with a small correlation record. Avoid mutable global “current request” state and retaining request bodies or credentials.

To diagnose lost context:

1. Inspect `getStore()` before and after the suspected callback/custom-resource boundary.
2. Confirm the correct instance and `run()` scope; account for a configured default value rather than treating `undefined` as the universal outside-scope result.
3. Prefer standard Promise integration when it restores the boundary naturally.
4. Use `AsyncResource` for a genuine custom async resource.

For a custom worker pool, create the diagnostic async resource when the task is submitted, invoke completion in that resource's async scope, and emit its destroy event once at the end of its owned lifecycle. Attributing everything to the long-lived worker loses the submitting request.

Context does not automatically become a cross-thread or cross-service contract. Send the required correlation identifiers explicitly and establish a receiving scope. Correlation data is not authentication or authorization.

Prefer `run()` for scoped entry. Check individual availability/stability before using newer binding/snapshot/scope helpers. `disable()` concerns an AsyncLocalStorage instance's lifecycle, not normal per-request cleanup; the captured v24.20.0 documentation marks `disable()` experimental.

## Verify Recovery

Measure queue depth/bytes, oldest age, running count, event-loop delay, task latency percentiles, timeouts, late results, crashes/replacements, and RSS.

For a changed pool, exercise cancellation while queued and running, worker crash, oversized or uncloneable input, and shutdown with work outstanding. Assert caller settlement and resource ownership as well as returned values. A worker that reports a late result after shutdown must neither publish stale output nor silently occupy a supposedly free slot.

Sources: *Node.js Design Patterns*, fourth edition, chapters 11–12; Node.js Worker Threads and Asynchronous Context Tracking documentation.
