# SQLite WAL and Backup

Use this module for embedded database visibility, contention, checkpointing, copying, and recovery. Identify the SQLite library actually in use, journal mode, connection ownership, transaction duration, filesystem, and backup destination before changing behavior.

## Connection Scope Comes First

Separate connections ordinarily see committed transactions only. The documented dirty-read exception requires both shared cache and `read_uncommitted`; do not assume either is active.

A connection sees its own completed writes. Changing data on that same connection while a `SELECT` is still being stepped has undefined visibility. Finish the cursor/read or design a separate controlled phase instead of depending on which changed rows an active iteration happens to see.

SQLite serializes writers. WAL allows useful reader/writer overlap, but does not create multiple simultaneously progressing writers.

| State | Behavior | Design implication |
| --- | --- | --- |
| Rollback journal | Readers are excluded before changed pages are flushed into the database file | Account for reader/writer exclusion and transaction duration |
| WAL read transaction | Reader fixes an end mark and retains that snapshot | End and restart the read transaction to observe later commits |
| WAL writer | Commits append to WAL while readers can retain earlier snapshots | Keep the single-writer capacity and WAL/checkpoint lifecycle visible |
| Stale WAL reader attempts a write | Upgrade can fail after another connection commits | Restart the whole read/decide/write operation |

## Diagnose Busy Outcomes

`SQLITE_BUSY_SNAPSHOT` can occur when a WAL reader tries to write from a snapshot made stale by another connection's commit. Waiting longer does not make that old decision current. End the transaction and reread before retrying.

For an operation known to write, `BEGIN IMMEDIATE` can reserve the writer position before reading and deciding. Use it when preventing the later upgrade race justifies earlier writer contention. The begin itself can block or fail; it is not a promise that every busy condition disappears.

Other busy outcomes can involve an existing writer, exclusive locking, cleanup by the last connection, or crash recovery. Distinguish them through transaction sequence, connection state, and the exact result code before changing timeouts.

The backend owns connection/cursor cleanup and application retry code. Supply it with the expected engine outcome and the required retry scope.

## Checkpoint Progress and Long Readers

A checkpoint copies WAL pages back into the main database file while respecting active reader end marks. Long-lived or continuously overlapping readers can prevent full progress/reset, allowing WAL to grow and read costs to increase.

For growing WAL:

1. Confirm WAL mode and identify active readers, writers, and checkpoint ownership.
2. Observe read-transaction duration, WAL growth, write activity, and checkpoint progress over the same interval.
3. Distinguish an old retained snapshot from sustained write volume or insufficient checkpoint opportunity.
4. Shorten unnecessary read lifetimes or move long processing outside the active cursor/transaction where semantics allow.
5. Recheck progress after the old readers finish and under representative application concurrency.

Do not infer that a checkpoint request emptied the WAL. Checkpoint mode, busy handling, return values, and reset/truncation conditions require the matching API documentation. Choose checkpoint policy from the workload; a documented default page threshold is not a universal tuning recommendation.

Changing journal mode is a database/file-lifecycle decision, not a per-query optimization. WAL mode persists once enabled. Verify the transition and connection conditions before switching it.

## File Custody Is Data Custody

Committed transactions can exist only in `-wal` until checkpointed. The main `.db` file alone is therefore not necessarily the latest complete database.

The `-shm` file supports the host-local WAL index; it is not interchangeable with the durable transaction content of `-wal`. Standard WAL shared-memory assumptions generally require processes on the same host. Ordinary network-filesystem sharing is not a substitute for a supported deployment arrangement.

For a requested live copy:

- Do not copy only the main database while connections remain active.
- Do not assume separately copying the database and sidecars at different times produces one consistent point.
- Prefer a supported consistent backup mechanism.
- If a physical file copy is required, establish a documented quiescence/snapshot procedure for the exact engine mode and filesystem.

Never delete a live WAL to reduce disk usage. Resolve the retention/checkpoint cause through the engine. Preserve the original state while investigating a failed copy or recovery.

## Use the Online Backup API as a Completion Protocol

The Online Backup API copies one database into another and replaces destination contents. Use an intended backup destination and the required connection ownership; successful initialization or partial progress is not a completed backup.

The documented sequence uses `sqlite3_backup_init`, incremental `sqlite3_backup_step`, and `sqlite3_backup_finish`. A completed sequence produces a consistent destination snapshot; under intervening writes and restarts, do not promise that it represents the original wall-clock start time.

Operational obligations:

1. Establish the source database and destination identity, source/destination connection lifecycle, and acceptable source-lock intervals.
2. Step incrementally when reducing the continuous lock interval matters.
3. Handle busy/locked/error outcomes according to the function contract, with a bounded completion policy suitable for the task.
4. Require the documented successful completion result from stepping and successful cleanup; `finish` does not erase an earlier step failure or prove all pages were copied.
5. Close/clean up through the API on failure and keep incomplete destinations from being published as usable backups.
6. Reopen the completed destination in isolation and validate critical data and application invariants.

Writes through another source connection can restart copying. Sustained writes can prevent completion; plan a bounded retry window or a controlled quieter period rather than looping without an end condition.

The documented file-backed same-source-handle write case can update the destination without the usual restart. Treat that as a specific API case, not permission to share connection handles across arbitrary concurrent work.

Backup progress counters describe the previous step and can become stale as the source changes. They are not a durable checkpoint or a reliable completion percentage under ongoing writes. Errors are associated with the destination connection; preserve the actual step and finish outcomes.

## Restore and Verify the Intended Snapshot

Opening a backup successfully establishes less than recoverability. Verify the intended source and completed backup, expected schema, critical relationships/uniqueness, representative recent operations, and the application's ability to use the restored database.

Keep restore inspection isolated from live application connections. A file replacement while connections still hold old database/WAL state needs a documented lifecycle procedure; simply renaming a file is not sufficient evidence of safe cutover.

For a failed or interrupted backup, preserve the original source and report the destination as incomplete until a supported completion path succeeds. For a WAL-copy incident, retain available coupled state and distinguish missing committed data from an application reading an old snapshot.

Measure backup completion time, restarts/busy outcomes, application contention, checkpoint progress, and achieved recovery state under the workload that matters.

## Sources and Refresh Limits

- [Isolation in SQLite](https://sqlite.org/isolation.html): connection visibility, rollback/WAL isolation, stale snapshots, and early writer reservation.
- [Write-Ahead Logging](https://sqlite.org/wal.html): snapshots, checkpoints, sidecars, host assumptions, and compatibility.
- [SQLite Online Backup API](https://sqlite.org/backup.html): consistent copying, incremental locks, restart/progress behavior, and completion/error handling.

Before executable backup code, verify child function contracts and their behavior for the deployed WAL-mode source. This reference does not establish every checkpoint mode, filesystem snapshot method, encrypted-database extension, `VACUUM INTO`, synchronization utility, or snapshot API.

Check release documentation for patch-level WAL fixes and read-only compatibility. Do not infer the installed library's safety from an unverified remembered patch number, or infer WAL2/parallel-writer behavior from standard WAL documentation.
