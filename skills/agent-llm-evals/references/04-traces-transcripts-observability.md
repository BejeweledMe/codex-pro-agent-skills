# Traces Transcripts Observability

Use when: debugging agent behavior, evaluating tool calls, checking handoffs, investigating eval failures, or connecting offline evals to production monitoring.

## Core Ideas

- Start with traces when behavior is still poorly understood.
- Move to datasets and eval runs after you know what "good" looks like.
- Aggregate scores hide why a workflow failed. Traces and transcripts reveal failure modes.
- Observability is not only production logging; it is the evidence path from input to action to outcome.
- In OpenAI docs, traces, graders, datasets and eval runs are OpenAI Platform surfaces. In a vendor-neutral system, use the same pattern with equivalent logs, graders, datasets and repeatable runs.

## Traces

A useful trace captures:

- User and system/developer inputs.
- Model calls.
- Tool calls and arguments.
- Tool results.
- Guardrail checks.
- Handoffs.
- Errors, retries and timeouts.
- Final output.
- Important state changes.
- Latency, token usage and cost.

Trace grading is useful for workflow-level questions:

- Did the agent pick the right tool?
- Did handoff happen when it should?
- Did the workflow violate policy?
- Did a prompt or routing change improve the end-to-end behavior?

## Transcripts

Read transcripts when:

- Scores do not match intuition.
- A grader rejects a seemingly valid solution.
- A task has many partial failures.
- A model upgrade changes style or behavior.
- You suspect prompt, tool, state or harness confusion.

Transcript review answers:

- Did the agent misunderstand the task?
- Did the tool return ambiguous data?
- Did the grader expect something the prompt never specified?
- Did the environment cause failure?
- Did the agent find a valid path the grader did not anticipate?

## Production Observability

Offline evals are pre-launch and regression tools. Production monitoring catches real distribution drift and unanticipated behavior.

Track:

- Task completion rate.
- Error and timeout rate.
- Tool call success/failure.
- Guardrail and refusal rates.
- Handoff frequency and loops.
- Latency, tokens and cost.
- User feedback, complaints and support tickets.
- Safety incidents and policy violations.
- A/B outcomes for user and business metrics.

## Closing The Loop

1. Production issue occurs.
2. Capture trace, user report, logs and final state.
3. Classify root cause: prompt, model, tool, data, environment, grader, policy, product requirement.
4. Add a regression test or eval case.
5. Update rubric or grader if the failure was unfair.
6. Run suite in CI/CD and release gates.
7. Monitor the same failure mode after rollout.

## Anti-Patterns

- Looking only at aggregate pass rate.
- Not storing enough trace data to reproduce failures.
- Treating every eval failure as agent failure before checking harness and grader.
- Reading transcripts only after major incidents.
- Production alerts without owner or action.
- Capturing sensitive data without privacy controls.
- Offline eval dataset that never incorporates production failures.

## Checklist

- Does every eval run produce inspectable evidence?
- Can a failure be attributed to agent, tool, environment, data, grader or task spec?
- Are traces linked to dataset case IDs and versioned prompts/tools/models?
- Are production incidents converted into regression cases?
- Are privacy and retention requirements respected?
- Does monitoring cover both quality and operational health?
- Are manual transcript reviews scheduled for high-risk workflows?

## Sources

- [OpenAI Evaluate agent workflows](https://developers.openai.com/api/docs/guides/agent-evals)
- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

## Cross-Links

- [02-agent-eval-design.md](02-agent-eval-design.md)
- [03-graders-rubrics-human-calibration.md](03-graders-rubrics-human-calibration.md)
- [05-capability-regression-release.md](05-capability-regression-release.md)
