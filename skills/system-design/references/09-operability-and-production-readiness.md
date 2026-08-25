# Operability And Production Readiness

## Observability From Decisions

Telemetry should answer:

1. Is a critical user journey failing or approaching its target?
2. Which operation, dependency, region, tenant, version, or resource contributes?
3. What changed recently?
4. What action can mitigate the impact?

Use complementary signals:

- Request-driven components: rate, errors, and duration.
- Resources and internal capacity: utilization, saturation, and errors.
- Queues and streams: arrival rate, processing rate, depth, lag, oldest-item age, retries, and dead letters.
- Dependencies: outbound rate, errors, duration, timeouts, circuit state, and quota.
- Data: replication lag, freshness, failed writes, reconciliation drift, and restore status.

## Logs And Traces

- Propagate a correlation or trace identity through synchronous and asynchronous paths.
- Use structured logs with stable fields and safe context.
- Record meaningful state transitions, dependency failures, and high-impact administrative actions.
- Include stack or causal error context without leaking secrets or unnecessary personal data.
- Use traces to connect user latency to downstream spans and queue processing.
- Define sampling and retention so rare errors and slow paths remain diagnosable within cost and privacy limits.
- Monitor the observability pipeline itself.

## Dashboards And Alerts

Use a hierarchy:

- Journey overview: target status, traffic, errors, latency, freshness, and recent changes.
- Service view: inbound and outbound signals, queues, resources, versions, and regions.
- Debug view: detailed dependencies, partitions, pools, logs, traces, and deploy annotations.

Page only when immediate human action is required to protect a user outcome or error budget. Route slower degradation and cleanup to tickets. Every page should include impact, owner, relevant target, dashboard, runbook, start time, and escalation.

Raw resource thresholds are diagnostic unless they reliably predict imminent user impact and require immediate action.

## Release Safety

- Keep changes small enough to attribute and reverse.
- Separate deployment from exposure with a feature control when risk justifies it.
- Use staged rollout or canary by instance, tenant, cohort, zone, or region.
- Define automated and human promotion criteria before rollout.
- Compare correctness, latency, errors, saturation, and business guardrails against a control.
- Keep schema and contract changes backward-compatible throughout the rollout window.
- Define rollback and roll-forward behavior, including what happens to data already written in the new shape.
- Remove stale flags, compatibility paths, and temporary capacity after success.

## Configuration And Runtime

- Version, review, validate, and test production configuration.
- Separate defaults from environment-specific values and secrets.
- Define resource requests, limits, connection pools, concurrency, and autoscaling assumptions.
- Expect process death, restart, rescheduling, and partial infrastructure failure.
- Keep persistent state outside replaceable process-local storage unless loss is explicitly acceptable.
- Implement graceful shutdown, traffic draining, readiness, and startup behavior.
- Document external quotas, certificates, DNS, identity, and control-plane dependencies.

## Operational Ownership

A production component needs:

- A named owning team and escalation path.
- SLO or explicit reliability expectation.
- Dashboards, actionable alerts, and dependency visibility.
- Runbooks for common mitigation, rollback, failover, and recovery.
- Access and permissions that work during an incident.
- Capacity and cost review.
- Incident and post-incident process.
- A plan to measure and reduce repeated manual work.

Automations are production systems too. Give them validation, logs, metrics, owner, failure handling, and rollback.

## Launch Readiness Gate

Before launch verify:

- Critical journeys and indicators are measurable from the user-visible boundary.
- Capacity is tested for expected peak, skew, cold cache, and a relevant failure domain.
- Backups and restores meet recovery targets.
- Dependencies have deadlines, safe retry behavior, and degradation plans.
- Security review covers trust boundaries, authorization, tenant isolation, and secrets.
- Dashboards, pages, tickets, runbooks, escalation, and access are exercised.
- Rollout, rollback, data migration, and cleanup are rehearsed.
- Known risks are accepted by an owner with a follow-up date.
