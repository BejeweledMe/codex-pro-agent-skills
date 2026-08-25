# System Design Operating Model

## Design From Decisions

A useful design is a chain of justified decisions:

```text
user need -> invariant -> requirement -> constraint -> architecture choice
          -> contract -> failure behavior -> validation -> owner
```

If a component cannot be traced back to a requirement or risk, challenge whether it belongs. If a requirement has no implementation or validation path, the design is incomplete.

## Progressive Design Passes

### 1. Frame

- Identify users, critical journeys, business outcome, and owner.
- Separate goals from non-goals.
- Define correctness invariants and the cost of errors, delay, loss, duplication, and downtime.
- Record hard constraints and assumptions that need validation.

### 2. Quantify

- Estimate average and peak traffic, payloads, concurrency, data growth, retention, and geographic distribution.
- Define latency, availability, freshness, recovery, security, and cost targets.
- Use ranges when inputs are uncertain and test sensitivity to peak factor and growth.

### 3. Establish Contracts And State

- Define APIs, events, schemas, ownership, source of truth, and compatibility expectations.
- State consistency, transaction, idempotency, ordering, and durability requirements per operation.
- Mark derived data and explain rebuilding or reconciliation.

### 4. Draw The Minimal Architecture

- Start with the fewest independently operated components that satisfy the current constraints.
- Show clients, entry points, compute, state stores, asynchronous paths, external dependencies, and trust boundaries.
- Walk through critical reads and writes before adding optimizations.

### 5. Pressure-Test

For every critical path ask:

- What happens under 10x traffic, skew, and a hot key?
- What happens when each dependency is slow, unavailable, or returns malformed data?
- What happens on duplicate, reordered, delayed, or lost messages?
- What happens during deploy, rollback, schema change, failover, and restore?
- What can degrade while the core journey still works?
- How will operators detect, diagnose, mitigate, and learn from the failure?

### 6. Prove And Evolve

- Select the smallest validation that resolves the largest uncertainty.
- Define rollout, migration, compatibility window, rollback, and cleanup.
- Assign owners to contracts, data, operations, and unresolved risks.
- Record what evidence would trigger a redesign.

## Reasoning Discipline

- Label statements as `fact`, `estimate`, `assumption`, or `decision` when ambiguity matters.
- Distinguish logical architecture from physical deployment. One logical component need not mean one process or service.
- Distinguish steady state from transition states. Deployments, backfills, failovers, and migrations often dominate risk.
- Analyze tail latency and overload, not only average behavior.
- Model correlated failures; replicas that share a zone, dependency, credential, control plane, or deployment can fail together.
- Optimize for lifetime cost: implementation, infrastructure, operation, change, migration, incident, and opportunity cost.

## Common Failure Modes In Design Work

- Choosing technologies before defining access patterns and guarantees.
- Drawing components without owners or contracts.
- Treating current average load as the capacity requirement.
- Assuming exactly-once effects from a broker or protocol claim.
- Ignoring partial failure and transition states.
- Solving a hypothetical future scale with present-day operational complexity.
- Describing the happy path in detail while leaving rollback and recovery vague.
- Copying a large-company topology without its traffic, staffing, tooling, or constraints.
