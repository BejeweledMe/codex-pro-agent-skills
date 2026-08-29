# Preference Optimization And Behavior Policy

## Decide Whether Preference Data Exists

Preference optimization is justified only when the desired behavior is better captured
by a clear comparison than by one reference answer, and the organization can define
the judging policy, collect/calibrate pairs, run regressions, and repeat the loop.
It is not a substitute for missing task definition, poor SFT examples, ungrounded
facts, access control, or a safety architecture.

## Method Selection

- Start with SFT when a correct target response is available and format/task behavior
  is the main goal.
- Consider direct preference methods such as DPO when trustworthy preferred/rejected
  pairs represent the desired tradeoff and the simpler method leaves a measured gap.
- Consider reward-model plus policy-optimization workflows only when their extra
  complexity, stability risk, and iteration cost are justified by evidence and
  ownership exists for reward/policy regressions.

Name the behavior dimensions separately: task usefulness, refusal correctness,
truthfulness/grounding, style, policy adherence, and robustness. Improving an
aggregate preference score can worsen a critical segment.

## Evaluation

Build allowed-sensitive, disallowed, benign-near-boundary, ambiguous, target-domain,
and general-capability slices as relevant. Measure false compliance and false refusal
separately. Use `$genai-security-testing` for authorized threat and boundary design,
and `$agent-llm-evals` for graders, calibration, repeated evaluation, and gates.
