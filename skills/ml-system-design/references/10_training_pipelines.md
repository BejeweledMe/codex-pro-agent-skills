# Training Pipelines

Related: [data](06_data_labeling_metadata.md), [features](11_features_feature_store.md), [integration](13_integration_api_release_fallbacks.md)

## Что Такое Training Pipeline

Training pipeline - воспроизводимый workflow, который готовит model artifacts и сопутствующие артефакты. Это не notebook и не набор ручных команд.

Training pipeline отличается от inference pipeline: первый создает модель, второй применяет ее в production или в составе offline evaluation.

## Typical Pipeline

Типовой lifecycle:

1. Fetch data.
2. Preprocess.
3. Train.
4. Evaluate and test.
5. Postprocess.
6. Generate report.
7. Package artifacts.

Каждый шаг должен иметь inputs, outputs, versioning и failure behavior.

## Reproducibility

Нужно версионировать:

- code;
- data snapshot или data query;
- preprocessing;
- parameters;
- feature definitions;
- model artifact;
- evaluation results;
- reports;
- environment/runtime.

Если модель нельзя воспроизвести, ее сложно дебажить, сравнивать и безопасно откатывать.

## Scalability

Pipeline должен учитывать будущий рост данных и compute. Вертикальное масштабирование проще, но имеет потолок. Горизонтальное масштабирование сложнее, но дает больший запас.

Не нужно преждевременно строить слишком сложную платформу, но нельзя закладывать архитектуру, которая очевидно не переживет рост.

## Configurability

Недоконфигурированный pipeline сложно менять. Переконфигурированный pipeline сложно понимать и тестировать.

Хороший баланс: параметры, которые реально меняются между экспериментами и окружениями, вынесены в config; остальное остается явным кодом.

## Testing

Тестировать нужно не только модель:

- smoke tests всего workflow;
- unit tests критичных transforms;
- data validation tests;
- artifact compatibility tests;
- conversion compatibility tests между training framework и inference/runtime format;
- property-based checks для invariance, monotonicity, robustness;
- negation property tests, где изменение смысла input должно менять prediction ожидаемым образом;
- regression tests по fixed benchmark.

## Semantic Release Output

Training produces an attributable candidate with evidence, not just weights.
Extend the versioned artifacts above with:

- label schema/source and split identity, including which data influenced selection;
- fitted transform state, feature definitions and upstream model dependencies;
- calibration, threshold and postprocessing/decision policy;
- exported representation, conversion settings, target runtime and dependency assumptions;
- fixed/fresh quality results, critical slices, target-runtime compatibility and relevant benchmark evidence;
- permitted use, known limits, monitoring expectations, fallback and compatible rollback target.

This is a semantic bundle: the identities may live in existing artifact and
release records rather than a new packaging system. Compare the exact exported
candidate on representative inputs, including downstream decisions and affected
slices. Shared preprocessing code or an unchanged schema is not proof of
training-serving parity.

Keep a compact dependency graph from sources/labels through fitted transforms,
features and upstream predictions to models, decision policies and consumers.
Use it to find what must be reevaluated after an upstream change and which
state or cache entries remain compatible during rollback. A registry records
the graph; model and data owners establish the meaning of its edges.
Use the same graph before launch to establish which artifacts, derived state,
caches, snapshots and replicas a source-record deletion reaches, who propagates
the change, and what verifies it. Raw-record deletion, retraining and model
unlearning are distinct claims; agree their applicable scope and evidence with
the accountable owners rather than treating any one as proof of the others.

## Execution Handoffs

Keep objective, sample selection, split validity, experiment control and release
acceptance in ML. For neural execution, send `$neural-training-systems` the
objective, shapes, data/order/batch assumptions, quality target and reproducer.
Receive step correctness, memory/precision/collective evidence, coherent-resume
limits and time-to-quality results. A weights snapshot is not resume evidence.

Send shared job/serving infrastructure requirements and recovery constraints to
`$ai-platform-llmops`; it owns capacity, registry, placement implementation and
scheduling. Send ingestion/transformation/replay mechanics to
`$data-engineering`, retaining label and prediction-time semantic acceptance.
Simple classical pipelines need neither a distributed training system nor a
shared platform merely to satisfy this handoff model.

## Checklist

- Можно ли воспроизвести модель через один workflow?
- Где хранятся artifacts и reports?
- Как pipeline падает при плохих данных?
- Какие параметры можно менять безопасно?
- Проверяется ли compatibility training и serving?
- Есть ли smoke test перед release?
