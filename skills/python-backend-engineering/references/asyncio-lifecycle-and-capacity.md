# Async Lifetime And Capacity

## Give Every Task An Owner

Identify who starts each task, holds it alive, observes its exception, and awaits completion during cancellation or shutdown.

Inspect blocking calls on the event loop when unrelated requests stall together. A synchronous driver or CPU-heavy function does not become nonblocking because its caller is async. Use a supported async interface or an appropriate offload boundary for the workload; preserve connection/thread ownership and verify event-loop responsiveness. Check the runtime and framework documentation before choosing exact offload APIs.

Use `TaskGroup` for coupled work when one ordinary failure should cancel siblings and the parent should await the group's completion. Default `gather()` propagates the first exception without cancelling other awaitables; changing between them changes failure behavior. If using `gather(return_exceptions=True)` for independent partial results, inspect every result and give failures an explicit disposition.

For deliberately independent background tasks, retain strong references and collect terminal outcomes. The event loop keeps weak task references. Keeping a task alive solves ownership only within the process; it does not make accepted work durable.

Give each concurrent database task its own `AsyncSession`. If several writes must be one atomic operation, do not distribute them across independent Sessions and assume the group restores atomicity. Reconsider the operation boundary.

## Choose The Cancellation Target

| Primitive | Timeout/cancellation behavior | Application obligation |
| --- | --- | --- |
| `asyncio.timeout()` | Cancels the current task and exposes `TimeoutError` outside the context. | Place the context around the intended operation and handle its timeout outside it. |
| `wait_for()` | Cancels the awaited operation on timeout; cancellation completion may exceed the nominal timeout. | Include cleanup time in observed latency and verify the operation actually terminates. |
| `wait()` | Timeout leaves pending work running. | Inspect returned pending tasks and explicitly retain, cancel, or await them. |
| `as_completed()` | A timeout does not itself cancel unfinished awaitables. | Own remaining tasks after partial results or timeout. |
| `shield()` | Protects the inner awaitable from caller-originated cancellation; the caller still observes cancellation. | Keep a strong owner for the inner task and define its eventual outcome. Shielding is not durable execution. |

`cancel()` requests cancellation; it does not prove completion. Cleanup belongs in `try/finally`, with `CancelledError` normally propagated. It inherits from `BaseException`; broad catches or deliberate suppression need careful inspection because structured concurrency and timeout scopes depend on cancellation.

Do not turn cancellation into an automatic business retry. First determine whether the database or remote effect committed. A cancelled caller may have an uncertain outcome, not a failed effect.

## Bound Admission And Active Work Separately

A positive queue `maxsize` bounds queued items and blocks producers when full. It does not bound item size, active consumers, work already spawned, or tasks waiting to enqueue. Inspect the whole producer-to-consumer path.

Choose limits from the workload and downstream capacity. For bursts, specify what happens when admission cannot complete within the caller's budget. Avoid moving an unbounded backlog from the queue into a list of newly created tasks.

Asyncio queues are not thread-safe. Their methods do not accept timeout parameters; use an appropriate waiting primitive for timed queue operations, with its cancellation behavior understood.

Call `task_done()` once for each successful `get()` when that item's local handling has concluded. `join()` waits for unfinished-work accounting to reach zero. It does not independently prove that every business effect succeeded; failed items need an explicit retry, failure, or repair disposition.

## Shut Down Without Inventing Completion

For a service with owned workers:

1. Stop accepting new work and coordinate producers.
2. Allow owned consumers to drain within the available shutdown budget.
3. Await task outcomes; at the deadline, cancel remaining local work and await cleanup.
4. Close clients and Sessions after their users have stopped.
5. Record unresolved work and use the established durable retry or recovery path where loss is unacceptable.

Python 3.13 added queue shutdown. Non-immediate shutdown supports draining; immediate shutdown can unblock `join()` without processing the remaining items. Treat that as abandonment requiring accounting, not successful processing. For older runtimes, use the project's supported shutdown protocol and verify equivalent lifecycle behavior.

## Diagnose By Ownership And Time

| Signal | Distinguishing evidence | Correction and verification |
| --- | --- | --- |
| Requests time out but work continues | Timeout primitive, pending task identities, and completion timestamps. | Correct the cancellation target or retain intentional work; verify terminal outcomes after timeout. |
| Shutdown hangs | Task stacks, swallowed cancellation, queue counts, and close ordering. | Restore propagation/accounting and bound the drain; verify resources close and unfinished work is reported. |
| Memory grows despite a bounded queue | Queued bytes, active work, waiting producers, and spawned-task count. | Bound the actual accumulating stage; exercise overload and recovery at representative payload sizes. |
| One child fails but siblings keep writing | `gather()` versus `TaskGroup`, Session ownership, and commit timeline. | Choose deliberate group behavior and transaction scope; verify committed state after failure. |

Observe queue age, in-flight work, task failures, cancellation-to-completion time, and resource closure. Avoid logging full private payloads.

The source basis spans Python 3.11–3.14 features. Verify runtime availability and exact behavior before adopting `TaskGroup`, queue shutdown, or newer task-start/iteration options. These rules do not supply a universal concurrency count or shutdown duration.
