# Данные, Labels и Metadata

Related: [validation](07_validation_leakage_splits.md), [training pipelines](10_training_pipelines.md), [monitoring](15_monitoring_ownership_maintenance.md)

## Data Sources

Данные могут приходить из внутренних событий, транзакций, логов, пользовательских действий, внешних баз, купленных датасетов, domain-систем, экспертной разметки или ручных процессов.

Источник должен быть связан с problem statement. Данные, которые легко достать, не обязательно являются правильными данными.

## Dataset Cooking

Raw data редко является готовым dataset. Обычно нужны extraction, joins, filtering, deduplication, normalization, feature generation и labeling.

Dataset должен быть воспроизводимым процессом, а не случайным файлом. Иначе невозможно сравнивать модели, расследовать регрессии и повторять эксперименты.

## Labeling

Labeling rules должны быть явными. Если разные разметчики по-разному понимают задачу, модель учится шумной цели.

Нужно фиксировать:

- кто или что создает label;
- как разрешаются конфликты;
- какие классы/значения допустимы;
- какие cases исключаются;
- как измеряется качество разметки.

Варианты labeling зависят от задачи и бюджета: in-house experts, crowdsourcing, weak supervision, existing business decisions, semi-automatic labeling или комбинация подходов. Нужно учитывать noisy labelers, adversarial или невнимательную разметку, majority vote, interrater reliability и правила эскалации спорных случаев.

## Metadata

Metadata нужна для воспроизводимости и debugging:

- source;
- event time и processing time;
- processing version;
- schema version;
- label source;
- filtering rules;
- user/item IDs или безопасные surrogate keys;
- model/pipeline version.

Без metadata сложно обнаружить leakage, drift, stale data и ошибки upstream-систем.

## How Much Data Is Enough

Больше данных полезно, если новые samples несут новый сигнал. Добавление похожих samples может почти не улучшить качество.

Особенно ценны данные из областей, где baseline или модель ошибаются: rare cases, corner cases, новые сегменты, свежие пользовательские паттерны.

## Cold Start

Если данных еще нет, можно использовать:

- текущий ручной процесс;
- rule-based baseline;
- публичные или купленные данные;
- смежный домен;
- синтетические данные;
- human-in-the-loop;
- vendor API.

Цель cold-start решения - запустить сбор полезной обратной связи без преждевременной сложности.

## Healthy Data Pipeline

Три базовых свойства: reproducible, consistent, available.

Data pipeline должен проверять schema, missing values, duplicates, outliers, freshness, range checks, source availability и version compatibility.

## Checklist

- Можно ли воспроизвести dataset с нуля?
- Есть ли metadata для расследования ошибок?
- Labeling rules понятны и проверяемы?
- Какие data quality checks обязательны?
- Какие данные доступны на inference time?
- Где возможен training-serving skew?
