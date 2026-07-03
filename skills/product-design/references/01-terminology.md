# Core Product Design Terms

Related: [operating model](02-product-operating-model.md), [discovery](03-discovery-and-opportunity-solution-trees.md), [AI UX](06-ai-ml-product-ux.md), [design systems](09-design-systems-as-product.md)

## Outcome

`Outcome` - измеримый результат, который команда хочет изменить. В product discovery чаще всего полезен product outcome: поведение пользователя или sentiment, на который команда реально может влиять. Business outcome важен, но иногда слишком далек от ежедневной работы команды. Feature adoption metric слишком узкая, если она измеряет только использование одной фичи.

Хороший outcome:

- связан с ценностью для пользователя и бизнеса;
- достаточно конкретен, чтобы ограничить discovery;
- не является заранее заданной solution;
- имеет owner и временной горизонт;
- может быть измерен до и после изменений.

## Opportunity

`Opportunity` - неудовлетворенная потребность, боль или желание клиента. Это не фича и не экран. Opportunity должна быть выявлена через реальные evidence: интервью, наблюдения, support/sales сигналы с контекстом, аналитика, research synthesis.

Проверка: если формулировку можно закрыть только одним способом, это, вероятно, solution in disguise. Нужно спросить `why` и найти потребность глубже.

## Solution

`Solution` - конкретный способ закрыть opportunity: фича, сервис, workflow, UI, документация, автоматизация, ручной процесс, design system component, ML-модель или non-ML решение.

Solution должна конкурировать с альтернативами. Если команда рассматривает только одну solution, она обычно валидирует любимую идею, а не исследует problem space.

## Assumption Test

`Assumption test` - проверка рискованного предположения до полной реализации. Тест должен быть выбран по риску, а не по удобству. В Product Talk логика такая: выбрать target opportunity, предложить несколько solutions, разложить их на assumptions и тестировать самые рискованные assumptions среди этих solutions.

Примеры assumptions:

- пользователю важна эта opportunity;
- пользователь поймет предложенный UI;
- модель сможет выдать качество в нужном latency/cost budget;
- бизнес может поддержать новый workflow;
- design system сможет покрыть новый use case без разрыва consistency.

## Product Trio

`Product trio` - ядро продуктового мышления: product manager, product designer и engineer/tech lead. Идея не в том, что только три человека принимают решения, а в том, что value, usability и feasibility должны обсуждаться вместе, рано и постоянно.

## Product Operating Model

`Product operating model` - способ работы организации, где durable cross-functional teams получают problems/outcomes, а не список фич. Команды делают discovery, delivery, instrumentation и отвечают за результаты.

В этой базе термин используется в духе SVPG: product culture, product strategy, product teams, product discovery и product delivery должны работать как связанная система.

## Value, Usability, Feasibility, Viability

Четыре риска продукта:

- `value`: нужно ли это пользователю, решает ли реальную opportunity;
- `usability`: сможет ли пользователь понять и эффективно использовать решение;
- `feasibility`: может ли команда построить, интегрировать и поддерживать решение;
- `viability`: совместимо ли решение с бизнесом, legal, sales, support, pricing, operations и стратегией.

Риски надо проверять до больших delivery commitments.

## Calibrated Trust

`Calibrated trust` - доверие пользователя, соответствующее реальным возможностям и ограничениям системы. Для AI/ML-продуктов цель не в максимальном доверии, а в правильном: пользователь должен знать, когда принять результат, когда перепроверить, когда исправить и когда перейти к fallback.

## Human Control

`Human control` - возможность пользователя вызвать, отклонить, исправить, отменить, настроить или обойти автоматизацию. В AI UX контроль особенно важен при high-stakes решениях, неопределенности, персонализации и долгосрочном learning/adaptation.

## Design System Practice

`Design system practice` - организационная практика, а не только Figma kit или React package. В нее входят design language, components, tokens, code, documentation, contribution process, governance, release process, community, metrics и adoption.

## Governance

`Governance` - правила и процессы, которые определяют, кто владеет системой, кто может предлагать изменения, как принимаются решения, как проходят review/release, как документируются изменения и как система остается consistent без блокирования продуктовых команд.

## Adoption

`Adoption` - реальное использование системы или подхода в product workflows. Для design system это usage в design tools, code, docs, product releases и contribution behavior. Для product operating model это не наличие слов `outcome` в документах, а реальные decisions, discovery cycles, instrumentation и accountability.

## Anti-Confusions

- `Outcome` не равно `output`: output - что поставили, outcome - что изменилось.
- `Opportunity` не равно `solution`: opportunity - почему стоит действовать, solution - как.
- `Discovery` не равно brainstorming: discovery требует evidence и tests.
- `AI confidence` не равно user trust: confidence можно показать плохо и ухудшить decision quality.
- `Design system` не равно component library: без adoption, governance и docs библиотека не становится системой.
