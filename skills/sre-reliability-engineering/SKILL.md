---
name: sre-reliability-engineering
description: Use when designing, reviewing, validating, debugging, operating, or improving production systems through SRE and reliability engineering practices. Trigger for SLO/SLI/SLA, error budgets, observability, monitoring, logs, traces, alerting, incident management, postmortems, on-call, reliability architecture, Kubernetes reliability, chaos/load testing, toil automation, business reliability tradeoffs, production-readiness reviews, and long-term service ownership.
---

# SRE Reliability Engineering

Use this skill to design or review production systems through SRE practices. Treat reliability as a managed business and engineering risk: define what users need, measure it with SLI/SLO, budget risk with error budgets, build observability and response loops, and design systems to degrade and recover intentionally.

## Core Rule

Do not start from tools. First clarify user journeys, ownership, SLO/SLI, error budget, business impact, dependencies, failure modes, rollback/fallback, observability, on-call readiness, and post-incident learning.

## Reference Routing

Read only the references needed for the current task.

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
- For Kubernetes resources, runtime limits, probes, graceful shutdown, PDB/HPA, and Helm anti-patterns, read `references/11-kubernetes-reliability.md`.
- For load/stress testing, chaos experiments, probers, Game Days, and production chaos guardrails, read `references/12-chaos-load-testing.md`.
- For toil, runbooks, automation, self-service, and automation reliability, read `references/13-toil-automation.md`.
- For business reliability, culture, local context, burnout, communication, and war-story patterns, read `references/14-business-culture-war-stories.md`.
- For tools, SLO tooling, observability stack choices, glossary, and current-status guardrails, read `references/15-tools-glossary.md`.

## Workflow

1. Classify the request:
   - New system design: read `sre-agent-operating-model`, then `01`, `02`, `03`, `04`, `06`, `10`, and topic-specific files.
   - Production-readiness review: read `02`, `03`, `04`, `05`, `06`, `10`, `11`, `13`.
   - SLO or alerting design: read `02`, `03`, `04`, `06`.
   - Observability design or debugging: read `04`, `05`, `06`, then `07` if incident response is involved.
   - Incident support: read `07`, then `04`, `05`, `06`, and affected architecture references.
   - Postmortem work: read `08`, then `07`, `10`, `13`, and `14` as needed.
   - On-call process: read `09`, `06`, `07`, and `13`.
   - Kubernetes reliability: read `11`, plus `10`, `04`, and `12` for validation.
   - Chaos/load testing: read `12`, plus `10`, `04`, `06`, and `07`.
   - Tool recommendation: read `15` and clearly distinguish reference guidance from current tool status.
2. Identify blocking unknowns. Ask only when the missing data changes the decision; otherwise state assumptions.
3. Tie recommendations to user impact, SLO/error budget, blast radius, owner, validation, rollback, and operational follow-through.
4. Avoid absolute advice where the references describe tradeoffs or maturity prerequisites.
5. Mark any ideas not grounded in the references as `external extension` if you add them.

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
6. Learning: postmortem and action items after stabilization.

## Quality Bar

- Do not call a system reliable without SLOs, observability, actionable alerts, rollback/fallback, and ownership.
- Prefer SLO/burn-rate alerts over raw resource pages unless resource symptoms directly threaten user impact.
- Treat postmortems without owner/deadline/action items as incomplete.
- Treat repeated runbooks and manual fixes as toil candidates.
- Require production chaos and load tests to have blast-radius limits, abort conditions, observability, and error-budget headroom.
- When recommending tools, check current project status before presenting them as current best choices.
