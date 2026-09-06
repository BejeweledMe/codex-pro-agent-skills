# Validation, Leakage и Splits

Related: [metrics](05_metrics_losses.md), [data](06_data_labeling_metadata.md), [error analysis](09_error_analysis.md)

## Задача Validation

Validation должна оценивать, как модель будет работать в реальном применении. Главное правило: split должен отражать, что модель знает на training time и что будет неизвестно на inference time.

Если validation не похожа на production, хороший score может быть иллюзией.

## Standard Schemas

Train/validation/test split подходит, когда данные примерно одинаково распределены и нет важных групп, времени или зависимостей.

Test set нельзя использовать для постоянного tuning. Иначе команда постепенно переобучается на test и завышает ожидаемое качество.

## Cross-Validation

Cross-validation полезна, когда данных мало или нужно оценить variance качества. Но она дороже по compute и может быть неправильной для time-series, grouped data или задач с leakage.

Выбор K - tradeoff между bias, variance и computation time.

## Nontrivial Schemas

- Time-series validation: не смешивать будущее с прошлым.
- Grouped split: не разносить похожие объекты одной группы между train и test.
- Nested validation: использовать, когда model selection и hyperparameter tuning являются частью процесса.
- Adversarial validation: обучить бинарный классификатор отличать один split/dataset от другого, часто без target labels. ROC AUC около 0.5 означает, что splits похожи для этого классификатора; высокий AUC указывает на shift. Sample-level scores помогают находить наблюдения, похожие на другой split.

Разные validation schemas могут сосуществовать: одна для model selection, другая для финальной проверки, третья для drift/shift диагностики.

## Leakage

Частые источники leakage:

- признаки, агрегированные с использованием будущего;
- дубликаты между train и test;
- один пользователь/объект в разных split;
- label information внутри feature;
- downstream outcome, недоступный на inference time;
- output upstream-модели без контроля версии и времени.

## Quantifying Leakage Exploitation

Для задач, где модель может почти копировать training examples через retrieval или локальную похожесть, используйте процедуру:

1. Разделить dataset на training и validation как в holdout.
2. Разбить оба split на chunks фиксированной длины.
3. Для каждого validation chunk найти N nearest neighbors в training chunk space по embeddings.
4. Посчитать overlap ratio между chunks, похожий на Jaccard-like score: 0 означает, что chunks разные, 1 означает почти duplicate.
5. Если score выше threshold, отфильтровать такой chunk из training set.

Идея: validation должна проверять способность модели обобщать или извлекать релевантную информацию, а не эксплуатировать почти дубликаты из training data.

## Split Updating

Split нужно обновлять, если данные, пользователи или бизнес-процесс меняются. Но слишком частое обновление ломает сопоставимость historical metrics.

Практичный подход: иметь стабильный benchmark для сравнения и свежий evaluation set для актуальности.

Полезно различать три common update procedures:

- Fixed shift: validation строится на свежем временном окне и регулярно сдвигается.
- Fixed ratio: новые labeled данные добавляются с сохранением соотношения train/validation.
- Fixed set/golden set: benchmark намеренно не обновляется, чтобы сравнивать модели во времени; расширение такого set фактически создает новый benchmark.

## Selection Is Learning

Treat every validation-derived choice as part of learning: model or feature
selection, target encoding, preprocessing choices, calibration, thresholds,
hyperparameters and repeated manual iteration. Fit learned transforms within
the training partition at the appropriate level. Evaluate the chosen procedure
on an outer holdout or outer folds that did not guide those choices.

Nested evaluation must preserve the same entity/time restrictions as deployment.
A random outer split does not repair temporal or grouped leakage inside it.
Record which surfaces influenced selection. Once an outer result is used to
change the candidate, it is selection evidence for that iteration; obtain an
appropriately untouched estimate before making a new release claim.

For temporal deployment, preserve causal feature availability, prediction horizon,
label maturity and relevant arrival gaps. A deliberately nonchronological
anomaly holdout can diagnose robustness, but must be labeled as an auxiliary
stress surface rather than the expected deployment score.

## Fixed and Fresh Surfaces

Keep a versioned fixed surface for regression comparability and a fresh surface
for current relevance. Report them separately: an apparent improvement after
changing dataset composition is not a model improvement on the old benchmark.
Error cases added after inspection become a new benchmark version and remain
useful regression evidence, not an independent release estimate.

Use delayed shift when changing the evaluation window with every data arrival
creates excessive composition noise. Set the refresh cadence from label delay,
population change and the decision being made, rather than a universal number
of days.

For stable entity assignment, use a deterministic mapping from the correlated
entity key to buckets and version the key, mapping and bucket allocation.
New rows for the same entity inherit its assignment. A hash cannot enforce
chronology or discover related entities by itself.

Changing ratios by reallocating buckets is a split migration: preserve an outer
holdout and check prior training exposure before moving any entity into
evaluation. Do not treat stable bucketing as permission to recycle training
examples into a fresh test. Report uncertainty at the relevant correlated
unit, with the time and sampling assumptions made explicit. Bootstrap and
repeated-split estimates need resampling units that preserve the relevant
dependence; folds are not automatically independent observations.

When decision-boundary fragility matters, apply realistic small perturbations
that should preserve the target meaning and measure decision flips and slice
quality. A robustness check complements the release estimate; it does not
replace representative evaluation or justify unrealistic perturbations.

## Checklist

- Какая единица split: row, user, item, session, group, time window?
- Что модель реально знает в момент prediction?
- Есть ли time, group, duplicate или source leakage?
- Есть ли near-duplicate chunks/samples между train и validation?
- Как часто обновляется evaluation set?
- Сравниваются ли модели на одной версии data/pipeline?
- Есть ли отдельная проверка corner cases?
