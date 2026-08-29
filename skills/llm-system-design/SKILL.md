---
name: llm-system-design
description: Use when designing, reviewing, or evolving an LLM product as a system. Trigger for prompt versus RAG versus agent versus adaptation decisions, model or provider routing, prompt and context architecture, token/cost/latency budgets, degradation and fallbacks, tenant isolation, and versioned LLM releases. Not for detailed retrieval, agent-loop, model-training, eval-harness, security-test, or GPU-runtime implementation.
---

# LLM System Design

Design an LLM product as a composition of capability, data, control, and release
contracts. This skill decides what belongs in the product architecture and why;
specialist skills implement the chosen component.

## Core Rules

- Start with the user task, error cost, data-access boundary, latency/cost contract,
  volume, deployment constraints, and fallback before selecting a model or pattern.
- Compare the smallest viable capability path: deterministic flow or prompt,
  retrieval, agent workflow, model adaptation, then self-hosted runtime work only
  when its benefits are measurable.
- Treat model/provider, prompt/template, context policy, index, tool policy,
  routing, limits, and evaluations as an attributable release bundle.
- Keep architecture-level budgets separate from runtime tuning: choose the user
  contract here; use `$llm-inference-optimization` to make a self-hosted route meet it.
- Do not hide retrieval, agent, safety, or evaluation decisions inside a prompt.

## Reference Routing

Read only the files needed for the current request.

- Start with [capability selection](references/01_capability_selection.md) for a new
  LLM product, a design review, or a prompt/RAG/agent/adaptation decision.
- For provider/model portfolio, prompts, context windows, structured output, and
  model routing, read [models, prompts, and context](references/02_models_prompts_context.md).
- For service topology, fallbacks, product budgets, and graceful degradation, read
  [architecture and routing](references/03_architecture_routing_fallbacks.md).
- For tenancy, release bundles, rollout, rollback, and operating controls, read
  [release and tenancy](references/04_release_tenancy_controls.md).
- For a design or review template, read [templates](references/05_templates.md).

## Boundaries

### This Skill Owns

- whether the product needs an LLM at all, and the choice between prompt, RAG,
  agent workflow, or behavior adaptation;
- provider/API versus self-hosted placement, model portfolio and request routing;
- prompt and context architecture, context/token budgets, product latency/cost
  targets, user-visible degradation, and release topology;
- tenant isolation and versioning of the complete LLM product bundle.

### Not This Skill

- Retrieval, chunking, index construction, reranking, and recall diagnosis belong
  to `$rag-engineering`.
- Tool loops, state machines, handoffs, retries, and multi-agent execution belong
  to `$agent-workflows`.
- Fine-tuning method, classical NLP/encoder choice, tokenizer changes, training
  data, and adaptation evaluation belong to `$nlp-modeling-and-adaptation`.
- TTFT, prefill/decode, KV cache, batching, quantization, GPUs, and serving
  capacity belong to `$llm-inference-optimization`.
- Eval harnesses, graders, regression gates, and calibration belong to
  `$agent-llm-evals`; threat modeling and authorized boundary testing belong to
  `$genai-security-testing`.
- Generic storage, queues, service contracts, and distributed infrastructure belong
  to `$system-design`; SLOs, incidents, and on-call operations belong to
  `$sre-reliability-engineering`.

## Workflow

1. Define the task contract: allowed inputs and sources, required evidence,
   error/abstention behavior, privacy boundary, volume, and product budget.
2. Establish a simple non-agent baseline. Select prompt, RAG, agent, adaptation,
   or a combination based on the failure that remains, not fashion.
3. Assign one primary owner for each selected component and request the necessary
   specialist design. Do not duplicate their implementation guidance here.
4. Specify model/provider routing, context and output limits, failure behavior,
   tenant controls, and the versioned release bundle.
5. Require evaluation, security, rollout, rollback, and operating evidence before
   calling the product ready.

## Output

For a new design or review, include the user/task contract; chosen capability
pattern and rejected alternatives; model/provider and context architecture;
component handoffs; product latency/cost/token budgets; data and tenancy boundary;
degradation/fallback behavior; release bundle; evaluation/security/operations plan;
risks, assumptions, and next discriminating experiment.

## Quality Bar

- Do not use an agent when a bounded deterministic or retrieval flow meets the
  contract.
- Do not use RAG to disguise an access, data-quality, or model-behavior problem.
- Do not treat a model switch, prompt change, or index update as an isolated release.
- Do not claim a cost or latency improvement without workload-class and fallback
  evidence.
