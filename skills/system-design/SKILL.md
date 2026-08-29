---
name: system-design
description: Use when designing, reviewing, validating, documenting, or evolving classical software systems and distributed service architecture. Trigger for architecture and design docs, requirements and capacity estimates, API and data contracts, service boundaries, storage and consistency, caching, queues and streams, replication and sharding, scalability, reliability, security, multi-region design, migrations, production readiness, or system design interviews.
---

# System Design

Design systems from requirements and failure behavior, not from a preferred stack. The result must explain what is being built, why each major component exists, what guarantees it provides, how it fails, how it is operated, and how it can change safely.

## Core Rules

- Start with critical user journeys, invariants, constraints, workload, and ownership.
- Separate known facts, estimates, assumptions, and decisions. Never invent traffic, latency, availability, retention, or budget numbers.
- Prefer the simplest architecture that satisfies the stated requirements. Add distribution only when a concrete limit or ownership boundary justifies it.
- Trace data and failure semantics end to end. A box-and-arrow diagram without contracts, state, and failure behavior is incomplete.
- Treat reliability, security, operability, migration, and cost as design inputs, not launch-time additions.
- Make tradeoffs explicit. State the benefit, cost, failure mode, rejected alternatives, and evidence that would change the decision.
- Preserve future changeability through clear contracts, compatibility plans, tests, documentation, staged rollout, rollback, and ownership.

## Boundaries

This skill owns classical service and distributed-system architecture. Use
`$ml-system-design` for a predictive or classical ML lifecycle and
`$computer-vision-system-design` for computer vision products and perception
pipelines. Use `$llm-system-design` for composition of an LLM product. Those skills
may call this one for storage, queues, APIs, tenancy, capacity, and service
reliability, but model, prompt, sensor, or perception-stage decisions are not owned
here.

For a selected architecture's codebase lifecycle, migration, and delivery controls,
use `$software-engineering`; for verification strategy use `$qa-testing`; for SLOs,
observability, incident response, and operational reliability use
`$sre-reliability-engineering`. This skill remains the owner of component and
data-flow topology, contracts, invariants, and capacity tradeoffs.

## Reference Routing

Read only the references needed for the current task.

- Start with [references/01-operating-model.md](references/01-operating-model.md) for every broad design or review.
- For problem framing, requirements, assumptions, SLOs, and capacity estimates, read [references/02-requirements-and-capacity.md](references/02-requirements-and-capacity.md).
- For system boundaries, monolith or service decisions, APIs, events, and compatibility, read [references/03-boundaries-and-contracts.md](references/03-boundaries-and-contracts.md).
- For data models, storage, indexes, transactions, consistency, replication, and sharding, read [references/04-data-and-consistency.md](references/04-data-and-consistency.md).
- For synchronous calls, queues, streams, delivery guarantees, retries, coordination, and backpressure, read [references/05-distributed-communication.md](references/05-distributed-communication.md).
- For throughput, latency, caching, load distribution, hot spots, and cost, read [references/06-scalability-performance-cost.md](references/06-scalability-performance-cost.md).
- For SLOs, dependency failure, graceful degradation, recovery, and regional strategy, read [references/07-reliability-and-recovery.md](references/07-reliability-and-recovery.md).
- For trust boundaries, authorization, isolation, privacy, abuse, and secrets, read [references/08-security-and-multitenancy.md](references/08-security-and-multitenancy.md).
- For telemetry, alerting, release safety, runbooks, and launch readiness, read [references/09-operability-and-production-readiness.md](references/09-operability-and-production-readiness.md).
- For maintainability, dependencies, testing, migrations, deprecation, and ownership, read [references/10-evolution-and-maintainability.md](references/10-evolution-and-maintainability.md).
- For fast technology-neutral choices, read [references/11-pattern-selection.md](references/11-pattern-selection.md).
- For design-doc and review output structures, read [references/12-templates-and-review-checklists.md](references/12-templates-and-review-checklists.md).

## Workflow

1. Classify the task: new design, design review, option comparison, migration, production-readiness review, or interview exercise.
2. Inspect provided code, docs, schemas, dashboards, deployment configuration, and contracts before proposing changes.
3. Frame the problem and quantify the workload. If inputs are missing, provide formulas or ranges and mark assumptions.
4. Define invariants, source-of-truth ownership, public contracts, consistency needs, and critical paths.
5. Produce a minimal viable architecture, then pressure-test it against scale, failures, security, operations, migration, and cost.
6. Compare meaningful alternatives. Do not list options without a decision criterion or recommendation.
7. Validate the design with focused tests, benchmarks, failure drills, canaries, migration rehearsals, or prototypes proportional to risk.
8. End with risks, unresolved decisions, owners or owner gaps, and the evidence needed next.

## Output For A New Design

Include, at the level justified by the request:

- Problem statement, users, critical journeys, goals, and non-goals.
- Functional requirements, invariants, constraints, assumptions, and compliance needs.
- Workload and capacity estimates with formulas, units, peak factors, and uncertainty.
- SLO or performance targets and how they will be measured.
- API, event, and data contracts; ownership and compatibility expectations.
- High-level architecture and critical read, write, and failure flows.
- Storage, indexing, consistency, transaction, replication, and partitioning choices.
- Scalability, caching, asynchronous processing, and backpressure strategy.
- Dependency map, failure modes, degradation, recovery, and rollback.
- Security boundaries, authorization, tenant isolation, privacy, and abuse controls.
- Observability, alerting, release, runbook, on-call, and launch plan.
- Migration and evolution plan, alternatives, tradeoffs, risks, and open questions.

Use a diagram when topology or sequence matters, but accompany it with contracts and guarantees. Match the user's language and requested depth.

## Output For A Review

Lead with findings ordered by severity. For each finding state:

- The violated requirement, invariant, or unstated assumption.
- The user or business impact and likely failure mode.
- The affected path, component, dependency, or data contract.
- A concrete correction and how to validate it.

Then summarize missing decisions, viable alternatives, migration concerns, and residual risks. Do not rewrite the entire design when a focused review is requested.

## Quality Bar

- Do not recommend microservices, event-driven architecture, a cache, a queue, a specific database category, sharding, or multiple regions without a requirement that pays for the complexity.
- Do not claim horizontal scalability without addressing state, partition keys, coordination, hot spots, and downstream limits.
- Do not claim reliable retries without deadlines, backoff, jitter, attempt limits, idempotency, and overload behavior.
- Do not claim safe asynchronous processing without delivery, ordering, deduplication, poison-message, lag, and replay semantics.
- Do not use eventual consistency as a complete answer; define acceptable staleness, conflict behavior, and user-visible consequences.
- Do not propose dual writes without an atomicity, reconciliation, and recovery strategy.
- Do not call a system production-ready without ownership, observability, actionable alerts, rollback or fallback, capacity evidence, and recovery validation.
- Do not present a vendor or framework as current best practice without checking its current status when the choice would create material cost or lock-in.
