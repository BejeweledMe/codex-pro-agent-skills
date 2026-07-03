# Design Document

Related: [problem framing](02_problem_framing.md), [metrics](05_metrics_losses.md), [data](06_data_labeling_metadata.md), [validation](07_validation_leakage_splits.md), [baselines](08_baselines.md), [integration](13_integration_api_release_fallbacks.md), [monitoring](15_monitoring_ownership_maintenance.md)

## Роль Design Doc

Design doc - рабочий инструмент мышления, согласования и поддержки. Он помогает понять, нужна ли ML-система вообще, какие решения приняты, какие tradeoffs осознанны и где риски.

Документ не обязан быть длинным. Несколько хорошо продуманных страниц лучше, чем формальная спецификация без ясных решений.

## Минимальная Структура

Минимальное ядро:

- problem statement;
- origin/relevance проблемы;
- goals и antigoals;
- constraints и risks;
- previous work и alternatives;
- metrics/losses;
- data sources, labels, metadata;
- validation schema;
- baseline;
- training pipeline и features;
- measuring/reporting;
- integration, serving, monitoring;
- ownership и maintenance.

## Goals and Antigoals

Goals определяют, что считается успехом. Antigoals определяют, что система сознательно не делает.

Antigoals нужны, чтобы не оптимизировать все хорошие свойства одновременно. Например, система может не стремиться к real-time inference, не покрывать все сегменты в первом релизе или не заменять human review полностью.

## Review

Review должен искать слабые места, альтернативы и скрытые зависимости. Формальное "looks good" не дает ценности.

Полезные рецензенты:

- ML engineer;
- backend/platform engineer;
- product owner;
- domain expert;
- data engineer;
- infra/SRE;
- security/compliance;
- operations/support.

Чем разнообразнее контекст review, тем больше шансов обнаружить риски до production.

## Living Document

Design doc должен меняться после новых данных, экспериментов, инцидентов, релизов, изменения поведения пользователей и внешних требований.

Если система изменилась, а design doc нет, документ перестает быть инструментом поддержки.

## Checklist

- Можно ли по документу объяснить систему новому инженеру?
- Есть ли явная связь problem -> metrics -> data -> validation -> baseline -> production?
- Зафиксированы ли goals и antigoals?
- Описаны ли alternatives и почему они отклонены?
- Видны ли риски и mitigation?
- Указано ли, кто владеет компонентами?
- Есть ли план запуска, rollback и monitoring?
- Понятно ли, какие решения еще не приняты?
