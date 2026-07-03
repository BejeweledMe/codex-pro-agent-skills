# Measuring, A/B Testing и Reporting

Related: [metrics](05_metrics_losses.md), [integration](13_integration_api_release_fallbacks.md), [monitoring](15_monitoring_ownership_maintenance.md)

## От Offline К Business Effect

Offline evaluation дает приближение ожидаемого эффекта, но не доказывает product/business value. Реальные пользователи, feedback loops, UI, latency и business process могут изменить результат.

Нужно заранее понимать, как offline metric связана с online/product metric и business KPI.

## Simulation and Human Evaluation

Simulation полезна до production, если можно реалистично воспроизвести среду и поведение системы.

Human evaluation нужна, когда автоматическая метрика плохо отражает качество: subjective quality, ranking relevance, generated outputs, moderation, semantic matching и похожие задачи.

## A/B Testing

A/B test - стандартный способ измерить causal effect в production, если его можно безопасно провести.

Перед запуском нужно определить:

- hypothesis;
- unit of randomization;
- splitting strategy;
- key metric;
- guardrail/control metrics;
- auxiliary metrics;
- minimum detectable effect;
- statistical criteria;
- duration;
- sample size;
- stopping rule;
- rollout/rollback criteria.

Splitting strategy должна соответствовать продукту: user-level, session-level, request-level, item-level или cluster-level split дают разные риски contamination и разные требования к анализу.

## A/A и Simulated Tests

A/A test и simulated experiments помогают проверить instrumentation, randomization, metric sensitivity и pipeline сбора данных до настоящего риска для пользователей.

Если A/A показывает эффект там, где его быть не должно, A/B дизайну нельзя доверять.

Simulated A/B полезен, когда реальный эксперимент дорогой, опасный или пока невозможен, но симуляция должна честно отражать ограничения production.

## Когда A/B Невозможен

Иногда A/B нельзя провести из-за риска, малой выборки, regulatory constraints, network effects, этики, долгого feedback loop или невозможности изолировать группы. Для дальнейшего исследования полезны keywords: causal effect, difference-in-difference, synthetic control, interrupted time-series analysis, regression discontinuity design и causal inference.

## Uplift Monitoring и Debrief

После запуска нужно мониторить uplift, guardrails и segment effects. Результат эксперимента стоит фиксировать в debrief: что проверяли, что получили, какие проблемы нашли, как интерпретировать эффект, масштабируется ли он на rollout и какие следующие шаги.

## Reporting

Отчет должен объяснять:

- captured effect;
- uncertainty/confidence;
- segment impact;
- negative side effects;
- incidents during experiment;
- expected rollout effect;
- uplift dynamics;
- tradeoffs;
- recommendation: rollout, rollback, iterate, expand experiment.

## Anti-Patterns

- Запускать A/B без заранее зафиксированной гипотезы.
- Смотреть только одну positive metric.
- Игнорировать guardrails.
- Останавливать эксперимент при первом желаемом результате.
- Скрывать сегменты, где стало хуже.
- Делать rollout без debrief.

## Checklist

- Что именно доказывает эксперимент?
- Можно ли безопасно рандомизировать пользователей/объекты?
- Какие guardrails защищают users и business?
- Достаточна ли длительность?
- Какие сегменты смотреть отдельно?
- Как результат влияет на rollout decision?
