# Monitoring, Ownership и Maintenance

Related: [design doc](04_design_doc.md), [integration](13_integration_api_release_fallbacks.md), [serving](14_serving_inference_optimization.md)

## Monitoring Layers

Monitoring ML-системы должен покрывать несколько слоев:

- software health: latency, errors, uptime, resource usage;
- data quality and integrity: schema, missing values, duplicates, freshness, outliers;
- model quality and relevance: segment performance, calibration, drift, error rate;
- model output: distribution, stability, impossible values, output drift;
- business KPIs: реальный эффект системы.

Нельзя считать model quality главным слоем, если backend, data pipeline или integration нестабильны.

## Data Drift, Concept Drift, Skew

Data drift - изменилось распределение входных данных.

Concept drift - изменилась связь inputs и target/output; старые закономерности перестали работать.

Training-serving skew - training pipeline и runtime pipeline создают разные данные или features.

Каждая проблема требует другой реакции. Не всякое падение качества лечится retraining.

Отдельные production failure modes:

- processing problems: pipeline формально завершился, но данные обработались неверно;
- zero-row success: job завершился успешно, но не произвел полезных строк;
- data source corruption;
- upstream или cascade model corruption;
- schema change;
- training-serving skew;
- output drift после postprocessing/decision-making.

## Reliability Response

Alert без playbook бесполезен. Для каждого критичного сигнала нужно понимать, что делать:

- fallback;
- rollback;
- retraining;
- data pipeline fix;
- threshold change;
- segment isolation;
- manual review;
- incident escalation.

Monitoring должен не только обнаруживать проблему, но и помогать быстро выбрать действие.

Перед retraining нужно отличить настоящие data/concept drift от data-quality issue. Возможные реакции на drift: адаптировать preprocessing, retrain, reweight fresh data, обучить segment-specific model, изолировать проблемный segment, изменить business rule или временно включить fallback.

## Accountability

У каждого компонента должен быть владелец: данные, pipeline, model, API, serving, monitoring, dashboards, alerts, documentation.

Ownership должен быть явным, а не подразумеваемым. Если все "примерно знают", кто отвечает, в инциденте ответственность будет размытой.

Практически это означает core team, production access policy, on-call rotation, escalation path и postmortems после серьезных инцидентов.

## Bus Factor and Documentation

Система не должна держаться на одном человеке. Bus factor нужно балансировать: слишком мало людей создает риск, слишком много без ясности создает overhead.

Документация должна позволять новому инженеру понять, воспроизвести, отладить и безопасно изменить систему.

## Complexity Control

Сложность растет сама: features, configs, overrides, thresholds, models, pipelines, integrations, exceptions.

Нужны регулярные cleanup, удаление устаревших решений, ревизия ownership и пересмотр design doc. Лишняя сложность часто означает, что проблема была плохо понята или риски не были закрыты в начале.

## Checklist

- Что мониторится на software/data/model/business уровнях?
- Какие alerts actionable?
- Где runbook?
- Кто on-call?
- Что является trigger для retraining?
- Как отличить drift от поломки data pipeline?
- Какие части системы понимает только один человек?
- Какие features/configs/overrides пора удалить?
