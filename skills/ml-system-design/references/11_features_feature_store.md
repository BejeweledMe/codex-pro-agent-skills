# Features и Feature Store

Related: [data](06_data_labeling_metadata.md), [error analysis](09_error_analysis.md), [training pipelines](10_training_pipelines.md)

## Feature Engineering

Feature engineering - итеративная работа с представлением данных. Хорошие features отражают domain knowledge, доступны на inference time, стабильны, воспроизводимы и помогают модели решать исходную проблему.

Даже в text, image, audio и multimodal задачах полезно понимать preprocessing, metadata, embeddings, auxiliary signals и ограничения входного представления.

Типовые feature families: lags, rolling aggregates, counters, ratios, interactions, encodings, embeddings, metadata features и predictions других моделей. Для target encoding и model-prediction features особенно важно проверять leakage и upstream failure modes.

## Feature Importance

Feature importance помогает понять, чем модель пользуется. Это важно для debugging, объяснения, поиска leakage, оценки readiness к deployment и общения со стейкхолдерами.

Методы бывают model-specific/model-agnostic и global/local. Выбор метода зависит от модели, audience и риска неправильной интерпретации.

## Feature Selection

Feature selection может снизить:

- overfitting;
- training time;
- serving latency;
- storage/compute cost;
- complexity;
- burden of monitoring.

Меньше features не всегда хуже. Иногда удаление слабых или нестабильных features делает систему надежнее.

Основные группы методов:

- filter methods: отбор по статистикам до обучения модели;
- wrapper methods: проверка subsets через модель, обычно дороже и требует аккуратной nested validation;
- embedded methods: selection встроен в обучение модели или regularization.

## Feature Store

Feature store полезен, когда много моделей, команд, табличных источников и переиспользуемых features. Он помогает централизованно хранить, документировать, версионировать, тестировать и мониторить features.

Feature store может быть лишним overhead для простой системы, one-off модели или pure deep learning pipeline без большого набора reusable tabular features.

Желаемые свойства feature store:

- контроль read-write skew между training и serving;
- precalculation для дорогих features;
- feature versioning и backfill;
- dependencies/lineage между features;
- feature bundles для связанных наборов;
- quality checks и monitoring freshness.

## Feature Catalog

Feature catalog должен отвечать:

- кто владелец feature;
- откуда она берется;
- какие dependencies и lineage;
- как часто обновляется;
- какие keys и schema;
- какая freshness;
- какие distributions нормальны;
- кто consumers;
- какие quality checks;
- какая версия definition.

## Risks

Основные риски:

- training-serving skew;
- feature leakage;
- stale features;
- upstream failure;
- semantic drift;
- непонятный ownership;
- feature dependencies без lineage.

## Checklist

- Feature доступна в production в момент prediction?
- Она не содержит future information?
- Есть ли owner и documentation?
- Есть ли versioning/backfill plan?
- Мониторится ли freshness/distribution?
- Как feature влияет на latency?
- Стоит ли feature своей сложности?
