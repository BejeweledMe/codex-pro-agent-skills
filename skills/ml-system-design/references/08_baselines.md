# Baselines

Related: [preliminary research](03_preliminary_research_build_vs_buy.md), [error analysis](09_error_analysis.md), [integration and fallbacks](13_integration_api_release_fallbacks.md)

## Что Такое Baseline

Baseline - самая простая рабочая версия модели, feature set, правила, процесса или системы. Он должен реально работать и давать результат нужного формата.

Baseline не обязан быть ML. Иногда лучший старт - константа, правило, текущий бизнес-процесс, vendor или ручная процедура.

## Зачем Нужен Baseline

Baseline решает сразу несколько задач:

- быстро проверить гипотезу продукта;
- собрать ранний feedback;
- дать пользователю value раньше;
- проверить, что компоненты системы соединяются;
- получить точку сравнения для будущих моделей;
- иметь fallback при отказе основной модели.

Если сложная модель не бьет простой baseline, это важный сигнал, а не неудобная формальность.

## Типы Baseline

- Constant baseline: среднее, медиана, majority class, fixed score.
- Rule-based baseline: простые правила, регулярные выражения, group-level heuristics.
- Existing process baseline: текущий ручной или бизнес-процесс.
- Vendor baseline: внешняя система как стартовая точка.
- Simple model baseline: linear/logistic model, shallow tree, simple ranking.
- Feature baseline: проверка ценности отдельных feature groups.
- DL baseline: pretrained model, simple fine-tune или простой model-from-scratch, если домен требует DL.

## Как Сравнивать

Не сравнивайте только accuracy. Смотрите:

- качество;
- effort;
- latency;
- compute cost;
- explainability;
- maintainability;
- integration complexity;
- reliability;
- suitability as fallback.

Чем сложнее модель, тем сильнее она должна оправдывать свою стоимость.

## Когда Baseline Можно Пропустить

Baseline может быть не нужен или не быть отдельным этапом, если:

- уже есть работающая система, и она сама является baseline;
- задача уже много раз решалась командой в таком же контексте;
- с первого релиза требуется высокая точность, а слабое автоматическое решение опасно;
- корректнее сразу передать управление человеку, чем отдавать плохое prediction.

## Checklist

- Какой самый простой рабочий вариант?
- Может ли он быть non-ML?
- Можно ли объяснить baseline бизнесу?
- Какие метрики baseline задает для сравнения?
- Можно ли использовать baseline как fallback?
- Что должно улучшиться, чтобы сложная модель была оправдана?
