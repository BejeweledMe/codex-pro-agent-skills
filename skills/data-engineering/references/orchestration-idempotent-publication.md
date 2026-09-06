# Orchestration and Idempotent Publication

Use this reference for retry-sensitive tasks, drifting partitions, missing artifacts, partial output visibility, and recovery from uncertain publication.

## Separate Control Responsibilities

| Layer | Owns | Does not establish |
| --- | --- | --- |
| Processing runner, such as Beam | Data-plane execution, windows, state, timers, and supported recovery | Arbitrary external effect safety or cross-dataset publication |
| Workflow orchestrator, such as Airflow | Dependency readiness, task scheduling, retries, and task state | Event-time completeness or atomic destination writes |
| Resource scheduler | Admission, placement, fairness, and resource availability | Transformation correctness |
| Durable workflow execution | Persistent history of long-running operation progress | The data semantics of every activity's output |
| Publication mechanism | Which complete dataset version readers may use | Business validity without corresponding checks |

Airflow trigger rules concern upstream task states. Beam triggers concern emitted data panes. A successful task graph is evidence of control flow, not proof that required source data arrived or that consumers see one complete version.

## Make a Retry the Same Logical Work

For each affected task, define its logical identity using the dataset/output, deterministic data interval or partition, input versions, and transformation version. Attempt identity is separate.

Use interval boundaries consistently, such as a declared half-open interval, and pin timezone semantics. Scheduling time and wall-clock “today” are unsafe substitutes for the interval being processed.

For example, a daily task rerun two days later should still build its original interval from the declared inputs. If the intent is to incorporate newly arrived records or new code, represent that as a new derivation/output version with an explicit replacement rule.

Before retry:

1. Inspect durable output or completion state for the same logical work.
2. Detect mismatched parameters under a reused identity.
3. Reuse a complete matching result, resume only through a supported recovery mechanism, or repeat a safe operation.
4. Treat a timeout as an unknown outcome until the destination establishes what committed.

Use bounded retries for transient failures, with backoff and a deadline or work budget appropriate to the task. Avoid multiplying independent retries at orchestrator, runner, connector, and sink layers. Stop repeated attempts on deterministic schema errors, broken invariants, or unreconcilable external outcomes.

## Select the Sink Boundary

| Output pattern | Safe mechanism to establish | Common false assumption |
| --- | --- | --- |
| Keyed current-state table | Transactional upsert/replacement with stable key and update ordering | An upsert that increments a value is automatically idempotent |
| Complete partition or dataset version | Isolated build, validation, and atomic publication/readiness switch | Writing each row successfully makes the whole version atomic |
| Append-only facts or deltas | Stable event/effect identity with supported duplicate suppression | A new task attempt ID identifies the original fact |
| External command | Destination idempotency/status contract or owned reconciliation | A runner retry can undo the first command |

A unique key protects only the identity and concurrency scope it actually enforces. Check how updates, deletes, stale writers, and conflicting derivation versions behave. A completion marker is one option, not a prerequisite: authoritative sink state or a supported idempotency/result contract can also establish prior completion.

## Publish a Whole Version

Use existing storage/table/catalog mechanisms; do not assume that renaming a directory or writing a marker is atomic for the target system.

1. **Build an isolated candidate.** Identify inputs, code/configuration, interval, schema, and candidate output version. Readers continue using the last eligible published version.
2. **Complete durable output.** Verify all required partitions/artifacts are written and readable. Do not mark success while required data remains only on a worker.
3. **Validate readiness.** Check the consumer's required shape, content, freshness, and deletion/access conditions. For a live derivation, identify the caught-up source cut.
4. **Commit visibility.** Use a supported transaction, conditional pointer change, table commit, or equivalent mechanism. State the atomic scope and prevent a stale worker from publishing over a newer accepted version. Recheck eligibility if source or policy changes invalidate validation; ensure deletion/access changes during the transition are enforced before affected data is served.
5. **Verify readers.** Confirm that readers resolve one eligible version and that caches/routing honor the transition. Multi-table consumers may need a coordinated release identity; one table's atomic commit does not make several tables atomic.
6. **Retain and retire.** Preserve the prior eligible route for rollback as required, then clean unreferenced or obsolete output according to retention/deletion rules.

Publication identity and evidence may live in existing catalog metadata, a control table, or another established durable record. Choose the smallest mechanism that proves visibility and recovery; do not introduce a separate manifest service by default.

## Recover Across Publication Failures

| Observed state | Recovery |
| --- | --- |
| Candidate incomplete and not visible | Resume through a supported mechanism or rebuild; keep readers on the published version |
| Candidate complete but not published | Verify inputs and readiness still match, then attempt the supported commit |
| Publication response lost | Inspect authoritative publication state before retrying; do not infer failure from the timeout |
| Another version won the commit | Reevaluate ordering and compatibility; do not blindly republish an older candidate |
| Published candidate fails a consumer invariant | Stop further propagation where needed, use an eligible fallback, and repair/rebuild with explicit comparison |
| Old task resumes after replacement | Reject its stale write/publication through the destination's ownership/version mechanism |

Reverting a pointer is not sufficient if the old version violates current access/deletion requirements or if consumers have already produced irreversible effects. Include those obligations in rollback eligibility and reconciliation.

## Airflow Implementation Guidance

The following guidance is scoped to Airflow 3.3.1 documentation; verify target-version details when implementing:

- Make tasks retry-identical and transactional at their output boundary. Prefer supported upsert/replace patterns over retry-sensitive inserts.
- Select deterministic data-interval inputs and partitions. Keep wall-clock time out of critical transformation decisions.
- Treat DAG parsing as an operational path. Move top-level networking, database work, heavy imports, and repeated uncached variable access out of parsing when they cause scheduler overhead.
- Use XCom for small coordination messages and durable remote storage for substantial artifacts. Pass artifact identity/version and location; do not assume the next task runs on the same worker or sees its local files.
- Use Connections for credentials rather than embedding them in DAG code or artifact payloads.

Dependency isolation, executor behavior, lifecycle hooks, and exact APIs need the installed environment and targeted documentation. Do not infer runner data semantics from Airflow task state.

## Diagnose the First Broken Boundary

| Symptom | Inspect | Fix and proof |
| --- | --- | --- |
| Retry writes a different date | Interval, timezone, wall-clock references, input/config versions | Pin logical interval and inputs; repeat the task and compare the intended partition |
| Duplicate or inflated output | Effect IDs, attempt IDs, insert/increment behavior, acknowledgment order | Establish sink idempotency/atomicity; exercise a lost-response recovery |
| Downstream cannot find an upstream artifact | Worker placement, local paths, upload completion, referenced version | Use durable artifact storage and verify read from a separate worker context |
| DAG scheduling degrades before task execution | Parse duration and top-level work | Move expensive parse-time operations; measure scheduling and task-start behavior |
| Readers see mixed versions | Publication state, reader routing, per-record writes, cached pointers | Establish and inspect complete-version visibility through failure and retry |

For proportionate verification, select the relevant interruption point: before output, during output, after output but before acknowledgment, or after publication with a lost response. Check consumer-visible state and duplicate effects, not only the task's final status.

## Sources and Limits

Based on Apache Airflow 3.3.1 best-practice guidance for retryable tasks, parsing, XCom, durable artifacts, and Connections; and *Designing Data-Intensive Applications, 2nd edition*, batch publication, end-to-end identity, effectively-once effects, and parallel reprocessing.

The publication state transitions are engineering applications of those mechanisms. Atomic rename, object-store visibility, database upsert, catalog commit, and fencing behavior must be proved for the destination; no universal command sequence is supplied.
