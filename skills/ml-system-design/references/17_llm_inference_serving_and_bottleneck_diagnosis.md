# LLM Inference, Serving И Диагностика Bottleneck

## Разложить Critical Path

Измеряйте admission/queue, tokenization, prefill/TTFT, decode/token rate, streaming/network, postprocessing и external tools отдельно, по workload class и P50/P95/P99. Средняя end-to-end latency не локализует bottleneck.

## Capacity Model

Считайте бюджет весов, KV cache, activations/runtime overhead и concurrency. Context length, completion length и active sequences конкурируют за память. Приближения полезны для гипотезы, но не заменяют runtime telemetry: фиксируйте KV occupancy/evictions, OOM/rejects, queue delay, token counts, GPU compute/memory signals, TTFT, decode rate, error/cancel and cost.

## Diagnose Before Tuning

Prefill и decode могут иметь разные ограничения. Проверьте, является ли узким местом очередь, compute, memory/KV, batching/fairness, network, serialization или downstream work. Затем меняйте одну вещь: remove wasted work, bounded batching/cache/routing, precision/runtime, compression, or topology. Любая мера должна пройти target quality and structured-output/tool correctness checks.

## Serving Control

Определите admission control, deadline, overload behavior, fairness, output/context limits, fallback route и rollback. Increase throughput only when tail latency and starvation remain inside the user contract. A smaller or quantized model is not automatically faster on every hardware/runtime combination.

## Release Bundle

Treat model, tokenizer/template, adapter, runtime, scheduler, limits, prompt/policy and routing as an attributable release bundle. For SLO/incident ownership use `$sre-reliability-engineering`; for storage/queue/platform architecture use `$system-design`; for model behavior regressions use `$agent-llm-evals`.
