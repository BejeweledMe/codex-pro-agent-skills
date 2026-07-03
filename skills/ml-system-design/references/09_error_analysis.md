# Error Analysis

Related: [validation](07_validation_leakage_splits.md), [baselines](08_baselines.md), [features](11_features_feature_store.md)

## Зачем Нужен Анализ Ошибок

Общая метрика говорит, насколько система хороша в среднем. Error analysis показывает, где именно она ломается и какое улучшение нужно делать следующим.

Без анализа ошибок команда часто перебирает модели вслепую, вместо того чтобы чинить данные, labels, features, validation или постановку задачи.

## Learning Curves

Learning curves помогают понять:

- сходится ли модель;
- есть ли overfitting;
- есть ли underfitting;
- помогает ли добавление данных;
- достаточно ли модель сложна для задачи;
- не сломан ли training process.

Если модель не сходится или явно under/overfits, глубокий residual analysis может быть преждевременным.

Для learning curves полезны несколько чтений:

- loss curve показывает динамику обучения и validation;
- model-wise learning curve сравнивает классы моделей при росте данных или сложности;
- sample-wise learning curve показывает, как качество меняется при увеличении обучающей выборки;
- double descent возможен как caveat: связь между complexity и generalization не всегда монотонна.

Интерпретируя curve, нужно искать не только финальное число, но и форму: convergence, divergence train/validation, plateau, шум, позднее переобучение или отсутствие learning signal.

## Residual Analysis

Residual analysis изучает различия между prediction и actual values. Он помогает обнаружить systematic bias, плохие сегменты, wrong assumptions, underprediction/overprediction и проблемные feature regions.

Для classification аналогичная идея применяется через confusion matrix, confidence/error buckets, calibration, false positive/false negative slices.

В regression-like задачах полезно смотреть:

- distribution residuals;
- смещение среднего residual;
- heavy tails и outliers;
- зоны underprediction и overprediction;
- residuals по времени, группам и feature buckets;
- fairness residuals, включая сравнение групп и Gini-like summaries, если они подходят задаче.

Elasticity curves и partial dependence помогают понять, как output реагирует на изменение отдельных features, и где поведение модели противоречит domain expectations.

## Worst, Best, Corner Cases

Worst cases показывают risk surface: где система опасна, бесполезна или нарушает ожидания.

Best cases показывают, где сигнал уже достаточен и какие условия помогают модели.

Corner cases нужно собирать в fixed benchmark, чтобы не терять важные проверки при следующих итерациях.

## Fairness and Group Analysis

Улучшение общей метрики может скрывать деградацию отдельных когорт. Нужно смотреть ошибки по группам, сегментам, регионам, устройствам, типам пользователей, категориям объектов и другим важным измерениям.

Если сегмент важен для бизнеса или безопасности, его нельзя прятать за средним score.

## Action Loop

Рабочий цикл:

1. Найти error cluster.
2. Сформулировать гипотезу причины.
3. Проверить, проблема в data, labels, features, model, metric, validation или product requirement.
4. Сделать минимальное изменение.
5. Повторно проверить baseline, validation и affected segments.

## Checklist

- Какие сегменты хуже всего?
- Ошибка случайная или систематическая?
- Есть ли признаки leakage или shift?
- Нужны новые данные, другой label или новые features?
- Не оптимизируем ли мы wrong metric?
- Есть ли fairness/regulatory risk?
- Есть ли underprediction/overprediction в важных сегментах?
- Что показывают residual distribution и feature response curves?
- Какие cases добавить в benchmark?
