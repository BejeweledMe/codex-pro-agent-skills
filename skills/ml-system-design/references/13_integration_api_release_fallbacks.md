# Integration, API, Release и Fallbacks

Related: [baselines](08_baselines.md), [serving](14_serving_inference_optimization.md), [monitoring](15_monitoring_ownership_maintenance.md)

## Integration Starts Early

Integration - не финальный этап после обучения модели. API, release cycle, fallbacks, observability и operations нужно проектировать с начала работы, иначе готовая модель может оказаться трудно встраиваемой.

## API Design

API ML-системы должен быть простым, предсказуемым и стабильным. Хорошая практика - разделять внешний контракт и внутренние debugging/override возможности.

Если возможно, стоит отделять ML logic от IO logic: model code не должен быть намертво связан с транспортом, storage или UI.

Практики integration layer: держать понятные versioned contracts, использовать deterministic API parameters там, где это влияет на воспроизводимость, иметь внутренний и внешний слой API, подготовить client library для потребителей и использовать feature toggles или аналогичный механизм для управляемых изменений.

## Release Cycle

ML-релиз включает не только код:

- model artifact;
- preprocessing;
- postprocessing;
- feature definitions;
- configs;
- thresholds;
- data assumptions;
- monitoring rules.

Обычные software tests не всегда ловят behavioral regressions. Нужны model evaluation, fixed benchmarks, shadow/canary checks и rollback plan.

Canary rollout и A/B test не одно и то же: canary снижает release-риск на малой доле traffic, а A/B измеряет causal effect новой системы.

## Operations

Production-система требует:

- owners;
- dashboards;
- logs;
- alerts;
- runbooks;
- incident process;
- rollback path;
- manual override rules.

Без operations модель остается экспериментом, а не надежным сервисом.

## Overrides and Fallbacks

Fallback может быть:

- baseline;
- cached answer;
- rule-based decision;
- default safe response;
- human review;
- отказ от prediction;
- degraded mode.

Overrides нужно отслеживать, хранить их историю и планировать нормальное исправление или удаление. Иначе ручные исключения постепенно превращаются в скрытую бизнес-логику.

## Checklist

- Что происходит при timeout?
- Что если feature недоступна?
- Что если model service возвращает ошибку?
- Как откатить модель?
- Есть ли compatibility между API и artifact version?
- Кто может включить fallback или override?
- Как downstream systems узнают о degraded mode?
