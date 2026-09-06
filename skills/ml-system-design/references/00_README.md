# ML System Design Knowledge Base

Прикладная база знаний для агентов: как проектировать, ревьюить, запускать и сопровождать ML-системы.

## Как Читать

- Новый ML-проект: [01](01_principles_process_agent_checklist.md) -> [02](02_problem_framing.md) -> [03](03_preliminary_research_build_vs_buy.md) -> [04](04_design_doc.md) -> [05](05_metrics_losses.md) -> [06](06_data_labeling_metadata.md) -> [07](07_validation_leakage_splits.md) -> [08](08_baselines.md).
- Ревью design doc: начать с [04](04_design_doc.md), затем проверить данные, метрики, validation, baseline, integration, monitoring и ownership.
- Плохие метрики или непонятная деградация: [05](05_metrics_losses.md) -> [07](07_validation_leakage_splits.md) -> [09](09_error_analysis.md) -> [12](12_measuring_ab_reporting.md).
- Production-риск: [13](13_integration_api_release_fallbacks.md) -> [14](14_serving_inference_optimization.md) -> [15](15_monitoring_ownership_maintenance.md).
- Computer vision product or pipeline: start with `$computer-vision-system-design`;
  use the dedicated CV data, modeling, evaluation, or inference owner when that
  decision is already clear. This base remains a companion for generic ML lifecycle.
- LLM-продукт: начать с `$llm-system-design`; этот skill остаётся владельцем
  классического ML lifecycle и является companion для общих data/validation/training
  вопросов.
- Выбор/adaptation text/LLM model: `$nlp-modeling-and-adaptation`. [16](16_llm_model_selection_and_adaptation.md)
  остаётся кратким совместимым обзором.
- Self-hosted LLM и bottleneck inference: `$llm-inference-optimization`. [17](17_llm_inference_serving_and_bottleneck_diagnosis.md)
  остаётся кратким совместимым обзором; для generic ML serving используйте
  [14](14_serving_inference_optimization.md).

## Focused Decision Routes

The numbered references remain the connected predictive/classical ML lifecycle.
Use only the modules needed for the current decision.

| Question | Reference |
| --- | --- |
| Do we need ML, should we build or buy, and how ambitious should the first release be? | [Problem framing](02_problem_framing.md), [alternatives and ambition](03_preliminary_research_build_vs_buy.md), [baselines](08_baselines.md) |
| Does the metric imply affordable errors and review workload? | [Metrics and operating points](05_metrics_losses.md) |
| Does selected data improve quality or total cost without losing coverage? | [Data and selection economics](06_data_labeling_metadata.md) |
| Have selection and repeated tuning contaminated the release estimate? | [Validation and evaluation surfaces](07_validation_leakage_splits.md) |
| Why is training failing, and what should change next? | [Error analysis](09_error_analysis.md), [training lifecycle](10_training_pipelines.md) |
| What do replay, shadow, canary, A/B and rollout prove? | [Measurement](12_measuring_ab_reporting.md) |
| Can the exact released behavior be traced, disabled and recovered? | [Release and fallback contracts](13_integration_api_release_fallbacks.md), [ownership and response](15_monitoring_ownership_maintenance.md) |
| Is a speed, cost or energy comparison valid for this workload? | [Benchmark contract and claims](benchmark-contract-and-claims.md) |
| Should execution be in the cloud, on devices, or split across tiers? | [Deployment placement and device envelope](deployment-placement-and-device-envelope.md) |

ML retains product/data/split/objective validity and generic predictive serving.
Use `$data-engineering` for pipeline/event-time/replay mechanics,
`$neural-training-systems` for neural step/memory/precision/collective/restart
mechanics, and `$ai-platform-llmops` for fleet capacity, registry, scheduling and
controllers. Pass semantic constraints and receive implementation evidence;
handoff does not transfer model selection or release quality authority.
References [16](16_llm_model_selection_and_adaptation.md) and
[17](17_llm_inference_serving_and_bottleneck_diagnosis.md) remain compatibility bridges.

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
15. Для LLM передать архитектуру, adaptation и serving соответствующим LLM skills;
    использовать эту базу для общих lifecycle решений.

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
