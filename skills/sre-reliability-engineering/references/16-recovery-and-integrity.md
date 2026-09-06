# Recovery, integrity, and trustworthy authority

Use this reference when serving has resumed but correctness or authority remains
uncertain, overload persists after demand falls, derived data is stale or corrupt,
or recovery depends on the failed layer. Incident coordination stays in
[07-incident-management.md](07-incident-management.md); this reference supplies
the evidence and recovery decisions.

## Establish the recovery contract

State the affected journey and distinguish availability, timeliness, persistent
integrity, and authorization failures. Identify the source of truth, operation
IDs, responsible writers, serving replicas, relevant epochs/versions, and recent
changes. Record observations separately from suspected causes.

Select a bounded mitigation with an owner, expected effect, transferred risk,
abort condition, and exit criterion. Preserve evidence needed to reconcile state.
A timeout proves neither nonexecution nor failure of the remote process. Use
authoritative reconciliation by operation identity, or retry under an established
destination-enforced idempotency contract. Protected replay preserves the same
logical identity and payload within the contract's scope and deduplication
lifetime, deadline, and retry limits; it does not require a preceding authoritative
lookup. If neither route is safe, stop blind resubmission and route to the recovery
owner. Keep dependent work blocked until its required outcome is established.

## Distinguish the failure mechanism

| Signal | Evidence that separates causes | Action and recovery proof |
| --- | --- | --- |
| p50 stable, p99 rising | Client latency, queue age, fan-out tails, GC, per-replica and per-tenant distributions | Address the delayed or saturated stage; verify tail recovery under representative demand |
| Overload continues after external demand falls | Original demand versus attempts, retries per operation, queue age, timeouts, expired work, and downstream saturation | Bound retries/admission, shed work according to policy, or reset only the affected state when justified; verify useful completions recover and feedback does not return |
| Throughput falls at similar input | Compaction, vacuum, rebuild, shuffle, spill, CPU/IO contention, and maintenance timeline | Pause or throttle competing work with its owner; verify serving and required maintenance can coexist |
| Consumer lag approaches retention | Per-partition position, oldest unread age, retained horizon, source-log retention, and checkpoint | Restore sustainable processing or arrange an owned reseed; prove required history remains available |
| Lag already exceeds retained history | Missing offset range, authoritative snapshot, compatible bootstrap/log cut | Stop claiming replay completeness; rebuild through the data owner's snapshot-and-log procedure and compare outputs |
| Fresh-looking output violates domain invariants | Source facts, derivation version, publication marker, reader routing, operation IDs, and external effects | Contain corrupt propagation, correct the source/derivation, rebuild separately, and validate invariants before switching readers |
| Writes vanish or two writers remain after failover | Acknowledged history, old/new log prefixes, candidate freshness, epochs, and resource-side fencing | Involve database/system owners; establish valid authority and reconcile discarded-history effects before normal writes |
| A green job or busy device makes little useful progress | Completed valid work, queue/state waits, per-rank/replica tails, checkpoint/recovery time, and input progress | Route the constrained stage to runtime, training, storage, or platform ownership; verify productive work rather than allocation alone |
| Model endpoint is healthy but outcomes deteriorate | Model/data/policy/runtime versions, feature freshness, slice outcomes, known-good comparison, and common dependency changes | Contain within the agreed fallback envelope and involve the model/data owner; verify semantic recovery using their criteria |

Overload can become metastable: retries and accumulated work consume enough
capacity to sustain the failure after the original trigger ends. Adding replicas
may help only if startup, routing, and the downstream bottleneck permit it.
Measure original demand, attempted work, and successful useful work separately.
Use backoff, jitter, retry budgets, and admission limits as a coordinated contract;
avoid blind retries at every layer.

A gray failure may affect one replica, device, link, or cohort while aggregate
health stays green. Compare affected and unaffected populations and locate the
first delayed or invalid stage. Quarantine or reroute only within authorized
capacity and recovery constraints. A statistical drift alert does not authorize
automatic retraining or changing model-quality thresholds.

## Recover integrity as well as timeliness

1. Contain destructive propagation or unsafe publication while preserving the
   observations needed to determine impact.
2. Find authoritative facts, operation IDs, ordering, and the exact
   snapshot/checkpoint/derivation versions. Do not silently promote a derived view
   to the source of truth.
3. Reconcile external effects by stable identity. Replaying a charge, notification,
   or write without deduplication can create a second incident.
4. Have the domain owner correct the source fact or transformation. Record direct
   repairs so they survive replay; a sink-only patch may be overwritten.
5. Rebuild or restore alongside the old view where feasible. Compare domain
   invariants, coverage, versions, freshness, and duplicate/missing effects.
6. Restore readers and writers gradually under the established authority and
   compatibility contract. Verify deletion, revocation, and access restrictions
   have not regressed through old snapshots or caches.
7. Record remaining uncertainty and affected outcomes. Serving restoration,
   integrity verification, and completion of preventive work are separate states.

Database owners prove engine recovery and transaction history; data owners prove
replay, derivation, and publication; model owners prove semantic quality. SRE
coordinates the response and judges the resulting user-reliability behavior.

## Prove recovery-path independence

List the dependencies needed to recover each critical layer: identity and
credential issuance, DNS/networking, control plane, registry/artifacts, backups,
runbooks, consoles, observability, and communication. Trace bootstrap order, not
only normal serving calls.

For each assumed failure, identify which copy, credential, operator, and tool
remains usable without that layer. A backup hosted elsewhere may still depend on
the same identity or compromised administrator. A local runbook is useful only
if its commands, credentials, and required artifacts are also reachable.

Use a tabletop first when it can reveal a circular dependency. For consequential
claims, arrange an authorized bounded exercise that uses the surviving access
path, retrieves the needed artifact, restores representative state, and validates
the journey. Include responder access and recovery capacity in the resource
budget. Record which dependencies were actually unavailable versus merely assumed.

System design owns bootstrap/topology changes; platform owns their implementation.
SRE specifies the failure scenario and accepts the operated recovery evidence.
Do not declare every runtime dependency cycle invalid: the question is whether
the recovery sequence has a usable independent starting point.

## Restore trustworthy authority

After an ordinary outage, validate that restored state still enforces current
permissions, revocations, anti-replay/deduplication state, writer epochs, and
compatible configuration. A rollback that revives an obsolete authorization
decision is incomplete recovery even when availability improves.

If evidence suggests compromise, involve the security incident owner and reassess
whether channels, devices, credentials, artifacts, and backups remain trustworthy.
Missing or altered evidence, hidden artifacts, and unexplained intentional-looking
actions justify that assessment; they do not prove an attacker. Preserve relevant
evidence before avoidable changes, and separate neutral stabilization from
need-to-know investigation so suspect systems or channels do not expose clean
credentials or recovery plans. Do not automatically undo human quarantine or reuse
potentially compromised capacity.

Agree the affected authority and containment scope. Revoke or rotate what the
incident requires, then verify old authority is rejected at actual enforcement
points; nominal credential replacement alone is insufficient. Restore from a
surviving trusted basis, validate installed code/configuration and protected state,
and check the suspected re-entry path. Do not assume backups or spare credentials
under the same compromise supply independent trust.

Track temporary access, bypasses, and recovery infrastructure with owners and
expiry. Remove them deliberately and verify normal policy, legitimate access,
monitoring, and escalation work afterward. If the recovery foundation itself is
untrusted, escalate that unresolved condition rather than declaring recovery.
An availability error budget does not permit spending confidentiality, integrity,
or authorization guarantees.

## Handoff and acceptance

Pass a concise record containing the affected population and journey, protected
invariant, authoritative state/version, observed versus suspected mechanism,
current mitigation and transferred risk, recovery prerequisites, acceptance
evidence, residual uncertainty, owner, and next decision.

For ML incidents, add the model/data/policy/runtime bundle and affected
replica/rank/device or cohort only when relevant. Shared serving or fleet
controllers belong to `$ai-platform-llmops`; execution diagnosis belongs to the
runtime or training specialist. SRE retains incident coordination and SLO judgment.

Use `$technical-writing` when the result needs a runbook or incident report.
Supply verified behavior and limits rather than asking writing to infer technical
truth. Keep access, freshness, and operational acceptance with the engineering
owners.

## Sources and refresh limits

- *SRE: Коллективный разум*: dependency reliability, control-plane recovery,
  planned-work recovery, and fleet external-request budgets.
- *Designing Data-Intensive Applications*, second edition: distributed failures,
  replication/failover, stream processing, and integrity/reprocessing mechanisms.
- *Machine Learning Systems*, Volume II: fault tolerance, serving overload,
  productive progress, gray failures, and operational handoffs.
- *Building Secure and Reliable Systems*, Chapters 8–9 and 15–18: bounded
  degradation, recovery state, investigability, incident response, and recovery.
- *Security Engineering*, third edition, and OWASP ASVS 5.0.0: response and
  recovery distinctions, restored authorization, and protected state. These
  principles do not establish complete ASVS conformance or a universal revocation
  procedure.

These sources establish mechanisms, not current engine commands, runtime APIs,
controller timing, or universal recovery constants. Refresh the applicable
implementation evidence after changes to failure domains, identity, control
planes, retention, artifact/state compatibility, or repeated incidents.
