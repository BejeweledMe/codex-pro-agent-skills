# Safe Schema Change

Use this module for engine-local migration mechanics and their application compatibility boundary. Scale the procedure to table size, write activity, failure impact, and the actual change; a routine small-table change need not become a multi-release program.

## Separate Five Questions

| Question | Required evidence |
| --- | --- |
| Is the new state valid? | Existing-row violations, null/default meaning, relationship and uniqueness checks |
| What work will the engine perform? | Metadata update, scan/validation, row rewrite, index build, dependencies, and temporary disk/WAL demand |
| What can block? | Exact target-version lock mode, acquisition and hold duration, competing traffic, long transactions |
| Which code can coexist? | Old/new reader and writer behavior, defaults, serialization, and stored-value meaning |
| How can the operation recover? | Transactional rollback, resumable work, roll-forward, retained representation, or backup/restore with its data-loss boundary |

A fast metadata change can wait for a lock. A long validation scan can differ from a rewrite. A transactionally reversible schema change can still cause unacceptable blocking while it runs.

Before executable DDL, establish the exact engine version, complete subcommand, relation type, dependencies, and migration tool's transaction behavior. Do not label an operation “online” from its high-level name.

## PostgreSQL 18 Risk Shape

PostgreSQL 18's Modifying Tables documentation explains that adding a column with a constant default can avoid an immediate row-by-row rewrite, while a volatile default requires values to be written for existing rows. Neither establishes a no-lock guarantee.

Ordinary constraint addition checks existing data; existing values and attached defaults must satisfy the new rule. Where deferred validation is appropriate, verify the exact supported constraint types and the installation/validation lock behavior before selecting that procedure.

Type changes can require rewriting data and revisiting defaults, constraints, indexes, and dependencies. A cast accepted for current data may fail on another row or lose meaning. Inspect the conversion across null, malformed, boundary, and high-volume values.

Do not use cascading removal to resolve an unexplained dependency error. Identify which dependent objects and guarantees would disappear.

The exact `ALTER TABLE` lock matrix, `NOT VALID`/`VALIDATE CONSTRAINT`, concurrent index operations, and timeout settings need their target-version command documentation. These are candidate tools to verify, not an interchangeable zero-downtime recipe.

## Stage a Material Representation Change

Choose stages only where coexistence or data volume requires them. Agree on the authoritative representation throughout the transition.

| Stage | Work | Exit evidence and recovery |
| --- | --- | --- |
| Inspect | Inventory writers/readers, defaults, constraints, indexes, row distribution, and dependencies | Known violation set, transition semantics, engine operation, and resource estimate |
| Expand | Add a compatible representation and any required access/enforcement path | Old code continues to operate; new shape is installed and usable; expansion can be retained if rollout pauses |
| Bridge writes | Make active writers maintain the necessary representations | Concurrent writes preserve the chosen authority and atomicity; mismatch detection exists where needed |
| Backfill | Convert old rows in bounded, resumable batches | Progress plus semantic comparisons; safe restart without overwriting newer writes |
| Validate | Establish completeness and intended constraints | Violations resolved, enforcement state verified, and ongoing writers cannot reopen the gap |
| Cut over | Switch reads and stop obsolete writes through the application rollout | Correct results and workload behavior; previous path remains usable for the agreed rollback window |
| Contract | Remove unused representations, indexes, or compatibility code | Consumer retirement and recovery limits are explicit before irreversible loss |

The backend and software-engineering owners implement code compatibility and release sequencing. Database engineering supplies the exact engine effects and validates the stored transition. A temporary duplicate value should not become an unowned second source of truth.

## Make Backfill Safe Under Concurrent Writes

Decide how a backfill detects that a row changed after it was selected. Depending on the design, transform the current value atomically, use a version/precondition, or take the required locks. Reading old data and later writing an unconditional derived value can overwrite a newer application update.

Choose progress keys with stable semantics. Commit progress only with a completed batch boundary; a restart must not skip an unfinished batch. Preserve rejected rows and conversion reasons rather than silently treating attempted rows as migrated.

Throttle from observed effects: lock waits, write latency, WAL generation, replica/consumer lag where applicable, maintenance pressure, and free space. Use small transactions when they reduce disruption, but do not split an invariant that requires one atomic commit.

Counts alone are insufficient when one source row can become several rows, normalize to an existing key, or change units. Compare the intended relationships and values, including boundary cases and updates occurring during the backfill.

## Plan Stopping and Recovery Before Execution

State the operation's preconditions, expected observations, and when to pause or stop. Set limits from the workload and operating objective rather than importing universal timeout or lag numbers.

For an authorized production change, know:

- Whether cancellation rolls back all work, leaves a partial artifact, or needs documented cleanup.
- Whether rollback code can still read values written by the new version.
- Which constraints and indexes remain valid after an interrupted operation.
- Whether retrying the migration is safe or requires inspecting existing state first.
- Whether recovering lost data requires restore and how later writes would be reconciled.

An inverse DDL script cannot reconstruct a dropped value or reverse a lossy conversion. Keep the old representation through the required recovery window when practical. A backup is useful only when the restore path and acceptable recovery point are established.

Avoid repeatedly retrying a blocked DDL operation without inspecting its lock conflict and the effect on other traffic.

## Verify the Transition

For a material migration, exercise the states likely to break the contract: old writer/new reader, new writer/old reader where supported, interrupted backfill, concurrent update, invalid historical value, partial DDL failure, and application rollback.

Check the resulting schema and actual enforcement state, not only the migration tool's success record. Compare critical query plans and write behavior after the change and after any rollback.

Completion means stored invariants hold, supported clients work, workload costs are acceptable, and recovery matches the remaining state. Removal can remain a later owned step when the rollback window is still active.

## Sources and Refresh Limits

[PostgreSQL 18 Modifying Tables](https://www.postgresql.org/docs/18/ddl-alter.html) provides the validity/default/rewrite foundations; [Constraints](https://www.postgresql.org/docs/18/ddl-constraints.html) and [Explicit Locking](https://www.postgresql.org/docs/18/explicit-locking.html) supply enforcement and conflict semantics.

Architectural basis: *Designing Data-Intensive Applications*, second edition, Encoding and Evolution, Transactions, and verification discussions. The staged compatibility and backfill procedure is engineering guidance built from those constraints, not a quoted engine protocol.

Verify full command references before executable online-DDL claims. SQLite schema changes need SQLite-specific supported operations and rebuild procedures; PostgreSQL DDL and transaction assumptions do not transfer automatically.
