# Loss Functions и Metrics

Related: [problem framing](02_problem_framing.md), [validation](07_validation_leakage_splits.md), [measuring and A/B](12_measuring_ab_reporting.md)

## Loss vs Metric

Loss управляет тем, чему модель учится. Metric оценивает полезность результата. Они могут различаться, потому что loss должна быть удобна для оптимизации, а metric должна отражать качество решения.

Нельзя выбирать loss или metric только потому, что они сработали в прошлом проекте. Нужно смотреть на стоимость ошибок, product behavior и бизнес-цель.

## Иерархия Метрик

Полезная цепочка:

- model metric: качество предсказаний на offline data;
- product metric: влияние на пользовательское поведение или процесс;
- business KPI: деньги, риск, удержание, cost saving, SLA.

Offline metric нужна для быстрых итераций, но она является только proxy для online/business effect.

## Выбор Loss

Loss должна соответствовать типу задачи и стоимости ошибок. Для gradient-based обучения она обычно должна быть непрерывной и дифференцируемой.

Custom loss имеет смысл, когда стандартная функция не отражает асимметрию ошибок или product constraints. Но custom loss повышает сложность и требует более строгой проверки.

## Loss Tricks

Для deep learning losses есть несколько полезных приемов. Их стоит воспринимать как инструменты, а не как универсальное лечение.

- Focal loss полезна, когда нужно сильнее фокусироваться на сложных или редких примерах, но она не заменяет анализ данных и классового дисбаланса.
- Combined или multiple losses позволяют учить модель нескольким связанным целям, если каждая часть действительно нужна системе.
- Auxiliary losses могут стабилизировать обучение или добавить промежуточный supervision, но усложняют tuning и interpretation.
- Любой loss trick должен проверяться на целевой metric hierarchy, а не только на training loss.

## Offline, Online, Proxy

Offline metrics дешевы и быстры, но могут плохо предсказывать production outcome.

Online metrics часто требуют A/B test, rollout или другой causal evaluation. Proxy metrics нужны, когда прямую бизнес-метрику невозможно быстро измерять.

Опасность: оптимизировать удобную proxy metric, которая перестала быть хорошей заменой реальной цели.

## Consistency Metrics

Consistency metrics полезны, когда небольшие изменения input, retraining или model version не должны резко менять output. Это важно для user trust, ranking stability, moderation, pricing, recommendations и других чувствительных сценариев.

## Guardrails

Кроме основной метрики нужны guardrails:

- latency;
- error rate;
- coverage;
- fairness/segment metrics;
- cost;
- stability;
- manual review load;
- business safety metrics.

## Checklist

- Какая ошибка дороже и насколько?
- Как metric связана с business KPI?
- Что может улучшить offline score, но ухудшить продукт?
- Есть ли segment metrics?
- Есть ли consistency/stability metrics?
- Нужен ли loss trick, или проблема в данных, labels, baseline либо validation?
- Какие guardrails блокируют rollout?
- Проверялась ли связь offline и online metrics?
