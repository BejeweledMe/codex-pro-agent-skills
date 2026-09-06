# LLM: Выбор Модели И Адаптация

> **Совместимый обзор.** Для нового LLM-продукта сначала используйте
> `$llm-system-design`; для выбора text-model family, SFT/PEFT, tokenizer и
> adaptation workflow используйте `$nlp-modeling-and-adaptation`. Этот файл сохранён
> для существующих маршрутов и даёт только краткий lifecycle context.

## Начать С Поведения, Не С Названия Модели

Зафиксируйте задачу, цену ошибки, язык и модальность, допустимые данные и размещение, licence/contract constraints, контекст, latency/volume/budget, target audience и fallback. Создайте task-specific evaluation slices до выбора модели. Leaderboard без совпадающего task contract не является решением.

## Лестница Изменений

Разделяйте проблему знания/grounding, поведения/style и компетенции:

1. Упростить продуктовый контракт, prompt, structured output или deterministic validation.
2. Использовать retrieval, когда нужен свежий, проверяемый или доступо-ограниченный внешний факт.
3. Рассмотреть SFT/PEFT для устойчивого поведения или формата при достаточных примерах и regression eval.
4. Рассматривать более дорогую адаптацию только когда простой путь измеримо не закрывает задачу.

Не начинать preference optimisation без качественных preference pairs, нужной evaluation policy и бюджета на повторяемые циклы. Адаптация не заменяет data quality, access control, evals или release discipline.

## Model Bundle

Версионируйте вместе base model, tokenizer, chat template, adapter, data and split, training configuration, runtime, prompt/policy, evaluation report и license decision. Смена tokenizer/template/adaptor может менять поведение так же существенно, как смена модели.

## Evidence And Rollback

Сравнивайте domain slices с general and safety regressions, quality/cost/latency and data-risk evidence. Выпускайте через ограниченный маршрут и держите previous verified bundle. Для RAG component design передайте работу `$rag-engineering`; для behavioral release gate используйте `$agent-llm-evals`.

For neural step execution, precision/memory/collectives and coherent restart,
use `$neural-training-systems` with the NLP owner's objective, tokenizer,
data/order/batch assumptions and quality gate. Shared job capacity, registry
and deployment infrastructure belong to `$ai-platform-llmops`; model selection
and adaptation acceptance remain with the model owner.

## Quality Bar

Не задавайте универсальные числа примеров, GPU или quality thresholds. Проверяйте актуальные licence, runtime support и provider claims непосредственно перед конкретным выбором.
