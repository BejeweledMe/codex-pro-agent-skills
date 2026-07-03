# Validation And Assumption Testing

Related: [operating model](02-product-operating-model.md), [discovery](03-discovery-and-opportunity-solution-trees.md), [AI UX](06-ai-ml-product-ux.md), [business metrics](11-business-outcomes-and-product-metrics.md), [checklists](12-agent-product-design-checklists.md)

## Что Валидируем

Валидация - не финальный gate перед релизом, а постоянное снижение риска. Команда должна проверять assumptions, которые могут сломать customer value, business value или delivery.

Минимальные категории:

- `desirability/value`: нужна ли пользователю или buyer эта ценность;
- `usability`: сможет ли пользователь пройти flow;
- `feasibility`: можем ли построить с нужными data, quality, latency, reliability, cost;
- `viability`: выдержат ли бизнес, support, compliance, pricing, operations;
- `measurement`: сможем ли доказать effect после релиза;
- `maintenance`: сможем ли сопровождать, обновлять и мониторить.

## Как Выбирать Assumption Test

Хороший test отвечает на конкретный risk. Он не обязан быть A/B test. Это может быть interview, prototype test, concierge test, Wizard of Oz, technical spike, policy review, data audit, offline eval, pilot, beta, shadow mode или design review.

Порядок:

1. Сформулировать candidate solutions.
2. Разложить каждую на assumptions.
3. Оценить impact, uncertainty и cost of learning.
4. Сначала тестировать assumptions с высоким impact и uncertainty.
5. Решить заранее, что изменит decision.

## Не Путать Evidence И Permission

Validation не должна быть ритуалом, который легитимизирует уже принятое решение. Если test не может изменить decision, это не validation, а theater.

Признаки слабого test:

- метрика выбрана после результата;
- sample не похож на target users;
- prototype скрывает самый рискованный момент;
- участникам показывают preferred solution без alternatives;
- success threshold не определен заранее;
- команда игнорирует negative evidence.

## AI/ML Validation

Для AI продукта обычной UX validation недостаточно. Нужно проверять:

- unique AI value: почему не rule-based, heuristic, search/filter, manual workflow;
- data relevance and coverage;
- false positive/false negative cost;
- precision/recall tradeoff с user impact;
- reward/objective function и second-order effects;
- confidence/explanation comprehension;
- fallback при low confidence, timeout, unsafe output, stale data;
- feedback loops and tuning plan;
- monitoring for drift, quality and negative impacts.

Google PAIR отдельно подчеркивает: AI не нужен там, где predictability, full transparency, low cost/speed или high cost of errors важнее потенциальной гибкости AI.

## UI Validation

UI test должен проверять не только happy path:

- empty state;
- loading state;
- error state;
- partial success;
- undo/recovery;
- accessibility;
- mobile/desktop constraints;
- confusing labels;
- privacy/permission comprehension;
- feedback and status visibility.

Для AI UI проверьте, понимает ли пользователь capabilities, limits, confidence и path forward.

## Design System Validation

Design system change нужно проверять как product change:

- решает ли component/token/doc реальную repeated need;
- используют ли teams existing alternatives or hacks;
- есть ли docs, examples, accessibility guidance, code API;
- как изменение пройдет release, migration и versioning;
- не ухудшит ли consistency или contribution process.

## Readiness To Build

Solution готова к build, когда:

- target opportunity clear;
- critical assumptions tested or consciously accepted;
- success metrics defined;
- risk owners named;
- delivery scope small enough;
- instrumentation plan ready;
- fallback/rollback path exists;
- support and maintenance implications understood.

## Agent Checklist

- Какие assumptions могут убить решение?
- Какой самый дешевый credible test для каждого critical assumption?
- Что будет считаться pass/fail?
- Как evidence изменит decision?
- Какие risks нельзя проверить до build и кто их принимает?
- Как будет измерен real outcome после релиза?

## Red Flags

- `Пользователям понравилось` без behavioral evidence.
- `Мы проверим после релиза` без rollback и instrumentation.
- AI eval измеряет только model score, но не user decision quality.
- Usability test проверяет только demo happy path.
- Build начинается до выбора target opportunity.
