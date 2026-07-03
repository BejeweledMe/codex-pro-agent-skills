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

## Checklist

- Какая единица split: row, user, item, session, group, time window?
- Что модель реально знает в момент prediction?
- Есть ли time, group, duplicate или source leakage?
- Есть ли near-duplicate chunks/samples между train и validation?
- Как часто обновляется evaluation set?
- Сравниваются ли модели на одной версии data/pipeline?
- Есть ли отдельная проверка corner cases?
