# Measuring, A/B Testing и Reporting

Related: [metrics](05_metrics_losses.md), [integration](13_integration_api_release_fallbacks.md), [monitoring](15_monitoring_ownership_maintenance.md)

## От Offline К Business Effect

Offline evaluation дает приближение ожидаемого эффекта, но не доказывает product/business value. Реальные пользователи, feedback loops, UI, latency и business process могут изменить результат.

Нужно заранее понимать, как offline metric связана с online/product metric и business KPI.

## Simulation and Human Evaluation

Simulation полезна до production, если можно реалистично воспроизвести среду и поведение системы.

Human evaluation нужна, когда автоматическая метрика плохо отражает качество: subjective quality, ranking relevance, generated outputs, moderation, semantic matching и похожие задачи.

## Evidence by Stage

Choose stages from the unresolved risk; this is not a mandatory ladder for every
change. Preserve the exact candidate, population, data window, decision policy,
instrumentation version and incidents behind each result.

| Stage | What it can establish | What remains unproved |
| --- | --- | --- |
| Offline evaluation | Predictive quality and regressions on a specified surface | Live integration, changed user behavior and business effect |
| Simulation/replay | Behavior under recorded or modeled conditions and explicit assumptions | Outcomes of unsupported actions or an inaccurate environment model |
| Shadow | Real-input compatibility, runtime behavior and candidate divergence without applying its decisions | Effects of users or downstream systems responding to the candidate |
| Canary | Operational and selected quality behavior under bounded exposure | Causal superiority, rare-event safety or sufficient statistical power from traffic percentage alone |
| A/B | Causal product effect under valid assignment, attribution and analysis assumptions | Operational readiness, recovery capability or automatic generalization to every rollout cohort |
| Staged rollout and soak | Behavior as population/device/dependency exposure widens and time-dependent state accumulates | An experiment-quality causal estimate merely because rollout was gradual |

Shadow execution must suppress consequential writes and respect production
resource limits; duplicated load can itself affect users. For rollout, name
expansion and stop criteria by quality, guardrails, cohorts, capacity and recovery
evidence. A green latency canary answers only part of the release decision.

## Replay Preconditions

Distinguish input replay for compatibility from off-policy outcome estimation.
Historical outcomes reflect the logging policy's actions. Merely retaining cases
where old and new actions match does not generally produce an unbiased estimate.

Before making an outcome claim, identify the logged context, available actions,
chosen action, logging-policy version, outcome attribution/delay and selection
mechanism. Establish support for the candidate's actions in the target population.
Randomized logging or a justified identification design is needed; estimators
using propensities require valid probabilities and their assumptions to be checked.
Inspect sparse support and uncertainty before trusting a large apparent gain.

If logging or support is inadequate, limit replay to the behavior it can show,
collect suitable evidence, or use an appropriately designed live experiment.
Advanced off-policy, interference and sequential inference require task-specific
statistical evidence beyond this lifecycle guide. `$data-engineering` owns replay
mechanics; ML owns the validity and scope of the claim.

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

Make the consequences explicit: request assignment can expose one user to both
policies; session assignment can carry effects into later sessions; user
assignment does not remove interactions between users; cluster assignment
reduces the number of independent units. Match uncertainty and sample planning
to the assignment and correlation structure rather than counting every event
as independent. Stable assignment and recorded exposure are both needed.

Before exposure, state how mixed outcomes will be interpreted: primary metric
improves but a harm guardrail fails; aggregate improves but a critical segment
degrades; estimates are too uncertain; or outcomes are not yet mature. Do not
average a blocking harm into a favorable composite after seeing results.
Use a stopping/analysis plan that accounts for repeated looks; peeking until
significance under a fixed-sample test inflates false-positive risk. Unexpected
material harm can require containment even if it was not listed in advance.
Document the stop and distinguish it from a claim of statistical success.
Track predictions through applied decisions, exposure and matured outcomes so
an instrumentation or routing change cannot masquerade as model uplift.

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
