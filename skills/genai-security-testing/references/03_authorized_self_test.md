# Authorized Self-Test

## Gate 0: Permission

Record the controlled system, owner authorization, environment, authorized tester identities, permitted test classes, data policy, rate/cost cap, time window, responsible contact, and emergency stop path. If any is absent, design the plan only; do not execute tests.

## Gate 1: Isolation

Prefer a disposable environment, synthetic or approved redacted data, test tenants/accounts, non-production credentials, scoped network egress, and tool doubles. Rehearse the kill/revoke path and recovery owner before the first test.

## Gate 2: Paired Corpus

Build separately versioned slices: benign, allowed-sensitive, disallowed by the owner's policy, and authorized adversarial cases. Cover direct and indirect injected content, access-boundary cases, tool/argument provenance, business-rule edges, budget abuse, multi-turn behavior, and language or format variation only within the approved scope.

Where approved, include a candidate memory entry that falsely claims permission,
a stale summary contradicted by the authoritative record, and a restore/rollback
that could resurrect a revoked capability or removed document. Pair these with
valid memory updates and permitted recovery so blocking everything is not counted
as success. Inspect durable state and final tool/data effects, not only the
assistant's wording. Use isolated fixtures and never create a real unintended
external effect to demonstrate the risk.

## Gate 3: Fixed Protocol

Fix the system bundle, corpus, success condition, judge/rubric, environment reset, and calculation before the run. Preserve redacted traces and side-effect state. Do not claim a benchmark result represents production without matching workload and boundary assumptions.

## Controlled Execution

Run within concurrency, rate, cost, and action limits. Stop immediately on a real unintended external effect, protected-data exposure, scope expansion, failed containment, or cap exhaustion. Disable the capability, revoke affected credentials, assess impact, and record a redacted incident case.

## Report And Regression

Report scope, protocol, slices, coverage, results by slice, evidence, affected path, containment, residual risk, owner, and recommended change without publishing operational exploit detail. Convert confirmed failures into redacted regression cases and rerun them after every relevant bundle change.
