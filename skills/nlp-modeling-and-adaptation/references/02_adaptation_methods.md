# Adaptation Methods

## Select The Least Costly Sufficient Change

| Method | Use when | Main risk or cost |
|---|---|---|
| Prompt, examples, schema, deterministic post-check | The base model has the capability and request context can carry the instruction | Brittle behavior across phrasing; does not add unavailable knowledge |
| Continued pretraining | Broad domain/language distribution is missing from weights and lawful in-domain text is available | Compute, data contamination, forgetting, and unclear task gain |
| Supervised fine-tuning (SFT) | High-quality input/output examples define the desired task, format, or behavior | Overfit, imitation of noisy examples, general capability regression |
| PEFT/adapters such as LoRA | An adapted behavior is needed with constrained trainable memory/storage or several variants share a base | Adapter/base/template compatibility and capacity limits |
| Quantized-base PEFT such as QLoRA | PEFT is appropriate but full-precision base residency is the binding training constraint | Quantization and kernel compatibility; quality and training stability must be measured |
| Full fine-tuning | Strong evidence that the required shift cannot be reached with PEFT and the base may be safely changed | High compute, artifact size, forgetting, longer rollback/release path |
| Distillation | A verified teacher meets quality but the serving target needs a smaller model | Teacher errors transfer; student needs task and general regression evidence |

The table gives a candidate method, not an automatic progression. For example, a full
fine-tune is not proof of better quality, and QLoRA is not an inference choice merely
because it enabled training.

## PEFT Decision Details

Choose target modules, rank/capacity, scaling, dropout, sequence length, packing, and
precision from a pilot and model support. Record the proportion of trainable
parameters, memory/step time, training stability, and target/non-target quality.
Changing adapter targets or rank changes the model bundle and requires a comparable
evaluation. Keep the immutable base and a verified previous adapter route for
rollback.

## Training From Scratch

Consider it only when the data scale, ownership, tokenizer/architecture requirement,
and operating budget are all explicit. Validate data deduplication and provenance,
tokenizer coverage, scaling plan, objective, intermediate checkpoints, general
capability, safety/utility, and eventual serving route. It is not the first response
to a poor prompt, sparse labels, or missing retrieval evidence.

Use `$ml-system-design` for generic training-platform architecture and
`$llm-inference-optimization` when the deployment route or runtime footprint changes.
