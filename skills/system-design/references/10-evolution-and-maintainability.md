# Evolution And Maintainability

## Design For A Useful Lifetime

Calibrate process and architecture to expected lifetime, number of users and maintainers, change rate, public exposure, and failure impact. Long-lived shared systems need stronger contracts, tests, documentation, migration paths, dependency discipline, and ownership than temporary internal tools.

Preserve the ability to change. Stability means controlled evolution, not freezing the current design.

## Architecture Knowledge

Maintain canonical, reviewable artifacts:

- Problem, goals, non-goals, assumptions, and constraints.
- Architecture and critical flows.
- Data and contract ownership.
- Decision records with alternatives and tradeoffs.
- Operational runbooks and recovery procedures.
- Migration and deprecation status.

Give documents an audience, owner, freshness expectation, and discoverable location. Update or deprecate them with the system; stale architecture documentation can become a false source of truth.

## Modularity And Dependencies

- Keep module interfaces smaller than implementations.
- Make dependencies explicit and minimize cycles.
- Restrict visibility so accidental internals do not become contracts.
- Prefer dependencies with clear ownership, maintenance, security, compatibility, and exit paths.
- Treat version labels as risk signals, not proof of compatibility.
- Make builds and generated artifacts reproducible from declared inputs.
- Standardize repeated patterns where consistency enables tooling and safe change.

Do not abstract merely to remove repeated syntax. Abstract when a stable concept, policy, or source of complexity has emerged.

## Test Strategy For Architecture

Select tests by risk:

- Unit tests for local invariants and deterministic logic.
- Component tests for storage, protocol, and boundary behavior.
- Contract tests for compatibility between owners.
- Integration tests for configuration and real dependency interactions.
- End-to-end tests for a small number of critical journeys.
- Load, stress, recovery, and failure tests for production behavior.
- Canaries and probes for real-environment diversity.

Prefer the smallest test that provides the needed evidence. Treat flaky tests as defects because they erode trust in the feedback system.

## Safe Migration

Every migration needs owner, affected consumers, stages, observability, rollback or roll-forward, and cleanup.

Typical expand-and-contract sequence:

1. Add a backward-compatible schema, field, API, or storage path.
2. Deploy readers able to handle old and new forms.
3. Deploy writers for the new form, using a safe bridge only when required.
4. Backfill or migrate in bounded, resumable, rate-limited batches.
5. Verify counts, invariants, checksums, error rates, and user outcomes.
6. Switch reads or traffic gradually.
7. Stop old writes and prevent new usage.
8. Remove compatibility code and old data after the rollback window.

Avoid uncontrolled dual writes. If temporary dual writing is necessary, define atomicity limits, mismatch detection, reconciliation, precedence, and recovery.

## Deprecation

- Identify consumers through code search, telemetry, ownership data, and dependency graphs.
- Announce replacement, rationale, milestones, support window, and enforcement.
- Provide migration documentation and automation where practical.
- Block new usage after a viable replacement exists.
- Track remaining consumers and escalate before the deadline.
- Complete deletion and infrastructure cleanup.

A compatibility layer without an exit condition becomes permanent complexity.

## Ownership And Toil

- Assign owners to code, contracts, data, deployment, and operational consequences.
- Keep critical knowledge out of one person's head through docs, reviews, rotation, and rehearsals.
- Track repeated manual work by frequency, duration, and people involved.
- Standardize the process before automating it.
- Move from runbook to assisted script, automation, and self-service as repetition and risk justify it.
- Give automation the same ownership and observability expected of the service.

## Evolution Review

- What future change is most likely and how expensive is it today?
- Which observable behaviors may already be de facto contracts?
- Can the component be replaced, migrated, or removed incrementally?
- Are build, dependency, and configuration inputs reproducible?
- Does the test portfolio cover the boundaries and failure modes being changed?
- Who owns cleanup after the transition succeeds?
