# Product Design Knowledge Base

Эта папка — прикладная база знаний по продуктовому дизайну для агентов. Основа включает публичные материалы Product Talk, SVPG, Microsoft HAX, Google PAIR, zeroheight и страницы/образцы Rosenfeld Media по `Interviewing Users` и `Design That Scales`. Дополнения о продуктовых решениях, ролях, прототипах и проверке предположений опираются также на Марти Кагана, «Вдохновленные», МИФ, 2020, ISBN 9785001464310. Это самостоятельно сформулированные практические рекомендации: опыт автора и кейсы не являются сравнительным доказательством эффективности или универсальными нормативами. Ограничения прежних источников сохраняются; эта книга не расширяет покрытие книг Rosenfeld.

Практическая рабочая модель для агента: как проектировать продукт, валидировать решения, делать AI/ML UX, писать UI/UX и код с продуктовой ответственностью, строить design systems как инфраструктуру и связывать решения с бизнес-выгодой.

## Как Читать

Выбирать только нужную для задачи ветку. Использовать известный контекст и принятые решения; для ограниченной правки не запускать заново discovery и не заполнять весь набор артефактов. Глубина проверки зависит от существенной неопределенности и последствий решения.

- Новый продукт или фича: [02](02-product-operating-model.md) -> [03](03-discovery-and-opportunity-solution-trees.md) -> [04](04-user-research-and-interviewing.md) -> [05](05-validation-and-assumption-tests.md) -> [11](11-business-outcomes-and-product-metrics.md).
- AI/ML-продукт: [06](06-ai-ml-product-ux.md) -> [07](07-calibrated-trust-and-human-control.md) -> [05](05-validation-and-assumption-tests.md) -> [08](08-ui-ux-product-quality.md).
- UI/UX review: [08](08-ui-ux-product-quality.md) -> [07](07-calibrated-trust-and-human-control.md) -> [12](12-agent-product-design-checklists.md) -> [13](13-anti-patterns.md).
- Design system: [09](09-design-systems-as-product.md) -> [10](10-design-system-governance-adoption-metrics.md) -> [11](11-business-outcomes-and-product-metrics.md).
- Быстрая подготовка агента: [01](01-terminology.md) -> [12](12-agent-product-design-checklists.md) -> [13](13-anti-patterns.md).

## Основная Модель

При открытом продуктовом выборе начать с outcome: какое поведение пользователя, бизнес-результат или качество системы должно измениться. Затем исследовать opportunities — реальные потребности, боли и желания клиентов — и сравнить solutions. При реализации принятого решения использовать уже установленные основания.

Оценивать существенную неопределенность по четырем рискам, используя имеющиеся свидетельства:

1. `value`: действительно ли это нужно пользователю или клиенту.
2. `usability`: сможет ли пользователь этим воспользоваться.
3. `feasibility`: сможет ли команда это построить и поддерживать.
4. `viability`: будет ли это работать для бизнеса, права, операционной модели и стратегии.

AI и design systems не меняют этот порядок. AI-фича должна доказать, что AI дает уникальную ценность по сравнению с правилами, обычным UX, ручным workflow или vendor-решением. Design system должна быть продуктом и инфраструктурой с adoption, governance, документацией, метриками и владельцами, а не только UI kit.

## Файлы

- [01-terminology.md](01-terminology.md): общий словарь терминов и различия между похожими понятиями.
- [02-product-operating-model.md](02-product-operating-model.md): outcomes over output, empowered teams, discovery/delivery и четыре риска.
- [03-discovery-and-opportunity-solution-trees.md](03-discovery-and-opportunity-solution-trees.md): Opportunity Solution Trees и continuous discovery.
- [04-user-research-and-interviewing.md](04-user-research-and-interviewing.md): интервью, research questions, fieldwork inputs, synthesis.
- [05-validation-and-assumption-tests.md](05-validation-and-assumption-tests.md): assumption tests, experiments, readiness to build.
- [06-ai-ml-product-ux.md](06-ai-ml-product-ux.md): когда AI нужен, data needs, reward function, AI UX.
- [07-calibrated-trust-and-human-control.md](07-calibrated-trust-and-human-control.md): trust, confidence, correction, fallback, global controls.
- [08-ui-ux-product-quality.md](08-ui-ux-product-quality.md): продуктовые требования к UI/UX и implementation quality.
- [09-design-systems-as-product.md](09-design-systems-as-product.md): design system как organizational practice и software product.
- [10-design-system-governance-adoption-metrics.md](10-design-system-governance-adoption-metrics.md): governance, contribution, adoption, buy-in, metrics.
- [11-business-outcomes-and-product-metrics.md](11-business-outcomes-and-product-metrics.md): outcome metrics, business value, leading/lagging indicators.
- [12-agent-product-design-checklists.md](12-agent-product-design-checklists.md): рабочие чеклисты для агента.
- [13-anti-patterns.md](13-anti-patterns.md): red flags и плохие паттерны.

## Как Агенту Использовать Базу

При открытом продуктовом выборе связать problem framing, outcome, opportunity и возможные solutions, затем выбрать проверку существенных assumptions. При выполнении заданного решения выявить только пробелы, способные изменить работу.

Вопросы для существенного продуктового решения; использовать применимые пункты:

1. Сформулировать пользователя, контекст, business problem и desired outcome.
2. Назвать known opportunities и evidence signal.
3. Разделить opportunities, solutions и assumptions.
4. Проверить value, usability, feasibility, viability risks.
5. Для AI - проверить, нужен ли AI, как будут устроены uncertainty, correction, fallback, feedback и controls.
6. Для UI - проверить states, errors, accessibility, instrumentation и соответствие design system.
7. Для design system - проверить adoption, governance, contribution path, documentation и metrics.
8. Зафиксировать, что неизвестно и какой test даст следующий сильный сигнал.

## Update Policy

Новые материалы можно добавлять как практические заметки, checklists, examples и anti-patterns. Если идея выходит за пределы текущей базы, помечайте ее как `extension`. Если материал мог устареть, особенно report, tooling или AI guidance, проверяйте актуальность отдельно.
