---
name: "sre-reliability-engineering"
description: "Define and operate user reliability through SLIs/SLOs, error budgets, observability, alerting, incidents, on-call, recovery, Kubernetes reliability, and resilience validation. Use for production-readiness and reliability decisions; infrastructure provisioning and reconciliation belong to platform engineering."
---

# SRE Reliability Engineering

Use this skill to design or review production systems through SRE practices. Treat reliability as a managed business and engineering risk: define what users need, measure it with SLI/SLO, budget risk with error budgets, build observability and response loops, and design systems to degrade and recover intentionally.

## Core Rule

Start with the user's unresolved reliability decision and the affected journey. Establish the relevant measurement, owner, failure mechanism, action, and recovery evidence. For a narrow task, use only the necessary parts of the broader SRE operating loop.

## Hierarchy And Handoffs

This skill owns the operated reliability system after a product or service exists:
user-facing SLOs, error budgets, observability, alerting, incident response, on-call,
and resilience validation. Use `$system-design` first when component topology, data
flow, service contracts, or capacity choices are still open; bring this skill in to
make the selected design measurable and recoverable in production.

Use `$software-engineering` for codebase and delivery-process health, and
`$qa-testing` for classic pre-release verification. Neither replaces production
signals, error-budget policy, or incident ownership.

Use `$platform-devops-engineering` for infrastructure configuration, apply, and
reconciliation. SRE retains runtime diagnosis, user-impact probes, capacity and
degradation checks, and operational acceptance. Pass candidate/configuration/state
identity, observed behavior, rollback constraints, abort criteria, and owner.
Routine red-mainline restoration stays with software/release engineering unless
production impact establishes an incident.

For integrity or semantic failures, coordinate with `$database-engineering`,
`$data-engineering`, or the relevant ML/model owner. They define and repair domain
invariants; SRE coordinates containment and verifies operated recovery. Use
`$application-security-engineering` for affected authority and security controls,
and `$security-review` when independent assurance is needed. Availability recovery
does not by itself establish restored authorization or data integrity.

Use `$technical-writing` to shape a runbook, incident report, or operational
document. Supply verified behavior, preconditions, state and authority boundaries,
failure evidence, version limits, access requirements, and escalation ownership.
SRE retains factual ownership and freshness; writing alone needs no additional
engineering workflow.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- Always start with `references/sre-agent-operating-model.md` for broad SRE design, review, incident, or production-readiness work.
- For SRE basics, responsibility boundaries, and operating principles, read `references/01-sre-foundations.md`.
- For SLA/SLO/SLI, CUJ, composite SLO, and SLI implementation choices, read `references/02-slo-sli-sla.md`.
- For error budgets, burn rate, release policy, and reliability tradeoffs, read `references/03-error-budget.md`.
- For RED/USE metrics, dashboards, dependency metrics, queues, and whitebox/blackbox monitoring, read `references/04-monitoring.md`.
- For structured logs, traces, OpenTelemetry, sampling, exemplars, and retention, read `references/05-logs-traces.md`.
- For page/ticket alerting, multi-window burn-rate alerts, Alertmanager, silence, and signal/noise, read `references/06-alerting.md`.
- For incident lifecycle, roles, debug docs, planned work, and diagnosis, read `references/07-incident-management.md`.
- For blameless postmortems, action items, follow-through, and learning loops, read `references/08-postmortems.md`.
- For on-call rotations, escalation, compensation, handoff, fatigue, and on-call metrics, read `references/09-oncall.md`.
- For distributed-system failure assumptions, hard/soft dependencies, composite reliability, graceful degradation, and load shedding, read `references/10-reliability-architecture.md`.
- For integrity incidents, lag and retry feedback, gray failures, independent recovery paths, and restoration of trusted authority, read `references/16-recovery-and-integrity.md`.
- For Kubernetes resources, runtime limits, probes, graceful shutdown, PDB/HPA, and Helm anti-patterns, read `references/11-kubernetes-reliability.md`.
- For load/stress testing, chaos experiments, probers, Game Days, and production chaos guardrails, read `references/12-chaos-load-testing.md`.
- For toil, runbooks, automation, self-service, and automation reliability, read `references/13-toil-automation.md`.
- For business reliability, culture, local context, burnout, communication, and war-story patterns, read `references/14-business-culture-war-stories.md`.
- For tools, SLO tooling, observability stack choices, glossary, and current-status guardrails, read `references/15-tools-glossary.md`.

## Workflow

1. Select the reference for the immediate decision using the routing above. Expand to adjacent references only when evidence exposes a dependency; broad readiness work may need several.
2. Identify blocking unknowns. Ask only when the missing data changes the decision; otherwise state assumptions.
3. Tie recommendations to user impact, SLO/error budget, blast radius, owner, validation, rollback, and operational follow-through.
4. Avoid absolute advice where the references describe tradeoffs or maturity prerequisites.
5. Separate observations, hypotheses, derived calculations, and source-backed guidance. State quantitative assumptions and unresolved source defects where they affect the decision.

## Output For New System Design

Include:

- Critical user journeys and reliability goals.
- SLI/SLO proposal and assumptions.
- Error budget and release/risk policy.
- Dependency graph with hard/soft dependencies.
- Failure modes, blast radius, and graceful degradation plan.
- Monitoring, logs/traces, dashboard, and alerting plan.
- Rollback, fallback, and mitigation plan.
- On-call, runbooks, incident roles, and postmortem expectations.
- Validation through tests, load/stress, chaos, or drills.
- Ownership, toil/automation plan, risks, and open questions.

## Output For Review

Lead with risks and missing decisions:

- Critical production risks.
- Missing or weak SLO/SLI/error-budget decisions.
- Observability and alerting gaps.
- Dependency, timeout, retry, circuit-breaker, fallback, and rollback risks.
- Kubernetes/runtime/probe/shutdown risks when relevant.
- Incident/on-call/postmortem/toil gaps.
- Concrete fixes, validation steps, and owner assumptions.

## Output For Incident Support

Prioritize:

1. Safety: avoid worsening the incident.
2. Impact: define affected users, journeys, SLOs, and business effect.
3. Mitigation: rollback, failover, throttling, feature disable, fallback, load shedding.
4. Coordination: IC/Ops/Comms, debug doc, timeline, decision log.
5. Diagnosis: hypotheses by recent changes, dependencies, resources, traffic, data.
6. Recovery: verify user outcomes, protected state, and trustworthy authority before declaring restoration complete.
7. Learning: postmortem and action items after stabilization.

## Quality Bar

- Do not call a system reliable without SLOs, observability, actionable alerts, rollback/fallback, and ownership.
- Prefer SLO/burn-rate alerts over raw resource pages unless resource symptoms directly threaten user impact.
- Treat postmortems without owner/deadline/action items as incomplete.
- Treat repeated runbooks and manual fixes as toil candidates.
- Validate the measuring system before using its error budget for policy decisions.
- Name the authority, scope, expiry, and exit condition for exceptions and temporary mitigations.
- Treat numerical thresholds and drill schedules as local decisions supported by workload and risk evidence.
- Require production chaos and load tests to have blast-radius limits, abort conditions, observability, and error-budget headroom.
- When recommending tools, check current project status before presenting them as current best choices.
