# Evaluation And False Refusals

## Paired Measures

Measure defensive behavior and legitimate utility on the same versioned release bundle. Useful measures include attack success or block outcome for the approved test corpus, access-violation count, benign and allowed-sensitive task success, false-positive/false-negative or false-refusal rate, trace completeness, latency, cost, and side-effect severity.

Define success with the policy owner. Do not use a universal threshold. A change that blocks more cases but prevents valid sensitive work or corrupts answers is not automatically safer.

## Grading

Use deterministic checks for access, policy, structured validation, and state whenever possible. For nuanced judgments, define a rubric, retain examples, sample traces for human review, and calibrate any LLM judge before it makes a blocking decision. Route harness implementation and calibration to `$agent-llm-evals`.

## Release Gate

Changing model, prompt, retrieval/index, policy, tool schema, or runtime can change security behavior. Run capability and regression slices, stage the rollout when justified, and make rollback restore the previously verified bundle rather than only one component.

## Policy-Constrained Self-Hosted Use

For a controlled deployment handling sensitive but lawful content, write an explicit allowed/restricted/disallowed policy, access model, data residency boundary, and escalation route. Evaluate the model and external controls against that policy; use no policy change as a substitute for authorization, logging, and effect control.
