# Serving и Inference Optimization

Related: [integration](13_integration_api_release_fallbacks.md), [monitoring](15_monitoring_ownership_maintenance.md)

## Serving Requirements

Serving design определяется требованиями:

- latency;
- throughput;
- scalability;
- target platforms;
- cost;
- reliability;
- flexibility;
- security and privacy.

Эти требования конфликтуют. Нельзя одновременно оптимизировать все до максимума, поэтому нужны явные tradeoffs.

## Serving Patterns

Типовые варианты:

- online prediction;
- batch prediction;
- hybrid/cached prediction;
- precomputed recommendations/scores;
- routing between models;
- fallback to simpler model;
- async processing.

Выбор зависит от freshness, latency, cost, user experience и acceptable staleness.

Serverless inference может быть полезен для некоторых workloads, но его нужно оценивать по cold starts, limits, cost model и observability. Caching помогает latency и cost, но требует думать о freshness, invalidation и user-specific outputs.

## Tradeoffs

Быстрее не всегда лучше, если резко падает качество или растет complexity. Дешевле не всегда лучше, если ухудшается reliability. Более гибкая research-инфраструктура не всегда подходит production latency.

Нужно балансировать production performance и возможность будущих изменений.

## Optimization Order

Сначала profiling всей системы. Bottleneck может быть не в модели, а в feature fetch, preprocessing, serialization, network, storage, batching или postprocessing.

Затем применяются bottleneck-specific меры:

- batching;
- caching;
- async processing;
- model compression;
- quantization;
- pruning;
- distillation;
- hardware acceleration;
- parallelism;
- routing to smaller model.

Лучшее optimization decision часто состоит в том, чтобы не оптимизировать лишнее.

Profiling GPU и async inference требует осторожности: часть операций выполняется асинхронно, поэтому naive timing может измерять не то место или не весь pipeline.

## Whole-Path Evidence and Placement

Use [benchmark contracts](benchmark-contract-and-claims.md) for comparable
performance claims and [deployment placement](deployment-placement-and-device-envelope.md)
for cloud/edge/hybrid feasibility. A focused runtime check can use either directly
without reopening the entire ML design.

Measure service curves for representative shapes, batch/concurrency, arrival mix
and warm/cold conditions. Include queue, feature fetch, preprocessing, transfer,
execution, postprocessing and downstream work inside the declared boundary.
Report deadlines, rejects, cancellations and fallback load alongside throughput;
completed requests alone can conceal harmful or late decisions.

Define useful-work throughput for each workload class as accepted completions
inside the declared deadline and semantic/policy contract per unit time. Where
quality requires delayed labels, state which quality conditions are estimated
from evaluation and report later outcome evidence separately. Do not present
unobserved per-request correctness as a measured goodput count.

After compression, caching, batching or routing changes, verify the executed
representation and remeasure quality, critical slices and the whole path.
Fewer parameters, sparse masks and low-bit labels do not establish runtime gains.
Inspect fallback operators, conversion overhead, cache misses and the stage to
which the bottleneck moved before retaining the optimization.

ML owns generic predictive serving choices and acceptance. Hand measured service
demand, load/warmup delay, resource needs, compatibility and overload/fallback
limits to `$ai-platform-llmops` for fleet capacity and controller implementation.
Pass service objectives and incident observations to `$sre-reliability-engineering`.
Use CV or LLM inference owners for their modality-specific execution mechanisms.

Readiness requires the intended bundle loaded, runtime initialized and the warm
path verified; process liveness alone is insufficient. Cold starts recur on
rollout, replacement, eviction and scaling. Validate bounded queues, admission,
cancellation, retry and shedding behavior under overload, including recovery
capacity and the miss path of any cache. Cache identity and invalidation must
respect feature/model/policy versions and user or tenant boundaries.

For sparse-feature recommendation or ranking workloads, inspect lookup capacity,
hot keys, shard locality, feature freshness and downstream cascades before
assuming dense model compute binds. Batching by feature/shard locality may help,
but measure its waiting, fairness and freshness effects. ML keeps feature meaning
and quality; AI platform implements physical placement and fleet routing.

## Tools and Frameworks

Инструмент выбирается по требованиям системы, а не по популярности. Важно учитывать deployment target, model format, hardware, observability, scaling, conversion path и team expertise.

Training и inference могут использовать разные frameworks. Типичные intermediate/runtime варианты: ONNX, OpenVINO, TensorRT, TVM, CoreML, TensorFlow Lite. Выбор должен следовать platform и performance constraints.

## Checklist

- Где bottleneck: model, preprocessing, network, storage, feature fetch?
- Какая p50/p95/p99 latency нужна?
- Какой throughput и peak load?
- Что делать при перегрузке?
- Можно ли отдавать stale/cached response?
- Как inference связан с fallback и monitoring?
- Какие оптимизации усложнят maintenance?
