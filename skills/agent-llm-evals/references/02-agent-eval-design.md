# Agent Eval Design

Use when: evaluating agents, workflows, tool use, handoffs, multi-turn conversations, coding agents, research agents or browser/computer-use agents.

## Core Ideas

- Agent evals are harder than single-turn LLM evals because the agent takes actions, changes state, uses tools, handles environment feedback and may choose different valid paths.
- Evaluate the sources of nondeterminism: instructions, outputs, tool selection, tool arguments, environment state, guardrails and handoffs.
- Build the eval harness so it resembles production enough to be meaningful, but remains isolated and reproducible.
- Grade outcomes where possible. Grade path only when path is part of the product contract.

## Core Terms

- Task: what the agent is asked to do.
- Trial: one run of the task.
- Harness: code and environment that run the task and collect evidence.
- Grader: logic or humans deciding whether success criteria were met.
- Transcript/trace: record of messages, reasoning-visible events, tool calls, state changes and outcomes.
- Suite: set of tasks and graders used for a capability, regression or release decision.

## What To Evaluate

### Instruction Following

- Does the agent follow system/developer instructions over conflicting user prompts?
- Does it stay within scope?
- Does it ask clarifying questions when required?

### Functional Correctness

- Did the final outcome satisfy the task?
- Is the response accurate, relevant, complete and safe?
- Did it ground claims in retrieved or tool-provided data when required?

### Tool Selection

- Did the agent choose the right tool?
- Did it avoid tools when not needed?
- Did it respect permissions and safety constraints?

### Tool Arguments

- Were arguments extracted correctly from conversation or state?
- Are units, IDs, filters and formats correct?
- Does the agent handle ambiguous tool results?

### Environment And State

- Did the expected database, filesystem, ticket, cart, order or config state change?
- Was the environment reset between trials?
- Are failures independent, or are they caused by shared state?

### Handoffs

- Did the right agent take ownership?
- Did handoff happen at the correct boundary?
- Did control return when the topic changed?
- Are circular or unnecessary handoffs prevented?

## Starting Dataset

Start with 20-50 simple tasks drawn from:

- Manual checks the team already runs.
- Bug tracker and support queue.
- Production logs and observed failures.
- High-impact product requirements.
- Known safety and policy edges.

This 20-50 range is a practical early-starting point for real/manual failure cases where changes have large effect sizes. It is not a rule for mature suites, broad production datasets or high-risk release gates. Mature products need larger, more balanced and more difficult suites.

## Task Quality

Good tasks:

- Are unambiguous.
- Can be solved by a capable human.
- Include enough details for the grader's expectations.
- Have a reference solution or known-good behavior.
- Cover both triggering and non-triggering cases.
- Avoid hidden assumptions that the agent could not know.

If a strong agent gets 0% across many attempts, suspect task, harness or grader bugs before concluding the agent is incapable.

## Harness Rules

- Reset state between trials.
- Avoid shared caches, leftover files and hidden history.
- Keep dependencies stable or explicitly versioned.
- Capture traces, transcripts, tool calls, final state, latency, tokens and errors.
- Make failures reproducible.
- Distinguish agent failure from environment failure.

## Anti-Patterns

- Multi-agent architecture without eval evidence that it improves quality.
- Rigid step-by-step grading when multiple paths are valid.
- One-sided trigger evals.
- Hidden grader expectations absent from task description.
- Shared environment state that inflates performance or creates correlated failures.
- Checking only final text when important state mutation or tool safety is required.

## Checklist

- What nondeterminism does this eval target?
- Is the task specification unambiguous?
- Could a human produce a passing reference solution?
- Are undertriggering and overtriggering both covered?
- Is the environment clean for each trial?
- Are tool calls, tool arguments and final state captured?
- Is the grader checking outcome, path or both for a defensible reason?
- Can failures be inspected through traces or transcripts?

## Sources

- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)
- [OpenAI Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices)
- [OpenAI Evaluate agent workflows](https://developers.openai.com/api/docs/guides/agent-evals)

## Cross-Links

- [01-evals-foundations.md](01-evals-foundations.md)
- [03-graders-rubrics-human-calibration.md](03-graders-rubrics-human-calibration.md)
- [04-traces-transcripts-observability.md](04-traces-transcripts-observability.md)
- [07-eval-pyramid-and-feedback-loops.md](07-eval-pyramid-and-feedback-loops.md)
