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

## Checklist

- Можно ли воспроизвести модель через один workflow?
- Где хранятся artifacts и reports?
- Как pipeline падает при плохих данных?
- Какие параметры можно менять безопасно?
- Проверяется ли compatibility training и serving?
- Есть ли smoke test перед release?
