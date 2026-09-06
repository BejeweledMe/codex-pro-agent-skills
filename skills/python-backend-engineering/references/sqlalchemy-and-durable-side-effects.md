# Persistence And Durable Side Effects

## Own One Application Transaction

An application-scoped Session factory is useful; a process-wide operation Session is not. A Session holds mutable identity-map and transaction state. Use a Session per thread and an `AsyncSession` per concurrent task, scoped to the request, job, or use case.

Place transaction outcome outside low-level persistence helpers. A helper may add, load, or flush as the operation requires, but should not silently commit half of a caller's atomic work. A SQLAlchemy transaction context can supply ownership directly; a custom UoW class is optional.

Before changing Session code, trace:

- Construction and first use, including implicit transaction start.
- Reads or flushes that acquire a connection or send SQL.
- The single intended commit point.
- Rollback/disposal on failure and resource release on every exit.
- Object access and serialization after commit, rollback, or close.

## Distinguish Session States

| Mechanism | Consequence | Action |
| --- | --- | --- |
| Autobegin | Logical transaction state can begin before connection checkout. | Inspect Session state and actual SQL separately when explaining transaction timing. |
| Flush | Sends pending changes within the transaction; it is not commit. | Verify visibility and durability using the real transaction outcome. |
| Disabled autoflush | Does not suppress unconditional flush at commit, `begin_nested()`, or prepare. | Locate the actual flush boundary before blaming an unexpected constraint error on a query. |
| Failed top-level flush | Leaves the Session inactive for continued use. | Explicitly roll back or discard it before another operation; do not merely catch and continue. |
| Commit | Can expire state and run events, including for a fresh logical transaction. | Do not assume a fresh `commit()` is universally a no-op; inspect subsequent reload/serialization needs. |
| Rollback | Expunges pending objects, restores deleted objects, and expires remaining non-expunged state regardless of `expire_on_commit`. | Do not reuse the object graph as though it were still the successful pre-failure state. |
| Close | Normally resets the Session; terminal-close configuration differs. | End application ownership even if the library permits reuse. Detached expired objects cannot lazy-refresh. |

For partial-record recovery, establish the intended SAVEPOINT scope. `begin_nested()` flushes pending state before creating the SAVEPOINT, so earlier pending work is not protected by that new nested boundary.

In SQLAlchemy 2.x, use the nested transaction handle or context to finish the SAVEPOINT. `Session.commit()` commits the outermost transaction. A handled constraint error inside a properly rolled-back SAVEPOINT can leave the outer transaction usable; a failed top-level flush is a different recovery case.

Isolation is configured through Engine/Connection behavior. For SQLAlchemy's per-transaction form, establish `Session.connection(execution_options=...)` before other transaction work. If an operation needs a different isolation setting, verify the engine/driver semantics with database-engineering. Session bookkeeping under true DBAPI autocommit does not provide database atomicity.

## Separate Commit Ordering From Durable Publication

Start with the failure timeline:

| Failure point | Possible state | Required handling |
| --- | --- | --- |
| Enqueue before database commit | Worker sees no row, or runs after the transaction rolls back. | Enqueue after successful commit when work depends on those writes. |
| Commit succeeds, enqueue fails or process exits | Business data exists but no job is published. | Use an explicit repair path if loss is acceptable; otherwise persist publication intent atomically with the business write. |
| Publish succeeds, confirmation is lost | Producer cannot distinguish failure from success. | Retry under a stable operation identity with duplicate-safe handling. |
| Consumer commits, then exits before acknowledgement | Broker may redeliver completed work. | Make the effect idempotent or deduplicate atomically with the local business write. |

Django's `transaction.on_commit()` closes the enqueue-before-commit and rollback races. It cannot close the commit-to-publish gap, and callback failure cannot undo the commit. Inspect existing callback error handling and unfinished-work visibility before declaring the fix complete.

If durable handoff is required, system-design owns the cross-system promise. Python's implementation obligations for an outbox-style design are concrete:

1. Store business changes and selected external-message intent in the same local transaction.
2. Give the intent a stable identity and an explicit public payload; do not serialize an arbitrary internal domain object.
3. Publish committed intent through the selected relay and record its outcome under that protocol. Publication can be repeated after uncertain success.
4. Make the receiving effect safe under duplicates. For a local database effect, a durable unique message identity and business writes can share one transaction; acknowledge only after commit.
5. Retain enough state to find and recover pending or failed work. Verify rollback before commit, failure after commit but before publish, and duplicate delivery.

A preliminary lookup followed by a write does not replace a database-enforced uniqueness condition under concurrency. Database-engineering owns that engine proof. External email, payment, or other remote effects need their own idempotency or reconciliation boundary; the local database cannot roll them back.

Do not add an outbox to a best-effort notification without a durability requirement. Conversely, an in-process task or event bus cannot satisfy a requirement that committed work survive process loss.

## Celery: Retry The Effect Deliberately

Workers resolve registered task names rather than receiving function code. Preserve task-name compatibility while queued messages may still refer to it. Send identifiers and deliberately serialized primitives; load current state inside the task's own operation scope.

Choose acknowledgement behavior with the effect in view. Default acknowledgement occurs before execution; `acks_late=True` moves it later and can permit duplicate execution after failures. It does not mean exactly once. Terminated worker children can still be acknowledged unless worker-loss behavior is changed; inspect `task_reject_on_worker_lost` and the failure-loop consequences rather than setting it reflexively.

For retries:

- Distinguish a transient dependency failure from a permanent validation or business result.
- Set explicit I/O deadlines before relying on hard task time limits.
- Bound attempts and elapsed work; use backoff appropriate to the dependency and avoid retry amplification.
- Carry business operation identity separately from an execution attempt. `Task.retry()` republishes with the same task ID and normally raises a control-flow exception.
- Keep required completion logic out of code that assumes execution continues after `retry()`.
- Do not synchronously wait for subtasks from a task.

Test commit ordering and duplicate effects at the boundary that matters. Eager or immediate execution cannot establish broker redelivery, worker-loss, or result-backend behavior. Escalate to a controlled real worker/broker check when the changed guarantee depends on them.

## Alembic: Review The Actual Transition

Autogenerate produces a candidate migration. Compare it with the intended schema and application transition: unexpected drops, missing data preservation, changed constraints, and environments still using the old shape all require review. For repeated generation problems, the cookbook's `process_revision_directives`, `include_object`, or rewriter hooks can express a deliberate filter or transformation; inspect their target-version behavior and the resulting DDL before adopting them.

When executing migrations from application tooling, the cookbook supports sharing a caller-owned connection through `Config.attributes["connection"]`. Ensure the migration environment consumes that connection and has an explicit transaction owner; passing an attribute alone does not establish atomicity.

For a fresh database, creating current metadata and stamping the matching revision is a documented option. Stamping records revision state; it does not execute historical migrations or prove an existing database matches the revision. Keep historical revisions while live environments still need their upgrade paths.

Keep substantial data movement separate from ordinary schema revision logic. For a large change, define schema expansion, a resumable data step, application transition, and later contraction. Route engine locking, online-DDL feasibility, and restore mechanics to database-engineering; use data-engineering when the work becomes a maintained pipeline.

Verify the relevant path on a disposable representative database: new installation or upgrade from the supported old state, application behavior on the result, and the selected failure/recovery path. Do not assume a generated downgrade can restore destroyed data.

## Version And Evidence Limits

Session guidance is based on SQLAlchemy 2.0.52 documentation. Close behavior, transaction nesting, async drivers, SAVEPOINT support, and framework dependency integration need checks against the actual stack. The synchronous external-transaction test recipe is described in [packaging and tests](packaging-and-tests.md); it is not evidence for arbitrary async fixture wiring.

Alembic support here comes from its cookbook, not complete migration or dialect coverage. Schema-tenancy recipes can depend on provisional or internal behavior. Celery task documentation does not establish every broker, prefetch, canvas, deployment, or result-backend setting. Refresh only the details required for the requested implementation.
