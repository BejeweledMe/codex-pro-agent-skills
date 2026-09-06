---
name: nlp-modeling-and-adaptation
description: Use when choosing or adapting a text model. Trigger for rules, TF-IDF or BM25 baselines, encoder or reranker selection, embeddings, BERT-style discriminative models, seq2seq or decoder LLMs, tokenizer changes, continued pretraining, SFT, PEFT/LoRA/QLoRA, preference optimization, distillation, or training-data and adaptation evaluation. Not for LLM product topology, detailed RAG, agent loops, eval harnesses, or serving bottlenecks.
---

# NLP Modeling And Adaptation

Choose the smallest model family and adaptation method that closes a measured text
task gap. Treat model behavior, data, tokenizer/template, training configuration,
and evaluation as one reproducible model bundle.

## Core Rules

- Start with the task, error cost, languages, labels/evidence, inference constraints,
  and a simple baseline. Do not start from a fashionable architecture.
- Separate model selection from product composition: `$llm-system-design` decides
  whether an LLM product needs adaptation; this skill determines whether and how a
  model change can close the remaining capability gap.
- Compare rules, sparse and linear baselines, encoders, rerankers, seq2seq models,
  decoder LLMs, and adaptation on fixed task slices before increasing complexity.
- A training or validation loss is diagnostic evidence, not product success. Protect
  general, safety, language, format, and long-tail behavior alongside the target task.
- Do not prescribe a universal data size, LoRA rank, learning rate, precision, or
  GPU count. Select and document them against the model, data, runtime, and evidence.

## Reference Routing

Read only the files needed for the request.

- Start with [model selection](references/01_model_selection.md) for a new text task,
  baseline, model-family choice, or architecture modification decision.
- For continued pretraining, SFT, PEFT, full fine-tuning, distillation, and training
  controls, read [adaptation methods](references/02_adaptation_methods.md).
- For datasets, tokenization, splits, training diagnostics, and reproducibility, read
  [data and training control](references/03_data_training_control.md).
- For DPO/RLHF-style preference optimization, utility/safety tradeoffs, and behavior
  policy evaluation, read [preference optimization](references/04_preference_optimization.md).
- For adaptation evaluation, release bundles, and decision templates, read
  [evaluation and release](references/05_evaluation_release.md).

## Boundaries

### This Skill Owns

- selecting a text model family and baseline: rules, sparse/linear, encoder,
  reranker, seq2seq, decoder LLM, embeddings, or an adaptation;
- how to change model behavior through data, tokenizer, training objective,
  continued pretraining, SFT, PEFT, preference optimization, distillation, or a
  justified architecture modification;
- adaptation-specific data quality, splits, diagnostics, regression slices, and
  the attributable model bundle.

### Not This Skill

- Neural execution memory, step profiling, precision mechanics, collectives, and
  coherent optimizer/data-state restart belong to `$neural-training-systems`.
  This skill retains model/objective choice, adaptation methods, data semantics,
  quality diagnostics, and evaluation; pass those constraints to the execution owner.
- Prompt/RAG/agent/adaptation composition, provider routing, product token/cost
  budgets, and user-visible fallback belong to `$llm-system-design`.
- Corpus ingestion, chunking, retrieval/index/reranker pipeline, and RAG failure
  diagnosis belong to `$rag-engineering`.
- Agent execution and tool-state design belong to `$agent-workflows`.
- Eval harnesses, graders, calibration, CI, and release gates belong to
  `$agent-llm-evals`.
- Self-hosted inference capacity, KV cache, batching, quantization at serving time,
  and runtime topology belong to `$llm-inference-optimization`.
- General ML product lifecycle, non-text feature systems, and generic MLOps belong
  to `$ml-system-design`.

## Workflow

1. Define the task and evaluation contract, data availability, split unit, language
   coverage, error cost, placement/license constraints, and baseline.
2. Choose the least complex family that can express the task; measure failure modes
   before proposing adaptation.
3. If behavior must change, select an adaptation method from data quality, expected
   shift, trainable parameters, compute, operational complexity, and regression risk.
4. Version the full model bundle, compare target and non-target slices, and release
   a reversible candidate route.
5. Hand off product architecture, runtime, evaluation-operation, retrieval, or agent
   questions to the relevant primary skill.

## Output

Include the task and model contract; non-model/rule/sparse baseline; candidate model
families and rejected alternatives; data/split/tokenizer plan; chosen adaptation or
reason not to adapt; evaluation slices and training diagnostics; artifact bundle;
release/rollback; risks, assumptions, and next experiment.

## Quality Bar

- Do not call a fine-tune successful from training loss, a generic benchmark, or a
  single demonstration.
- Do not use full fine-tuning merely because PEFT exists, or use PEFT merely because
  it is cheaper; test the behavior and operational constraints that matter.
- Do not change a tokenizer, chat template, or adapter without compatibility and
  regression evidence.
