---
name: llm-inference-optimization
description: "Diagnose and optimize self-hosted LLM runtime latency, goodput, cost, and capacity through prefill/decode profiling, KV cache, batching, admission, quantization, and inference parallelism. Use for execution bottlenecks and runtime scaling signals; replica provisioning and fleet placement belong to ai-platform-llmops."
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
- Compare completed requests meeting latency, quality, and policy by workload class.
  Report offered demand and rejected work alongside goodput.
- Admit by predicted token work, KV state, remaining deadline, and tenant budget.
  Bound queues and retries before relying on additional capacity.
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
- For batching, cache, scheduler, inference parallelism, overload, and the runtime
  evidence needed for platform routing and scaling, read
  [runtime controls](references/03_runtime_controls.md).
- For weight, activation, and KV-cache quantization decisions, read
  [quantization](references/04_quantization.md).
- For release, rollback, telemetry, and operational templates, read
  [release and operations](references/05_release_operations.md).

## Boundaries

### This Skill Owns

- profiling and optimization of self-hosted LLM request execution;
- runtime capacity: memory, KV cache, batching, inference scheduling/parallelism,
  request admission, overload behavior, and measured service curves;
- runtime inputs to scaling: service demand, state/locality constraints, and measured
  model loading, warmup, readiness, and drain behavior;
- runtime precision/compression choices, including their target-workload quality and
  compatibility validation.

### Not This Skill

- Product-level API versus self-hosted choice, model/provider portfolio, request
  routing policy, user-visible degradation, and token/cost budgets belong to
  `$llm-system-design`.
- Model quality, tokenizer/model/adaptation selection, SFT/PEFT, distillation design,
  and training data belong to `$nlp-modeling-and-adaptation`.
- Training-step memory, gradients, collectives, and coherent checkpoint/restart
  execution belong to `$neural-training-systems`.
- Model registry, capacity provisioning, replica/controller scaling, fleet routing,
  and placement belong to `$ai-platform-llmops`. Supply a viable execution shape,
  service curves, admission/KV constraints, and readiness evidence.
- Generic Kubernetes and infrastructure-as-code implementation belong to
  `$platform-devops-engineering`.
- Threat and control validation for routes, caches, and runtime surfaces belong to
  `$genai-security-testing`; this skill implements the relevant runtime controls.
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

Use the relevant parts for the requested decision. A routine flag question or a
bounded experiment does not require a full workload packet or release gate; identify
the mechanism, relevant context, and evidence sufficient to support the answer.

1. Freeze representative workload classes and the target quality/latency/cost contract.
2. Trace the full path; name the first saturated or delayed stage rather than assuming
   the model is slow.
3. Establish the capacity ledger and bounded admission/overload envelope. Form one
   causal hypothesis and change the smallest relevant lever.
4. Compare target workload, long-context, structured-output/tool, and quality slices
   using class-specific goodput and tails before expanding traffic. Retain the previous
   verified serving bundle.
5. Set admission, fairness, deadline, cancellation, overload, telemetry, and rollback
   behavior before calling a throughput gain production-ready.

For scaling work, supply the platform owner with causal signals and the complete
detect → decide → provision → load → warm → ready timeline. Use P99 as an outcome
guard; it does not by itself identify a capacity shortage.

## Output

For a substantial runtime or capacity decision, include workload classes and contract;
trace and bottleneck hypothesis; capacity/memory
model; candidate levers and rejected alternatives; quality/compatibility checks;
admission/fairness/overload behavior; serving release bundle; observability, rollback,
owner, and next experiment.

For capacity or scaling decisions, include measured service curves, uncertainty in
token/state predictions, readiness delay, and the exact decision handed to the
platform owner. Scale the evidence to the requested change.

## Quality Bar

- Do not diagnose from average end-to-end latency only.
- Do not equate lower precision or more batching with lower tail latency.
- Do not increase concurrency without a cache/memory, fairness, and overload plan.
- Do not call a runtime faster until it passes the actual task, structured-output, and
  long-context cases that define its product contract.
