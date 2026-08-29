---
name: llm-inference-optimization
description: Use when diagnosing or improving self-hosted LLM inference latency, throughput, cost, or capacity. Trigger for queue delay, TTFT, prefill/decode, token rate, KV-cache pressure, batching and scheduling, quantization, speculative decoding, GPU memory, parallelism, autoscaling, admission control, or serving rollout. Not for product-level provider choice, model adaptation, retrieval quality, agent design, or generic SLO/incident process.
---

# LLM Inference Optimization

Optimize a measured self-hosted LLM request path, not an abstract model size. Separate
queueing, prefill, decode, cache/memory, network, validation, and downstream work
before changing precision, hardware, batch policy, or topology.

## Core Rules

- Define workload classes and user contract first: prompt/context and completion
  lengths, concurrency, arrival pattern, streaming, priority, quality constraints,
  target TTFT/tail latency, throughput, and cost.
- Measure queue delay, tokenization, prefill/TTFT, inter-token/decode rate, end-to-end
  latency, cancellation/errors, token counts, memory/KV behavior, and cost separately.
- Diagnose before tuning. A change that reduces weight bytes may not improve the
  binding runtime bottleneck or may regress structured output and task quality.
- Treat model, tokenizer/template, adapter, runtime, scheduler, limits, route, and
  quantization as one attributable serving release bundle.
- Product budgets and provider routing belong to `$llm-system-design`; this skill
  determines whether a self-hosted route can meet that contract.

## Reference Routing

Read only the files needed for the request.

- Start with [measurement and diagnosis](references/01_measurement_diagnosis.md) for
  every latency, capacity, cost, or bottleneck investigation.
- For weights, activations, KV cache, concurrency, and capacity estimates, read
  [memory and capacity](references/02_memory_capacity.md).
- For batching, cache, scheduler, routing, parallelism, and overload behavior, read
  [runtime controls](references/03_runtime_controls.md).
- For weight, activation, and KV-cache quantization decisions, read
  [quantization](references/04_quantization.md).
- For release, rollback, telemetry, and operational templates, read
  [release and operations](references/05_release_operations.md).

## Boundaries

### This Skill Owns

- profiling and optimization of self-hosted LLM request execution;
- runtime capacity: memory, KV cache, batching, scheduling, parallelism, autoscaling,
  admission control, and overload behavior;
- runtime precision/compression choices, including their target-workload quality and
  compatibility validation.

### Not This Skill

- Product-level API versus self-hosted choice, model/provider portfolio, request
  routing policy, user-visible degradation, and token/cost budgets belong to
  `$llm-system-design`.
- Model quality, tokenizer/model/adaptation selection, SFT/PEFT, distillation design,
  and training data belong to `$nlp-modeling-and-adaptation`.
- Retrieval/index latency belongs to `$rag-engineering` until a trace localizes the
  bottleneck in generation.
- Non-LLM computer vision inference, including image/video decode, preprocessing,
  tiling, detection/segmentation/OCR postprocessing, visual vector search, and
  CV runtime conversion or quantization, belongs to
  `$computer-vision-inference-optimization`.
- Generic service/storage/queue design belongs to `$system-design`; SLO ownership,
  on-call, incident response, and reliability operations belong to
  `$sre-reliability-engineering`.
- Model/prompt behavior regression harnesses belong to `$agent-llm-evals`.

## Workflow

1. Freeze representative workload classes and the target quality/latency/cost contract.
2. Trace the full path; name the first saturated or delayed stage rather than assuming
   the model is slow.
3. Form one causal hypothesis and change the smallest relevant lever.
4. Compare target workload, long-context, structured-output/tool, and quality slices
   before expanding traffic. Retain the previous verified serving bundle.
5. Set admission, fairness, deadline, cancellation, overload, telemetry, and rollback
   behavior before calling a throughput gain production-ready.

## Output

Include workload classes and contract; trace and bottleneck hypothesis; capacity/memory
model; candidate levers and rejected alternatives; quality/compatibility checks;
admission/fairness/overload behavior; serving release bundle; observability, rollback,
owner, and next experiment.

## Quality Bar

- Do not diagnose from average end-to-end latency only.
- Do not equate lower precision or more batching with lower tail latency.
- Do not increase concurrency without a cache/memory, fairness, and overload plan.
- Do not call a runtime faster until it passes the actual task, structured-output, and
  long-context cases that define its product contract.
