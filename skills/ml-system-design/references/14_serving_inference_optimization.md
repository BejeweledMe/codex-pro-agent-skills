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
