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

Choose a loss compatible with the task, error costs and optimization method.
For gradient-based methods, check the numerical and gradient behavior actually
used by the implementation; global differentiability is not required. MAE, for
example, can be optimized using a subgradient at its nondifferentiable point.

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

## Metric Sanity and Operating Points

Before trusting an improvement, run the metric on a constant predictor, a
deliberately poor predictor and, where meaningful, randomized predictions.
Inspect a small example with known expected results. A high score from an
unhelpful predictor is evidence to inspect prevalence, denominator, averaging,
weights, missing outcomes, label alignment and task formulation.

For binary decisions, state prevalence `pi`, population/window and eligible
volume `N`. At threshold `t`, translate conditional rates into expected work:

- `TP = N × pi × TPR(t)`
- `FN = N × pi × (1 - TPR(t))`
- `FP = N × (1 - pi) × FPR(t)`
- `precision = TP / (TP + FP)`, when the denominator is nonzero.

Specificity is `1 - FPR`. It and recall describe conditional rates; precision
describes the yield of positive decisions at the observed prevalence. Neither
replaces the other. With rare positives, a small FPR can still create unaffordable
false-positive volume. Report absolute FP/FN counts, expected positive actions,
review demand and important slices, with uncertainty. State whether metric
changes are absolute percentage points or relative changes, and keep the
population and denominator consistent. Conditional rates can also change if
within-class case mix changes; they are not invariant to every population shift.

Choose an operating point by comparing feasible thresholds or policies on
representative selection data. For constant per-error costs and zero cost for
correct decisions, the error-cost component is:

`expected cost(t) = c_FP × FP(t) + c_FN × FN(t)`.

Extend the decision cost for review, abstention, delay and downstream effects
when they matter. Apply capacity and harm constraints before choosing the
lowest-cost feasible point. Costs alone do not determine a numeric threshold
on arbitrary scores: use observed score/outcome distributions and validate
calibration if treating scores as probabilities. Evaluate the selected policy
on an outer surface as described in [validation](07_validation_leakage_splits.md).

Recheck the operating point when prevalence, label selection, costs, capacity
or action policy changes. Declare uncertainty in projected volumes if deployment
prevalence differs from the evaluation sample; do not silently carry sampled
precision into production.

For comparisons, estimate uncertainty in the candidate-minus-baseline difference
under the actual paired, grouped or temporal design. Overlap of two marginal
confidence intervals alone does not settle the ranking.

## Stability Requires Useful Behavior

A constant model is trivially stable. Pair consistency measurements with task
quality and coverage floors. Compare like inputs and unchanged concepts when
measuring release jitter; justified adaptation to a changed target relationship
can require changed predictions. Stakeholders choose acceptable harm and
group trade-offs; an engineering metric alone does not supply that authority.

## Checklist

- Какая ошибка дороже и насколько?
- Как metric связана с business KPI?
- Что может улучшить offline score, но ухудшить продукт?
- Есть ли segment metrics?
- Есть ли consistency/stability metrics?
- Нужен ли loss trick, или проблема в данных, labels, baseline либо validation?
- Какие guardrails блокируют rollout?
- Проверялась ли связь offline и online metrics?
