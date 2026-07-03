# QA Checklists And Templates

Use when: creating a test strategy, individual test, CI gate, release checklist, or test-suite review.

## Test Strategy Template

```yaml
feature:
owner:
users:
goals:
anti_goals:
risks:
  - risk:
    price_of_failure:
    detection_layer:
    mitigation:
test_layers:
  static:
  unit:
  contract:
  integration:
  larger_or_e2e:
  exploratory:
  production_monitoring:
ci_stages:
  local:
  presubmit:
  post_submit:
  release_candidate:
  canary_or_prod:
rollback:
open_questions:
```

## Unit Test Checklist

- Behavior is user/caller meaningful.
- Public API is used.
- State/output is asserted where possible.
- Setup is minimal and visible.
- Test name describes behavior.
- Failure message is diagnostic.
- Test is deterministic and fast.
- Test does not require real network or shared external state.

## Larger Test Checklist

- Fidelity gap is explicit.
- SUT, data, action and verification are defined.
- Environment is isolated or placed in the right CI stage.
- Owner and triage path are recorded.
- Logs, traces, or diffs are enough for diagnosis.
- Lower-level tests cover edge cases where possible.
- Manual findings become automated regression tests.

## CI Gate Template

```yaml
gate:
stage: local | presubmit | post_submit | nightly | release_candidate | canary | production
blocking: true
checks:
  - name:
    type:
    max_runtime:
    flake_policy:
    owner:
    diagnostic_output:
failure_action:
  notify:
  rollback:
  quarantine_policy:
```

## Release Decision Template

```yaml
release:
version:
date:
owner:
changes:
quality_evidence:
  unit:
  integration:
  larger_tests:
  exploratory:
  production_readiness:
known_risks:
guardrail_metrics:
rollback_criteria:
canary_plan:
post_release_monitoring:
decision:
```

## Operating Rules

- Start with risk and price of failure.
- Choose the smallest reliable check with enough fidelity.
- Prefer public API and state/outcome checks.
- Avoid brittle implementation assertions.
- Put checks in the right CI/CD stage.
- Convert production failures into regression tests.
- Call out evidence and access constraints when the underlying material is incomplete or unavailable.
