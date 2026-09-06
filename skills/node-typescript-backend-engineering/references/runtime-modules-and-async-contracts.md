# Runtime, Modules, and Async Contracts

## Diagnose the Execution Resource

JavaScript callbacks on one event-loop thread execute serially, but Node also uses OS I/O, libuv workers, and optionally separate JavaScript workers or processes. Async gaps still allow logical check-then-act races.

| Observation | Distinguishing evidence | Action and verification |
| --- | --- | --- |
| Unrelated requests and timers stall together | Event-loop delay and CPU profile; synchronous I/O, large JSON/regex work, recursive microtasks | Bound input/work, remove synchronous request-path I/O, partition or offload CPU; repeat with worst-case input and concurrent lightweight requests. |
| Some filesystem, DNS, crypto, or compression calls queue while the loop remains responsive | Which APIs use libuv workers, outstanding jobs, and latency by operation | Bound shared-pool consumers and reduce expensive job size; verify unrelated pool users recover. |
| Only one downstream stage slows | Connection/pool wait, dependency latency, retries, queue age | Apply capacity control at that resource; do not add JavaScript workers to ordinary I/O. |
| Duplicate domain transitions despite serial JavaScript | Reads and writes separated by `await`; concurrent operation identities | Move the invariant into the appropriate transaction/conditional-write boundary; verify competing calls against the real dependency where needed. |

Promises and `async` do not move synchronous CPU work off the calling thread. Recursive `process.nextTick` or microtask scheduling can starve I/O. Do not encode domain correctness in timer-versus-immediate ordering; exact ordering depends on runtime and calling context.

## Make the Loaded Graph Explicit

Inspect `package.json`, file extensions, public exports, the executed entrypoint, and the build/test commands together. Type checking and successful execution through a development loader do not establish that Node can load the distributed artifact.

- Keep known dependencies statically imported; use dynamic import for genuinely conditional loading.
- Localize ESM/CommonJS translation. Verify default/namespace shape, receiver assumptions, live bindings, and initialization order at that boundary.
- Keep public exports narrow. Deep imports create dependencies on package internals.
- Put resource construction in an application composition root or explicit factory. Avoid hidden business effects during import.
- A module singleton is local to its resolved instance; duplicate package copies, workers, and processes may have different instances.
- Investigate cycles when they expose partially initialized state. Top-level await in libraries can block importers and complicate cycles and interop.

For a loader failure, reproduce with the actual output artifact and start command, inspect the resolved entry and first failing import, then correct the smallest package/build boundary. Verify every supported loading mode rather than changing source imports until one development command happens to pass.

Refresh exact rules for `require(ESM)`, import attributes, native TypeScript stripping, ambiguous `.js`, and conditional exports before prescribing a version-specific migration.

## Own Completion

For an operation crossing an async boundary, make these facts clear in code or a short contract:

- Who starts it and when observers may first receive notification.
- Who receives the value or error.
- Which branch owns terminal completion.
- Who may cancel, what cancellation stops, and how late results are handled.
- Who releases listeners, timers, queue entries, and resources.

Use a single terminal path for callbacks and event-driven adapters, with control flow returning after completion. Promise settlement happens once, but that alone does not prevent a second response send or duplicate side effect elsewhere.

Keep callback timing consistent across cache hits and misses. Register listeners before work can emit. A `try/catch` around registration cannot catch a throw from a later callback stack.

Await, return, or explicitly catch each Promise. Detached work needs its own lifetime and error owner. Within a local `try/catch`, awaiting a rejection matters; removing `return await` can change error handling.

| Work shape | Appropriate control | Failure obligation |
| --- | --- | --- |
| Dependent sequence | `for...of` with `await` | Stop or continue according to the operation contract. |
| Small bounded independent set | `Promise.all` | Rejection does not cancel siblings. |
| Every outcome is needed | `Promise.allSettled` | Account for retained results and total waiting time. |
| First equivalent result | `Promise.race` with explicit loser cleanup | Racing does not stop losers or undo effects. |
| Dynamic or large collection | Lazy producer with bounded admission | Do not create all promises before applying the limit. |

`forEach(async ...)` supplies neither sequential execution nor an aggregate result.

In-flight coalescing may share one operation among callers. Remove the owned entry on completion, including failure; guard against deleting a newer replacement. Define whether one caller's cancellation only unsubscribes that caller or can cancel shared work. This registry is not durable or cross-process idempotency.

## Admission, Readiness, and Cancellation

Give each constrained resource one authoritative admission policy. Bound running work, waiting count or bytes, and maximum waiting time. Reject or pause intake before creating expensive work. Avoid several hidden queues that each consume the full request deadline.

Choose readiness proportional to the dependency:

- An async factory can fail startup before accepting traffic.
- An explicit readiness check suits a small number of callers.
- A provider-owned pre-initialization queue supports lazy/reconnecting clients only with bounds, deadlines, failure fan-out, and shutdown behavior.

On initialization failure, reject waiters and dispose resources already acquired. Clear failed initialization state when retry is intended; prevent a permanently rejected cached Promise from silently poisoning all later calls.

Pass an `AbortSignal` down supported boundaries, check already-aborted requests before starting, and remove listeners/timers afterward. Cancellation is cooperative. A timeout settles the caller's wait; the underlying task may still occupy capacity or commit an effect.

Release a queued slot when the job is removed. Release a running slot when execution has actually stopped or completed, not merely when the caller times out. Otherwise timed-out work can accumulate behind apparently free capacity.

Handle the signal's documented reason; not every abort uses an error named `AbortError`. For non-cancellable effects, retain an observation or reconciliation owner.

## Runtime Adapters and Domain Effects

Keep transport parsing and response state at the adapter boundary. Put a use case's business transition in an explicit function or service when it needs coordination; a simple handler need not acquire a repository hierarchy or DI container. The composition root supplies dependencies and owns their startup and teardown. Select wrappers or patterns for a demonstrated creation, translation, variation, or lifecycle problem.

The use-case owner coordinates the chosen transaction and external effects. Acquire a connection/session for its intended lifetime, await completion, and release it on failure as well as success; use the installed client's transaction API rather than assuming Promise completion implies commit. Keep authorization and domain invariants enforced at the actual operation boundary, including worker or message entrypoints that bypass HTTP. Route engine guarantees and cross-system atomicity to their owners while implementing the agreed sequence here.

Scaling the process duplicates module-local state. Identify which caches are disposable and which sessions, pending operations, or deduplication state require shared authority. Sticky routing does not by itself provide recovery after instance loss. Pass topology and durable-state decisions to system-design; keep this process's reconnect, no-instance, and drain behavior explicit.

Prefer a narrow adapter or plain function over a transparent wrapper promise. Preserve values, receiver binding, timing, errors, cancellation, and cleanup. Proxies can break methods that depend on internal slots or private state. Test the supported interface against the real implementation when substitution matters.

Keep request-response state separate from effect state:

- A disconnected client may have a committed write.
- A successful local `socket.write()` indicates local acceptance, not a remote acknowledgment.
- A broker acknowledgment and a consumer's durable effect are different observations.
- A request/reply adapter needs a bounded pending map, correlation identity, timeout cleanup, and an explicit late-reply policy.

Implement the agreed transaction and acknowledgment ordering. For an at-least-once consumer whose acknowledgment marks a completed durable effect, acknowledge after that effect and implement the agreed duplicate handling: a crash between commit and acknowledgment can cause redelivery. At-most-once or other acknowledgment contracts have different loss tradeoffs; do not silently replace them.

Bound consumer prefetch/in-flight work and reconnect retries. Classify transient and permanent failures, apply the chosen deadline/backoff/attempt budget, and route poison messages through the configured recovery path. For retained-stream consumers, implement the broker's specified cursor and pending-ownership recovery; automatic reassignment is not universal. Check the installed broker/client semantics before exact acknowledgment, claim, or retry calls.

If a process can fail between an effect and acknowledgment, pass that failure window to `system-design`; do not claim an in-memory guard solves redelivery. Use `data-engineering` for pipeline publication and replay semantics. Verification should distinguish effect count, acknowledgment state, and retry/late-reply behavior under the relevant failure window.

## Graceful Drain

For a service with accepted work, implement an idempotent shutdown path:

1. Enter draining state and stop new admission, including internal producers and reconnect loops.
2. Stop accepting new connections or work through the framework/transport lifecycle. Coordinate readiness with the deployment owner.
3. Let accepted work finish within the remaining shutdown budget; remove queued work that will not run and notify its callers.
4. At the deadline, propagate cancellation, close/destroy remaining transports as appropriate, and await worker termination. Record uncertain effects for reconciliation.
5. Close dependencies after their users have stopped; clear timers/listeners and report the shutdown result to the supervisor.

Keep-alive connections, streams, and long-lived sessions need explicit handling. Verify the installed Node/framework close APIs; a call to `close()` is not a universal proof that every resource has drained.

After an unrecoverable uncaught failure, do not use an exception handler to continue ordinary service as though state were trustworthy. Bound cleanup and hand restart to the supervisor.

Verify drain with accepted work, queued work, a slow dependency, and repeated shutdown signals when these paths are affected. Evidence should show admission stopped, callers settled, resources closed, and unresolved effects identified.

Sources: *Node.js Design Patterns*, fourth edition, chapters 1–5, 7–9, and 11–13; Node.js “Don't Block the Event Loop (or the Worker Pool)”; Express Performance and Reliability guidance.
