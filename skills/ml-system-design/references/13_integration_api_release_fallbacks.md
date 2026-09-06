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

## Bundle Compatibility and Release Tracks

Use the [semantic training output](10_training_pipelines.md) as the release
identity. Compare golden-input outputs, decisions and downstream regressions,
including target-runtime conversion and thresholds. A schema-compatible response
can still have incompatible meaning.

Separate model and wrapper/service release tracks when their cadences differ,
while explicitly validating supported combinations. For each transition record:

- current and candidate model/transform/feature/decision-policy identities;
- current and candidate wrapper/runtime/configuration identities;
- supported forward and rollback combinations, including dependent state;
- compatibility evidence, quality gates, exposure scope and stop conditions;
- release owner, rollback authority and the observed destination after switching.

Use an atomic coupled release when independent combinations cannot be supported.
Track separation does not authorize deploying an untested model-wrapper pair.
Platform implements registry/routing/controller changes; ML defines semantic
compatibility and acceptance. SRE owns operational response.

## Executable Fallback and Rollback Contract

For each material failure mode, make the response executable through the actual
runbook, route or control used by responders:

| Field | Required decision |
| --- | --- |
| Trigger and scope | Timeout, missing/stale feature, invalid output, quality/harm signal or overload; affected population and detection delay |
| Destination | Evaluated baseline, cache with allowed age, rules, refusal, deferral or human review |
| Authority and mechanism | Who or which bounded automation can switch; exact operational procedure and escalation |
| Capacity and independence | Supported load, dependencies that can fail together, reviewer availability and behavior when the destination is exhausted |
| Observable result | Bundle and route identity, degraded-mode signal to consumers, fallback success and resulting user outcome |
| Exit and recovery | Evidence required to return, decision owner, compatible target and treatment of accumulated state |

Exercise switching and return under representative failure conditions before
relying on the path, and repeat at a risk-based cadence and after relevant
dependency changes. Include a responder other than the author when continuity
depends on handoff. Verify permissions, actual routing, capacity, semantic
output, downstream handling and recovery time; a configured toggle is not
evidence that fallback works.

Rollback must account for transforms, features, thresholds, runtime, cache or
session compatibility and created downstream state. Reverting weights does not
undo prior actions or repair feedback-contaminated training data. Identify the
affected window and consumers, quarantine suspect feedback, and coordinate
necessary state repair/replay with system and data owners. Confirm restoration
on both operational signals and quality/outcome signals as labels mature.

## Integration Authority

Private network location does not establish authentication or authorization.
Model endpoints, debugging parameters and override tooling need controlled
identity, access and attributable changes. ML defines the permitted decisions;
`$application-security-engineering` owns application controls, and
`$api-contract-engineering` owns observable HTTP/consumer compatibility.
Plan support, recourse and relevant retention/deletion flows with the responsible
owners; these integration costs are part of the build/buy decision.

## Temporary Overrides

Record owner, reason, scope, creation time/age, expiry or review date, authority,
history, observability, normal-fix owner and cleanup condition. Define what happens
at expiry: remove only when the normal path is verified safe, otherwise escalate
to an explicit renewal or safe destination. Silent indefinite renewal is not a
maintenance strategy.

Exercise override activation and removal with the same downstream contract as
normal decisions. Monitor stale overrides and their consequences. An override or
appeal can identify useful cases for investigation; it does not automatically
become a correct training label.

## Prediction-to-Decision Trace and Retirement

Retain enough permitted evidence to connect input/feature versions and timestamps,
bundle, score, threshold, override/fallback route, applied decision, exposure and
eventual outcome. Use appropriate access and retention boundaries rather than
logging every raw input. This trace distinguishes model errors from stale
features, routing mistakes, wrapper changes and delayed outcomes.

Integration continues through retirement. Discover consumers, replace or disable
their routes, verify that old artifacts are no longer selected, and remove stale
overrides/configuration/alerts when dependencies permit. Coordinate retention,
deletion and derived-data obligations with the accountable data/product owners;
retiring a serving artifact does not by itself resolve those obligations.

## Checklist

- Что происходит при timeout?
- Что если feature недоступна?
- Что если model service возвращает ошибку?
- Как откатить модель?
- Есть ли compatibility между API и artifact version?
- Кто может включить fallback или override?
- Как downstream systems узнают о degraded mode?
