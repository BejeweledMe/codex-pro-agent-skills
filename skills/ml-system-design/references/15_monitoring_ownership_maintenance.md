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

## Design the Response Before the Detector

For each material signal, define the feasible action first: who can act, how
quickly, with what evidence and fallback capacity. Then choose the detector,
window and threshold appropriate to that response. Record population, source
of truth, expected cadence/seasonality, label maturity, uncertainty, routing,
action, exit criterion and review trigger.

Separate immediately observable contract violations from statistical warnings
and delayed outcomes. Input or prediction drift is an investigation signal,
not proof of lost accuracy or concept drift. Missing labels can hide failure;
stable observed outcomes from selectively labeled cases need not represent
the whole population. Retire or recalibrate signals that repeatedly produce
no useful action after examining what they miss and falsely flag.

## Diagnose Before Retraining

First protect users according to harm. Record sudden/gradual, global/cohort,
offline/production, cold/warm and burst/sustained symptom shape. Check recent
release identity and routing, data contract and parity, decision semantics,
runtime evidence and matured outcomes. Follow evidence to isolate the cause;
the table is a branching guide, not a claim that one symptom has one cause.

| Failure class | Distinguishing evidence | Response and recovery proof |
| --- | --- | --- |
| Service/runtime failure | Queue, dependency errors, warmup, resource/thermal behavior and deployment changes | Apply operational mitigation with SRE/platform; verify the restored path under relevant load and fallback conditions. |
| Data contract failure | Schema/units/time, zero-row success, missingness, freshness, source/label corruption | Stop propagation or quarantine, repair the source/pipeline, then verify representative semantic data checks before using it for training. |
| Training-serving skew | Same logical example yields different features, transforms or decisions across exact bundles | Repair parity or restore a compatible bundle; compare values and downstream decisions at the prediction-time boundary. |
| Covariate drift | Input/cohort mix changes with otherwise valid data | Check seasonality, relevance, coverage and outcome evidence; collect labels or adjust the detector if harmless. Retrain only for a supported quality need. |
| Concept drift | Matured, representative outcomes support changed input–target relationships | Compare objective, labeling and exposure alternatives; evaluate relabeling, policy/threshold change or retraining on clean relevant data with an outer release estimate. |
| Selection or feedback shift | Exposure, product policy, overrides or actions change which cases/outcomes are observed | Investigate the intervention and selective labels, protect affected cohorts, and validate a corrected evidence collection or decision policy. |
| Objective failure | Model metric remains good while product harm, review burden or complaints worsen | Revisit target, proxy and acceptable action with product/domain owners; a new fit to the same target may reproduce the failure. |
| Oversight failure | Review backlog, missing context, low reviewer agreement, unavailable escalation or ineffective overrides | Repair capacity, evidence, competence and authority with product/operations; verify review outcomes and the unavailable-review fallback. |

For immediate post-release degradation, compare model, feature, transform,
threshold, runtime and routing versions before attributing it to external drift.
For gradual cohort degradation, inspect exposure, label delay, calibration and
coverage. Preserve suspect/confirmed distinctions in the incident record.

Retraining needs a supported diagnosis, clean data window, expected benefit,
accountable authority, evaluation gate and rollback plan. Automation may create
a candidate after those prerequisites; a drift detector must not automatically
promote it. Verify recovery against the original symptom, critical slices and
delayed outcomes, and prevent incident feedback from silently becoming training
truth.

## Accountable Handoff

Use a compact record for the components affected by the task; small systems can
combine roles while retaining one accountable owner per decision.

| Record field | What the receiving owner must be able to use |
| --- | --- |
| Component and contract | Source/labels/features/model/decision/API/serving/monitoring/fallback, allowed population and current bundle |
| Accountable owner | Person or team that can resolve changes and acceptance decisions |
| Responder and escalation | On-call or designated operator, backup and escalation path |
| Evidence access | Dashboards, permitted traces, configurations, artifacts and source/label versions needed to diagnose |
| Runbook and authority | Executable containment, fallback, override, rollback and retrain procedures; limits of automatic action |
| Recovery destination | Compatible known-good bundle or safe mode, its capacity and latest exercise evidence |
| Freshness owner | Who maintains data/label contracts, detector assumptions, documentation and contact information |
| Exit and follow-up | Evidence to restore normal operation, owner/deadline and remaining delayed-outcome checks |

For an active incident, add impact/cohort, recent changes, suspected and confirmed
causes, current mitigation, transferred risk and affected feedback window.
The ML owner supplies semantic diagnosis and quality acceptance; SRE coordinates
operational response; data, training and platform owners repair their mechanisms.
Verify that the receiving responder can retrieve evidence and exercise the path.
An owner name without access, capacity or authority is an incomplete handoff.

## Checklist

- Что мониторится на software/data/model/business уровнях?
- Какие alerts actionable?
- Где runbook?
- Кто on-call?
- Что является trigger для retraining?
- Как отличить drift от поломки data pipeline?
- Какие части системы понимает только один человек?
- Какие features/configs/overrides пора удалить?
