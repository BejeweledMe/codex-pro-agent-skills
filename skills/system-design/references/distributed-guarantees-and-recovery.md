# Distributed Guarantees And Recovery

Use this reference when a design depends on retries, exclusive writers, replicated
history, cross-system transactions, or replay. Examine only the affected
guarantees; a small change does not require a full system model or review packet.

Contents:

- Claims and failure assumptions.
- Isolation, recency, commit, and consensus.
- Uncertain outcomes and external effects.
- Resource-side fencing.
- Quorum and authority transitions.
- Ordering, retention, and replay.
- Diagnostic and recovery evidence.
- Source foundations and implementation limits.

## State The Claim And Failure Assumptions

Write the forbidden outcome in domain terms: one reservation consumed twice, a
confirmed write lost, a stale owner mutating an object, or a notification exposing
state that the intended reader cannot yet access. Identify the operation,
conflict key, authoritative state, permitted writers, acknowledgment, and final
effect boundary.

State the assumptions on which the selected mechanism relies:

- Can nodes pause, recover, or lose/corrupt durable state?
- Can messages be lost, duplicated, reordered, delayed, or cross a one-way partition?
- Which timing or clock bounds are required?
- Is membership fixed or reconfigurable, and who establishes authority changes?
- Which dependencies and failure domains are shared?
- Does the fault model include malicious participants, or only accidental failures?

Separate safety from liveness. “No conflicting accepted write” is a safety claim.
“An accepted operation eventually completes” also needs retained work, available
dependencies, and a viable recovery path. A timeout may trigger investigation
without proving nonexecution or safe transfer of authority.

## Distinguish The Required Guarantees

| Property or mechanism | What it addresses | What it does not establish alone |
| --- | --- | --- |
| Linearizability | Operations on the specified object behave as one copy in an order respecting real-time precedence | Isolation of a multi-object business transaction |
| Serializability | Committed transactions are equivalent to some serial execution over their participating scope | Real-time recency or correctness of business logic |
| Strict serializability | Serializable transactions whose order also respects real-time precedence | Availability through every partition |
| Atomic commitment | Participating changes share a commit/abort outcome | Transaction isolation or atomicity with excluded effects |
| Two-phase locking, or 2PL | Concurrency control through a locking protocol | The responsibility of two-phase commit |
| Two-phase commit, or 2PC | Atomic transaction outcome through prepare and decision | Nonblocking recovery after every coordinator or storage failure |
| Consensus | Agreement on a value or ordered history under a stated fault model | Application invariants or correct effects at arbitrary external resources |

Choose by the forbidden history. A multi-row booking rule may need a constraint
and isolation mechanism covering every conflicting writer. A current-owner
decision may need a linearizable conditional operation. A workflow spanning
independent services may deliberately expose intermediate states with
reconciliation or compensation.

In ordinary 2PC, a participant that has prepared and voted yes can remain in
doubt after coordinator loss. Timeout does not authorize an independent commit
or abort. Recover the durable decision through the supported protocol. Replicating
coordinator state with consensus improves decision availability, but commit still
requires a yes vote from every transaction participant. A majority of participants
is not a substitute, and participant recovery and durable prepared state remain
part of the protocol.

During a partition, specify which operations wait or fail to preserve their
guarantee and which may serve stale or conflicting state. CAP does not select a
complete architecture or explain ordinary queueing, fail-slow behavior, or
recovery costs.

## Resolve Uncertain Outcomes

Preserve one logical operation identity across retries. Correlate downstream work
to that root, with distinct stable identities for different effects when one
operation legitimately causes several. Scope deduplication by the relevant
tenant, operation, and destination; a trace ID alone is not an effect contract.
Use the retry budgets and payload-mismatch controls in
[05-distributed-communication.md](05-distributed-communication.md).

| Available evidence | Interpretation | Next action |
| --- | --- | --- |
| Authoritative completed result for the operation | The defined effect completed, even if the response was lost | Return or reconcile the result and handle late completion |
| Authoritative rejection/abort that excludes a remaining effect | The operation did not produce that effect | Apply the documented rejection or retry policy |
| Timeout, disconnect, cancellation request, or worker disappearance | Nonexecution, pending execution, and completed execution remain possible | Query/reconcile by identity, or repeat the same operation only under a valid idempotency contract |
| Missing or expired operation record | Absence may reflect retention, lag, or restore | Establish what absence proves; preserve uncertainty if it cannot exclude an earlier effect |

An in-progress record needs a recovery rule. A crash must not leave work
permanently pending, and a replacement must not assume the external effect never
started. Assign an owner and a bounded path to lookup, resume, reconcile, or
explicitly resolve the remaining uncertainty.

For broker-to-database processing, one useful boundary is a durable unique message
identity committed with domain writes in the same local transaction, followed by
broker acknowledgment. A crash after commit can then cause redelivery without
another domain mutation. An application check followed by a separately committed
insert does not supply the same atomic exclusion.

A payment, email, or other external call remains outside that transaction unless
it actually participates in the atomic protocol. Identify the provider's
idempotency/status capability, scope, payload rules, and lifetime. A local “sent”
flag cannot resolve a remote effect after response loss.

An authoritative lookup is useful when available, but is not a mandatory prelude
to a retry already protected by the destination's idempotency contract. If an
effect cannot be safely repeated or queried, stop blind resubmission and preserve
an explicit reconciliation path. Compensation is a new business action with its
own possible failure; it cannot erase every consequence of the original action.

## Enforce Resource-Side Fencing

A lease can expire while its holder is paused. The old holder can resume, or an
earlier request can arrive after a successor starts. Checking a lease before
sending a request leaves this race open.

When fencing supplies the protection:

1. Define the protected object, shard, tenant, or resource scope and the authority that issues monotonically increasing epochs.
2. Preserve issuance state across restart and authority changes; a restored counter must not reuse authority that an old request can still present.
3. Attach the epoch to every protected mutation. Each resource must atomically validate accepted authority and perform the mutation.
4. Reject lower epochs. Handle equal-epoch operations through their normal ordering and idempotency contract; fencing does not deduplicate the current holder's work.
5. Establish the successor's fence at every resource covered by the handoff before relying on exclusive ownership there.
6. Preserve accepted epochs through resource recovery. If restore can rewind them, block affected writes until the recovery protocol excludes old authority.

Issuing a newer token alone does not install a fence at a resource. An old request
may still be accepted before the resource observes the higher epoch; the handoff
must account for work accepted during that interval. Include administrative and
background mutation paths in the enforcement scope.

Fencing several resources does not make their changes one atomic transaction.
Partial installation needs an explicit transition/recovery state. A lock service
returning a token is insufficient if the destination ignores it or checks it
separately from the write.

Where a destination cannot validate epochs, identify another enforceable
conditional-write or isolation mechanism if stale-writer exclusion is required.
Idempotency can suppress repeats of the same effect but does not stop a stale
owner from issuing a different effect. If only reconciliation is feasible, state
the weaker guarantee. Power or network isolation may help under stated assumptions
but cannot retract already accepted work or automatically neutralize delayed
requests.

Useful evidence includes issued epoch, resource-side accepted epoch, request
identity, and observed mutation. Exercise an old delayed request after installing
the new fence, including restart or restore where those failures are in scope.

## Review Quorum And Authority Transitions

The inequality `r + w > n` establishes set intersection when the counted read
and write sets come from the same membership of `n` nodes. It does not establish
which version is retained, selected, or subsequently observed.

Check the actual read/write protocol against:

- Membership disagreement, sloppy quorums, or replacement nodes outside the assumed sets.
- Concurrent and partially successful writes, including an operation reported as failed that later becomes visible.
- Recovery from stale state that loses a version relied on by the overlap argument.
- Conflict/version rules that discard accepted writes or rely on unjustified wall-clock order.
- Read paths that can return a newer version and later an older one.

Consensus protocols supply authority and history rules beyond replica counting:
required election/proposal intersections, durable protocol state, and preservation
of confirmed history across terms. Majority is a common construction for
crash-fault systems; the necessary intersections and liveness assumptions belong
to the specific protocol. These rules protect the replicated state, not arbitrary
effects emitted by a process that once held leadership.

For a leader change, establish:

1. What acknowledgment meant and which confirmed history must survive.
2. Why the candidate is eligible to preserve that history.
3. How stale requests are excluded from protected mutations.
4. How routing changes without treating discovery information as write authority.
5. Whether surviving capacity can absorb failover, retries, catch-up, and recovery.
6. How the old node returns without reintroducing discarded or conflicting state.

If no eligible history survives, faster promotion cannot repair the missing
guarantee. Describe an unsafe recovery choice as a changed data-loss/integrity
contract with a decision owner. Reconcile downstream effects that still reflect
discarded history.

Membership changes are part of the safety protocol. Ad hoc replacement of voter
lists can create disjoint valid authorities. Obtain the chosen implementation's
supported transition and recovery procedure rather than inventing one from quorum
arithmetic.

A linearizable read needs evidence of current authority and sufficient state.
Neither “every read must append and fsync” nor “the leader can always read local
state” follows from the label. Read-index, lease, follower-read, and safe-timestamp
optimizations require their actual protocol, clock, and version assumptions.

Failure detection also affects capacity. Compare election/rebalance activity with
queueing, pause duration, link health, and retry load before treating a slow node
as dead. Adjust detection and movement policies from that evidence; simply
raising every timeout can delay necessary recovery.

## Preserve Ordering And Replayability

Name the required order and scope: conflict key, partition, causal dependencies,
or global history. Wall timestamps and sortable IDs do not establish causal or
real-time order by themselves. Use a local monotonic clock for elapsed duration;
cross-host order needs its own mechanism.

For a replayable view or workflow:

1. Identify a usable source snapshot and corresponding log position, including positions per partition where no single global position exists.
2. Preserve the order required by the invariant through retries, parallel processing, failover, and backfill/live overlap.
3. Retain required facts, schemas, code/configuration, and historical reference values or versions. State whether replay reproduces an old derivation or intentionally computes a new one.
4. Relate consumer position to the earliest retained input, allowing for outage, rebuild, and catch-up time. If required history is gone, declare the gap and use a valid reseed/rebuild path; silently advancing an offset does not repair it.
5. State which input progress, processing state, and outputs commit or recover together. Give effects outside that boundary durable identity and a separate replay policy.
6. Build a new view alongside the serving version where practical, isolate external effects during comparison, catch up, validate, and switch through an explicit publication boundary.
7. Retire old versions only after rollback, retention, and deletion obligations permit it.

Deduplication records must cover the promised retry and effectful replay horizon,
or older replay needs another strategy that cannot repeat accepted effects.
Restoring application state while losing deduplication state can invalidate an
otherwise sound handler.

A compacted log may reconstruct current values when records, tombstones, and
retention support it; it need not retain historical intent. Replay can fail because
a historical join input was discarded or today's reference value was substituted.
When results depend on event time, preserve that interpretation and the late-data
policy rather than silently substituting replay processing time. Window/operator
implementation belongs to `$data-engineering`.

For CDC, check whether stalled or abandoned consumers retain source logs and
consume source storage in the selected implementation. Define an owned recovery
or reseed response. Exact connector, retention, transaction-marker, and DDL
behavior requires current implementation evidence.

System design sets these source, effect, and visibility obligations.
`$data-engineering` implements and maintains transformation, replay, and
publication; `$database-engineering` supplies source-transaction and physical
recovery evidence.

## Select Diagnostic And Recovery Evidence

Distinguish timeliness from integrity. A delayed view may recover by catching up;
waiting does not repair lost, duplicated, or wrongly derived facts. Either can
be critical depending on the user consequence.

| Symptom | Discriminating evidence | Correction and acceptance evidence |
| --- | --- | --- |
| Confirmed write disappears after failover | Acknowledgment history, candidate history, membership/epoch, affected downstream IDs | Correct promotion/recovery assumptions; demonstrate promised history survives relevant failover/failback and reconcile effects on discarded history |
| Old worker mutates after lease expiry | Pause/request timeline and resource-side accepted epochs | Enforce the fence at the effect boundary; demonstrate rejection of delayed old requests after reassignment and relevant restarts |
| Retry duplicates an external effect | Operation/effect IDs, provider acceptance, deduplication scope/lifetime, restore history | Reconcile the outcome and repair the actual exclusion/retry boundary; verify completed and uncertain attempts recover distinctly |
| Transaction hangs | Lock waits/deadlocks versus prepared state and a missing durable decision | Use engine-specific lock/isolation diagnosis or recover the 2PC decision; do not invent abort from timeout |
| Replay changes state | Exact input range, snapshot/positions, order, derivation/configuration, historical lookups, concurrent writers | Correct identified drift and rebuild a separate version; compare domain invariants and ensure repair survives replay |
| Job succeeds but readers see mixed versions | Output version/readiness and reader/cache routing | Repair publication and verify readers see the promised complete or incremental state |
| Service is available but recovery is incomplete | Outstanding operation IDs, source/view differences, deletion lineage, active authority, policy versions | Reconcile incomplete effects and restore intended authority; check stale writers and revoked access alongside legitimate operations |

For an integrity incident, contain destructive propagation as the impact warrants
and preserve enough evidence to identify the source operation and affected
outputs. Correct the authoritative fact or derivation. A sink-only patch that
vanishes on replay leaves a hidden fork; if direct repair is necessary, make it
an owned correction that future reconstruction preserves. Compare the repaired
version before changing readers, and reconcile external effects separately.
Operational incident coordination belongs to `$sre-reliability-engineering`.

Use the smallest evidence method that resolves the claim. A concurrent history
can expose an isolation anomaly; fault injection can expose a recovery race;
recomputation can reveal a derivation defect; and restore rehearsal can exercise
retained state and dependency order. Equal record counts or healthy processes
do not establish correct effects.

Formal models check abstractions, history checkers evaluate recorded behavior,
and deterministic simulation or fault injection exercises selected schedules and
faults. None alone establishes every implementation, storage, external-effect,
or business guarantee. State the checked boundary and remaining assumptions.
Likewise, a tamper-evident log does not establish that truthful or correct
transactions entered it.

## Source Foundations And Implementation Limits

- *Designing Data-Intensive Applications*, second edition, chapters 5–10: encoding, replication, sharding, transactions, partial failure, clocks, consistency, and consensus.
- *Designing Data-Intensive Applications*, second edition, chapters 11–13: batch/stream processing, CDC, event sourcing, replay, end-to-end identity, and auditability.
- *Architecture Patterns with Python*: aggregates, Unit of Work, message bus, and cross-aggregate workflows.
- *Infrastructure as Code*, third edition: architecture/decomposition and live-change transitions.
- Node.js documentation, “Don't Block the Event Loop (or the Worker Pool)” and “Worker threads”: bounded runtime work and worker lifecycle boundaries.
- *SRE: «Коллективный разум»*: dependency models and recovery independence.
- *Building Secure and Reliable Systems*, chapters 8–9 and 18: resilience, recovery dependencies, protected state, and trustworthy recovery.
- *Security Engineering*, third edition: effective authority and recovery from a surviving basis.

These foundations support architectural reasoning and the derived checks above.
They do not supply complete current implementation recipes for isolation levels,
fencing APIs, membership transitions, optimized reads, broker guarantees, CDC,
serialization behavior, migration locking, or security-state recovery.

Refresh the affected primary implementation evidence when a product/version,
writer, consumer, intermediary, topology, failure domain, retention rule, or
restore mechanism changes an assumption. Keep applicable configuration and
failure limits near the mechanism; avoid universal timeout, quorum-size,
retention, shard-count, or recovery constants.
