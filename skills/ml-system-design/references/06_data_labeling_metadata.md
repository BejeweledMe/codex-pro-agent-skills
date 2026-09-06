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

## Prediction-Time Data and Label Contract

For an affected source, feature or label, record its owner and source of truth,
entity/join key, sampling population, event time, availability time, permitted
freshness, definition/version, and action on invalid or absent data. A past event
can still be unavailable at prediction time. Late arrivals and corrections need
a versioned policy derived from observed delays and downstream requirements;
data engineering implements replay/backfill while ML verifies point-in-time meaning.

During label discovery, allow annotators to report uncertainty, missing classes
or an unanswerable case with a reason. Calibrate instructions using inspected
examples, agreement and adjudication appropriate to the harm. Keep manual,
imported, weak and generated labels distinguishable in provenance. Synthetic or
proxy data alone cannot establish field representativeness.

## Data Selection: Value, Coverage and Total Cost

Use selection when it has a concrete objective: reaching a quality target sooner,
improving quality at a fixed budget, reducing paid labels, or protecting rare-case
coverage. A smaller dataset is not itself success.

1. Fix the evaluation population, quality/calibration floor and important slice
   requirements before optimizing the selector.
2. Compare the full-data baseline, a random or appropriately stratified subset,
   and the proposed selector at comparable total budgets.
3. Include scoring, annotation turnaround, indexing, selection, data movement,
   training and maintenance. For a training-time saving claim, compare
   `T_selection + T_train(subset)` with `T_train(full)`; this is an accounting
   gate under the declared reuse horizon, not sufficient evidence of useful quality.
4. Inspect selected and rejected cohorts, duplicates, provenance and label delay.
   Cheap deduplication or stratified sampling can be sufficient; use active
   selection only when its pool-scoring and annotation loop justify the overhead.
5. Remeasure convergence and input access: random reads, extra epochs, stale labels
   or a moved bottleneck can erase savings from fewer examples.
6. Keep the selector only if its stated objective improves while coverage and
   quality floors hold. Record the simpler fallback and the population or cost
   change that should trigger reconsideration.

For reuse across runs, account for amortized selection cost explicitly rather
than pretending it is free. Information gain per compute is a conceptual frame,
not directly observed information units; use quality at fixed cost or cost to
target quality. Modality owners supply specialized coverage criteria; training
owns execution profiling and business owners judge whether savings are realized.

Source basis: *Machine Learning System Design*, data and validation chapters;
*Machine Learning Systems, Volume I*, data acquisition and selection decisions.
These mechanisms do not establish current labeling prices or platform APIs.

## Checklist

- Можно ли воспроизвести dataset с нуля?
- Есть ли metadata для расследования ошибок?
- Labeling rules понятны и проверяемы?
- Какие data quality checks обязательны?
- Какие данные доступны на inference time?
- Где возможен training-serving skew?
