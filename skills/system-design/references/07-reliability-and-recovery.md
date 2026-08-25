# Reliability And Recovery

## Define Reliability From User Outcomes

For each critical journey define:

- What counts as a good event.
- Availability, latency, quality, and freshness indicators as needed.
- Target and measurement window.
- Error budget and the release or risk policy it changes.
- Owner and escalation path.

Do not maximize reliability blindly. Match it to business impact and the cost of additional redundancy and operation.

## Dependency And Failure Analysis

Build a dependency graph including DNS, identity, certificates, configuration, control planes, networks, queues, databases, external providers, and observability.

Classify each dependency:

- `hard`: the journey cannot complete without it;
- `soft`: the journey can degrade or defer work;
- `control-plane`: needed for change or recovery but perhaps not steady-state traffic;
- `shared`: creates correlated blast radius across otherwise separate components.

For sequential hard dependencies, end-to-end availability is bounded by their combined reliability. Parallel replicas help only when failure modes are independent and failover works.

## Resilience Controls

- Deadlines and timeouts shorter than the user-visible deadline.
- Bounded retries with backoff, jitter, and idempotency.
- Circuit breaking or fail-fast behavior for a failing dependency.
- Bulkheads for pools, workers, queues, tenants, and priority classes.
- Admission control and load shedding before saturation causes collapse.
- Fallback, cached or stale response, reduced functionality, or deferred processing for soft dependencies.
- Health checks that distinguish process liveness, readiness, and meaningful user-path health.
- Graceful shutdown and draining during deploy or rescheduling.

Every fallback needs correctness, freshness, security, observability, and disablement rules. A hidden fallback that silently returns wrong data is not resilience.

## Redundancy And Failure Domains

- Place replicas across the failure domain the requirement names.
- Check shared dependencies, credentials, deploy pipelines, quotas, and operators for correlated failure.
- Size surviving capacity for failover and retry load.
- Test routing convergence and stale membership.
- Preserve isolation so one tenant, region, queue, or workload cannot exhaust all capacity.

## Recovery

Define:

- RTO: maximum acceptable time to restore the journey.
- RPO: maximum acceptable data-loss window.
- Backup scope, frequency, encryption, retention, and independence.
- Restore order for dependencies and derived data.
- Reconciliation after partial recovery.
- Failover and failback procedures.
- Communication, authority, and manual override.

Backups are not proven until a restore succeeds within the required time and the restored data passes integrity checks.

## Regional Strategy

Use one region when it meets availability, latency, residency, and disaster-recovery needs. Multiple regions add routing, replication, conflict, consistency, capacity, cost, and operational complexity.

Choose deliberately among:

- Backup and restore.
- Pilot light or warm standby.
- Active-passive traffic.
- Active-active reads with centralized writes.
- Active-active writes with domain-specific conflict handling.

State traffic failover trigger, data authority, split-brain prevention, capacity during failover, DNS or routing behavior, and return-to-primary plan.

## Validation Ladder

1. Unit and component failure tests.
2. Integration tests with dependency faults.
3. Load and stress tests to find saturation and recovery behavior.
4. Staging failover, restore, and migration rehearsals.
5. Bounded production drills with explicit hypothesis, owner, blast radius, abort conditions, observability, and error-budget headroom.

Turn findings into owned changes to code, configuration, dashboards, alerts, runbooks, or architecture.

## Review Questions

- Which failure causes the largest user impact?
- Can a soft dependency actually fail without losing the core journey?
- Can retries or failover overload the surviving dependency?
- Which supposedly independent replicas share a hidden dependency?
- Are RTO and RPO proven by drills?
- Can rollback, fallback, throttling, or failover be activated safely under incident pressure?
