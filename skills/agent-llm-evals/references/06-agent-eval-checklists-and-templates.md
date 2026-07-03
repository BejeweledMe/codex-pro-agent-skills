# Agent Eval Checklists And Templates

Use when: creating a new LLM eval suite, agent task case, grader rubric, continuous eval gate, or release decision.

## Agent Eval Case Template

```yaml
id:
title:
owner:
source:
  type: manual_check | bug | support_ticket | production_log | synthetic | incident | domain_expert
  link_or_reference:
capability_or_regression:
task:
user_context:
system_context:
allowed_tools:
disallowed_tools:
environment_setup:
initial_state:
expected_outcome:
reference_solution:
graders:
  - type: deterministic | state_check | tool_call | llm_rubric | human
    name:
    pass_threshold:
    rubric_or_assertion:
tracked_metrics:
  - task_success
  - latency
  - tokens
  - tool_calls
  - cost
failure_tags:
  - instruction_following
  - tool_selection
  - argument_precision
  - handoff
  - groundedness
  - safety
notes:
```

## Grader Rubric Template

```yaml
rubric_name:
dimension:
what_to_grade:
evidence_required:
score_scale:
  pass:
  fail:
  partial:
unknown_allowed: true
examples:
  pass:
  fail:
  partial:
bias_controls:
  - control_response_length
  - randomize_pair_order
  - use_blind_review
human_calibration:
  labels_required:
  agreement_target:
  review_frequency:
```

## Continuous Eval Gate Template

```yaml
gate:
stage: local | presubmit | post_submit | nightly | release_candidate | canary | production
blocking: true
suite:
dataset_version:
model_or_prompt_version:
tools_version:
graders_version:
metrics:
  - task_success
  - pass_at_1
  - pass_at_k
  - pass_power_k
  - latency
  - tokens
  - cost
flake_policy:
owner:
trace_or_transcript_retention:
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
  deterministic_tests:
  evals:
  trace_review:
  human_calibration:
  production_readiness:
known_risks:
guardrail_metrics:
rollback_criteria:
canary_plan:
post_release_monitoring:
decision:
```

## Operating Rules

- Start with objective, dataset, grader, and evidence.
- Separate capability, regression, and release-gate evals.
- Prefer deterministic or state checks where possible.
- Use LLM judges only with clear rubric and calibration.
- Require traces/transcripts for debugging.
- Reset environment state between trials.
- Convert production failures into eval cases.
- Keep vendor-specific eval surfaces separate from durable methodology.
