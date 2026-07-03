---
name: llm-council
description: Use when designing, running, adapting, reviewing, or debugging a multi-LLM council workflow inspired by karpathy/llm-council. Trigger for parallel first-pass model answers, anonymized peer review and ranking, chairman/synthesizer responses, OpenRouter model configuration, transparent tabbed review UIs, ranking parsers, multi-model answer quality comparisons, and local FastAPI/React council apps.
---

# LLM Council

## Overview

Use this skill to build or reason about a transparent multi-model deliberation system. The reference pattern is: collect independent answers, anonymize them for peer review, aggregate rankings, then ask a designated synthesizer to produce the final answer.

## Core Rule

Do not treat the final synthesis as automatically correct. Preserve raw model outputs, peer reviews, ranking parse results, and the anonymized label mapping so a user can audit how the answer was produced.

## Reference Repository

The public reference is `https://github.com/karpathy/llm-council`. If the task depends on exact implementation details, inspect the current repository before making claims or code changes. As of the reference reviewed for this skill, the project is a local FastAPI plus React app using OpenRouter, not a ready-made Codex skill.

## Workflow

1. Classify the request:
   - Running or modifying the reference app: inspect `README.md`, backend config, API routes, frontend API client, and stage components first.
   - Designing a council from scratch: start from the three-stage workflow below.
   - Debugging quality: inspect prompts, anonymization, ranking parser behavior, model failures, and aggregation logic.
   - Productizing the pattern: add cost controls, timeouts, retries, observability, persistence, abuse controls, and evaluation.
2. Define the council:
   - Council models: diverse enough to add signal, limited enough to control cost and latency.
   - Chairman model: chosen for synthesis quality and context handling.
   - Review criteria: accuracy, insight, completeness, citation quality, risk, or task-specific rubric.
3. Implement the stages:
   - Stage 1: send the user query to each model independently and in parallel.
   - Stage 2: replace model identities with stable labels such as `Response A`; ask each model to evaluate and rank the anonymous responses.
   - Stage 3: pass original answers, peer reviews, parsed rankings, and aggregation metadata to the synthesizer.
4. Make the workflow inspectable:
   - Show each first-pass answer.
   - Show raw peer reviews, not only parsed rankings.
   - Show parsed ranking extraction and aggregate ranking.
   - Explain when labels were anonymized and when names were restored for display.
5. Validate before trusting:
   - Test ranking parser edge cases and malformed outputs.
   - Test partial model failures and all-model failures.
   - Compare outputs against a single strong model baseline.
   - Track latency, token cost, and answer-quality deltas.

## Implementation Notes

- Keep API keys in environment variables and do not persist them in conversations.
- Use async fan-out for Stage 1 and Stage 2 to avoid serial latency.
- Continue with successful model responses when one model fails, but surface partial-failure metadata.
- Keep anonymization server-side or in a trusted layer before review prompts are built.
- Store conversations separately from ephemeral UI metadata unless there is a clear product reason to persist the metadata.
- Make prompt formats strict enough to parse, but retain raw text for validation when parsing fails.

## Design Review Checklist

- Does the system protect against model-name bias during peer review?
- Is the ranking rubric explicit and task-appropriate?
- Can users inspect every intermediate answer and review?
- Are partial failures, empty answers, and parser failures handled?
- Are cost, latency, and rate-limit behavior bounded?
- Are prompts and outputs safe against prompt injection from other model responses?
- Is the final answer grounded in the visible intermediate evidence?

## Output For New Designs

Include:

- Goal and target users.
- Model set and chairman choice.
- Review rubric and ranking format.
- Stage 1, Stage 2, and Stage 3 data flow.
- API and persistence model.
- UI transparency plan.
- Failure handling, cost controls, and observability.
- Evaluation plan against simpler baselines.
