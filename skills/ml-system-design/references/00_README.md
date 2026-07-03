# ML System Design Knowledge Base

Прикладная база знаний для агентов: как проектировать, ревьюить, запускать и сопровождать ML-системы.

## Как Читать

- Новый ML-проект: [01](01_principles_process_agent_checklist.md) -> [02](02_problem_framing.md) -> [03](03_preliminary_research_build_vs_buy.md) -> [04](04_design_doc.md) -> [05](05_metrics_losses.md) -> [06](06_data_labeling_metadata.md) -> [07](07_validation_leakage_splits.md) -> [08](08_baselines.md).
- Ревью design doc: начать с [04](04_design_doc.md), затем проверить данные, метрики, validation, baseline, integration, monitoring и ownership.
- Плохие метрики или непонятная деградация: [05](05_metrics_losses.md) -> [07](07_validation_leakage_splits.md) -> [09](09_error_analysis.md) -> [12](12_measuring_ab_reporting.md).
- Production-риск: [13](13_integration_api_release_fallbacks.md) -> [14](14_serving_inference_optimization.md) -> [15](15_monitoring_ownership_maintenance.md).

## Lifecycle Map

1. Понять, какую проблему решаем и зачем.
2. Исследовать пространство решений: build-vs-buy, аналоги, ограничения, декомпозиция.
3. Зафиксировать design doc с целями, антицелями, рисками и tradeoffs.
4. Выбрать loss и метрики, связанные с продуктом и бизнесом.
5. Спроектировать данные, labels, metadata и воспроизводимый data pipeline.
6. Выбрать validation schema, которая похожа на production.
7. Построить baseline как рабочую точку сравнения и потенциальный fallback.
8. Делать error analysis вместо слепого перебора моделей.
9. Упаковать обучение в воспроизводимый training pipeline.
10. Управлять features и feature store только когда это действительно окупается.
11. Измерить реальный эффект через simulation, human evaluation, A/B и reporting.
12. Интегрировать систему через API, release process, fallbacks и operations.
13. Оптимизировать serving после profiling и требований.
14. Поддерживать monitoring, ownership, документацию и контроль сложности.

## Как Агенту Использовать Базу

Сначала агент должен задавать вопросы, а не предлагать модель. Минимальный порядок: problem statement, цели и антицели, цена ошибки, baseline, validation, данные, метрики, integration, fallback, monitoring, ownership. Если один из блоков отсутствует, архитектура еще не готова к серьезному решению.

## Topic Map

- Основы, problem framing, preliminary research.
- Design document.
- Metrics/losses, data, validation, baselines.
- Error analysis, training pipelines, features, measuring/reporting.
- Integration, monitoring, serving, ownership и maintenance.

## Update Policy

Эти файлы должны расти как рабочие инструкции: добавлять новые практические уроки, чеклисты, failure modes и design-review вопросы. Не нужно превращать их в учебник по алгоритмам. Любое расширение вне текущей базы нужно явно помечать как `external extension`.
