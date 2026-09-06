# Batch, Stream, and Window Semantics

Use this reference when choosing execution semantics or diagnosing inconsistent aggregates, late events, skew, growing state, or recovery after backlog.

## Select Semantics Before an Engine

| Workload | Useful starting point | Cost or limitation to resolve |
| --- | --- | --- |
| Finite, versioned inputs; throughput and rebuildability dominate | Bounded batch | Completion time, resource peaks, and complete-output publication |
| Continuous updates with a freshness requirement | Unbounded stream | Continuous state, time/order policy, checkpoints, and late corrections |
| Existing derived result updated from changes | Incremental maintenance | Correct handling of updates, deletes, dependencies, and reconciliation |
| Historical rebuild plus a live tail | Versioned replay with catch-up | Equivalent history/live semantics, retained input, and cutover |

Batch versus stream is fundamentally bounded versus unbounded input. A stream cannot wait for all future records; a batch can still be processed incrementally when it has a valid partition or dependency contract. Do not require a full rerun for every input change.

An integrated engine may meet the task with less operational complexity than separately assembled processing, broker, and orchestration systems. Select from required behavior, not a preferred architecture.

## Batch Execution and Diagnosis

Follow the data through read, transformation, repartition/shuffle, join/aggregate, materialization, and publication.

- Hash aggregation depends on distinct-key state fitting the available memory. External sort provides a path beyond memory; actual spill behavior is engine-specific.
- Shuffle means repartitioning. MapReduce couples grouping with sorting; other engines need not sort unless the operator requires it.
- Averages hide hot-key tasks. Compare task durations, input/output sizes, state sizes, spill, and retry history across partitions.
- Separate scheduler wait from compute, shuffle/network, spill, retry/preemption, and final publication time before changing parallelism.

| Evidence | Likely constraint | Next action and proof |
| --- | --- | --- |
| Most tasks finish while one key or partition dominates | Skew or excessive join fan-out | Inspect key distribution and join grain; use a semantics-preserving partition/aggregation change and compare output |
| Spill rises with distinct-key count | Working state exceeds memory | Reduce unnecessary state or choose an appropriate execution strategy; measure spill and end-to-end duration |
| Processing is fast but output appears late | Queueing or publication delay | Inspect task admission and readiness path; verify consumer-visible freshness |
| Retries increase sink load and partial results appear | Per-record publication outside a safe boundary | Use versioned staging or an explicit incremental sink contract; verify visibility during failure |

Do not introduce broadcast thresholds, partition counts, or shuffle-cost constants without workload and implementation evidence.

## Specify the Event-Time Chain

For Beam-style processing, record these decisions together:

| Decision | Required meaning |
| --- | --- |
| Boundedness | Whether input has a known end |
| Timestamp | Which event time is assigned, its origin, and uncertainty |
| Key and ordering | Grouping identity and any order the transformation actually requires |
| Window | Exact membership and boundary rules |
| Watermark | Estimate of event-time progress, including stalled or idle input behavior |
| Trigger | When a pane is emitted, including early or late firings |
| Accumulation | Whether subsequent panes include prior contributions or only new ones |
| Allowed lateness | How long late records can affect retained window state |
| Correction policy | Replace, add a delta, retract/recompute, or drop with measured loss |
| Cleanup | When per-key/per-window state and deduplication information may be released |

Window assignment, output emission, and state retention are separate decisions. A watermark is an estimate of progress, not proof that no earlier event can arrive. Allowed lateness alone does not explain what the downstream sink will observe; triggers and accumulation also matter.

Unbounded keyed grouping needs windowing and/or triggers that yield useful results. Retaining a global group forever can prevent meaningful completion and exhaust state.

Translate window semantics rather than labels:

- Tumbling windows have fixed non-overlapping intervals.
- Hopping windows have fixed overlapping intervals.
- Session windows group activity separated by an inactivity gap.
- “Sliding” has different meanings across engines; define the actual relative or overlapping interval behavior.

Pin boundary conventions and timezone handling before comparing implementations. Device-origin timestamps can be uncertain; a device-event/device-send/server-receive comparison estimates clock offset only under explicit network-delay and clock-stability assumptions. Do not silently substitute processing time or treat the estimate as exact.

## Make Pane Consumption Correct

Suppose a window emits a count of 8 and later emits a count of 10 after two late records. If the panes are accumulating totals, appending and summing both creates 18. The sink should replace the appropriate window result or consume an explicitly defined correction.

If panes contain new contributions only, the sink needs a safe way to apply each contribution once. Replayed deltas can duplicate counts. Use stable pane/effect identity or an atomic progress/state/output boundary supported by the implementation.

An upsert key alone does not define which correction wins. Record window identity, result version/order, and the handling of a stale replayed pane. Session merging can change result identity and may require retraction of previously emitted results; confirm the runner and sink contract before using session windows.

## State, Joins, and Historical Meaning

- **Stream–stream join:** retain relevant records from both sides within a declared time relationship. Specify unmatched-record handling and when state expires.
- **Stream–table join:** identify the maintained dimension/changelog and which version enriches an event.
- **Table–table maintenance:** propagate changes on either side, including removals, without assuming that independently updated views share one atomic cut.

Joining replayed events to today's price, tax rate, profile, or classification changes historical output. Preserve the applied value or dimension version when historical semantics require it. Record whether the rule is “effective at event time,” “known at processing time,” or another owner-defined rule.

State capacity depends on retained contributions, their size, active keys/windows, and skew. Measure the worst key, unmatched joins, and stalled watermark behavior; multiplying averages is insufficient. A cleanup policy that bounds memory by dropping admissible records changes correctness and must be exposed as such.

For Beam stateful transforms, do not assume input order. Treat state as scoped to its key/window and define timer/cleanup behavior. For splittable work, claim a work unit before emitting its result, and preserve retry-safe effects. Lifecycle, splitting, and runner support need implementation-specific confirmation.

## Outage and Late-Data Investigation

1. Identify the last trusted input/checkpoint and the first incorrect output window.
2. Compare event timestamps with processing timestamps. Backlog grouped by processing time can appear as a new burst after restart.
3. Inspect watermark progress, window boundaries, triggers, accumulation, lateness, and emitted pane identities.
4. Trace dropped records and corrections into the sink. A side output is useful only if someone owns its disposition.
5. Inspect per-key state age/size, idle or stalled inputs, and unmatched joins.
6. Restore a compatible state/input position or replay into an isolated output; reconcile against the same input cut and declared late-data policy.

Useful verification cases include an out-of-order event, duplicate delivery, arrival within and beyond the lateness allowance, a stalled input, and restart after output but before progress acknowledgment. Select cases that discriminate the suspected failure; a new test framework is unnecessary.

Track watermark lag, late/drop/correction counts, state age/size, checkpoint age, and consumer-visible freshness with workload-specific thresholds. A drop counter is not success evidence unless the consumer explicitly accepts that loss.

## Sources and Version Limits

Based on *Designing Data-Intensive Applications, 2nd edition*, batch/dataflow execution, event time, windows, joins, and recovery; and Apache Beam documentation on boundedness, timestamps, windows, watermarks, triggers, accumulation, lateness, state, and splittable processing.

Beam lifecycle/testing details, idle-input behavior, and exact runner APIs require targeted documentation. Book terminology does not establish modern Flink, Spark, Kafka, or Beam configuration. No universal state-size formula, broadcast threshold, or runner-independent “exactly-once” guarantee is implied.
