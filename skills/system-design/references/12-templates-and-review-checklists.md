# Templates And Review Checklists

## Design Document Template

Use only sections relevant to the system and decision.

### Context

- Problem and business outcome.
- Users and critical journeys.
- Current state and why change is needed.
- Owners and stakeholders.

### Requirements

- Functional requirements and invariants.
- Goals and non-goals.
- Availability, latency, throughput, freshness, durability, recovery, security, compliance, and cost targets.
- Facts, estimates, assumptions, and unresolved questions.

### Workload

- Average and peak traffic by operation.
- Payloads, read/write mix, concurrency, retention, growth, skew, and geography.
- Capacity arithmetic and safety margins.

### Contracts And Data

- APIs, events, schemas, error semantics, idempotency, and compatibility.
- Data model, source of truth, ownership, indexes, consistency, transactions, retention, and deletion.

### Architecture

- Context and component diagram.
- Critical read, write, asynchronous, and administrative flows.
- Component responsibilities and why each boundary exists.
- External, hard, soft, control-plane, and shared dependencies.

### Cross-Cutting Design

- Scalability, caching, partitioning, backpressure, and cost.
- Failure modes, degradation, redundancy, recovery, RTO, and RPO.
- Trust boundaries, authorization, isolation, privacy, and abuse controls.
- Telemetry, dashboards, alerts, runbooks, and on-call.

### Delivery And Evolution

- Alternatives and tradeoffs.
- Validation plan and acceptance criteria.
- Rollout, migration, compatibility, rollback, and cleanup.
- Risks, owner decisions, and evidence that would trigger redesign.

## Critical-Path Walkthrough

For every important flow record:

| Field | Question |
| --- | --- |
| Trigger | Who starts the flow and why? |
| Contract | What input, output, and errors are visible? |
| State | What is read or written, and who owns it? |
| Guarantee | What consistency, durability, ordering, and idempotency apply? |
| Deadline | How is latency budget divided? |
| Scale | What happens at peak, skew, and overload? |
| Failure | What if each hop is slow, down, duplicated, or partially complete? |
| Security | Where are identity, authorization, and tenant isolation enforced? |
| Operations | Which metric, trace, alert, runbook, and owner expose the flow? |
| Change | How can the contract or data shape migrate safely? |

## Review Checklist

### Requirements

- Critical journeys and invariants are explicit.
- Numbers have units, sources, uncertainty, and peak assumptions.
- Goals, non-goals, and accepted tradeoffs are clear.
- SLO, recovery, security, compliance, and cost targets have owners.

### Architecture

- Every component maps to a requirement or risk.
- Boundaries have ownership and independent value.
- Critical-path hop count and deadlines are credible.
- Hard, soft, shared, and control-plane dependencies are visible.
- The design avoids premature distribution and hidden single points of failure.

### Data And Messaging

- Source of truth and transaction owner are unambiguous.
- Access patterns justify storage and indexes.
- Consistency and staleness are user-visible definitions, not labels.
- Retries, duplicates, ordering, reconciliation, replay, and poison items are handled.
- Partition key, hot spots, rebalancing, retention, backup, restore, and deletion are covered.

### Scale And Reliability

- Downstream capacity, retry amplification, cold start, failover, and backfill load are included.
- Overload is bounded through admission, queues, quotas, or shedding.
- Degradation preserves the core journey without violating correctness or security.
- RTO and RPO are backed by a test plan.
- Correlated failure and surviving capacity are modeled.

### Security And Operations

- Trust boundaries, authorization, tenant isolation, secrets, and audit are explicit.
- Observability covers inbound, outbound, queues, state, saturation, and recent changes.
- Alerts are actionable and routed to an owner with a runbook.
- Rollout, rollback, failover, restore, and incident access are exercised.

### Evolution

- Public behavior and compatibility risk are recognized.
- Migration is staged, observable, resumable, and has cleanup.
- Dependencies and build inputs are owned and reproducible.
- Tests target the important boundaries and failure modes.
- Design docs, runbooks, and decisions have owners and freshness expectations.

## Review Finding Format

```text
[Severity] Short title

Risk: requirement or invariant at risk.
Failure mode: concrete scenario and user impact.
Evidence: relevant component, contract, data flow, or missing decision.
Recommendation: smallest effective correction.
Validation: test, metric, drill, benchmark, or migration proof.
Owner/open question: accountable team or unresolved decision.
```

Use severity for impact and urgency, not stylistic preference. Distinguish blockers from improvements and residual risk.

## Time-Boxed Interview Mode

When the task is an interview exercise:

1. Clarify scope and choose two or three critical requirements.
2. Estimate only the numbers that affect architecture.
3. Present a simple end-to-end design and walk one read and one write.
4. Deep-dive into the highest-risk area requested by the interviewer.
5. Discuss scale, failure, consistency, security, operations, and tradeoffs.
6. End with bottlenecks, alternatives, and what would change at the next order of magnitude.

Do not turn an interview answer into an exhaustive production document; demonstrate prioritization and coherent reasoning.
