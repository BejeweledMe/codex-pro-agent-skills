# Product Operating Model

Related: [terminology](01-terminology.md), [validation](05-validation-and-assumption-tests.md), [business metrics](11-business-outcomes-and-product-metrics.md), [checklists](12-agent-product-design-checklists.md)

## Главный Сдвиг

Product operating model переносит фокус с output на outcomes. Команда существует не для того, чтобы закрывать список фич, а чтобы решать важные проблемы клиентов и бизнеса. Если команде выдали уже выбранное решение, discovery почти закончилась до того, как команда начала думать.

Практическое правило: формулировка работы должна выглядеть как `улучшить X outcome для Y пользователей в Z контексте`, а не как `сделать экран/кнопку/модель`.

## Пять Опор

В SVPG-рамке полезно мыслить пятью блоками:

1. `Product culture`: организация ценит learning, evidence, customer value и business results.
2. `Product strategy`: лидеры выбирают критичные проблемы и объясняют bets, focus и reasoning.
3. `Product teams`: durable cross-functional teams получают контекст и ownership.
4. `Product discovery`: команда быстро проверяет, какое решение valuable, usable, feasible и viable.
5. `Product delivery`: команда надежно строит, тестирует, релизит, измеряет и поддерживает solution.

Если один блок отсутствует, остальные деградируют. Например, discovery без delivery становится research theater, а delivery без discovery становится feature factory.

## Роли В Команде

PM отвечает за value и viability: стоит ли это делать и работает ли это для бизнеса. Product designer отвечает за usability и customer experience. Tech lead/engineer отвечает за feasibility и delivery. На практике зоны пересекаются: хороший engineer участвует в discovery, хороший designer понимает constraints, хороший PM понимает техническую и операционную цену решения.

Опасный сигнал: инженер появляется только после утверждения макета, а designer - только для `сделать красиво`.

## Четыре Риска

Перед build commitment команда должна понять:

- `value risk`: пользователь или buyer достаточно сильно хочет результат?
- `usability risk`: сможет ли пользователь достигнуть результата без лишней нагрузки?
- `feasibility risk`: можем ли мы построить это с нужным качеством, latency, cost, privacy, reliability?
- `viability risk`: выдержат ли это бизнес-модель, legal, support, sales, brand, operations?

Для AI-продуктов feasibility включает data/model quality, monitoring, fallback и evaluation. Для design systems viability включает adoption, contribution cost и способность команды поддерживать систему.

## Discovery И Delivery Не Враги

Discovery снижает риск, что команда построит не то. Delivery снижает риск, что нужное решение окажется ненадежным, дорогим или неподдерживаемым. Продуктовая команда должна делать оба цикла.

Delivery quality в product model включает:

- small, frequent, uncoupled releases;
- instrumentation;
- monitoring;
- deployment infrastructure;
- experiments and rollback paths.

## Как Агенту Применять

Перед тем как предлагать реализацию, агент должен ответить:

- Какой outcome меняем?
- Кто пользователь, buyer, affected stakeholder?
- Какие opportunities уже подтверждены evidence?
- Какие alternatives кроме выбранной solution рассмотрены?
- Какие четыре риска не проверены?
- Как будет измерен effect после релиза?
- Кто владеет product, design, engineering, support и monitoring после запуска?

## Red Flags

- Strategy выглядит как список фич.
- Команда не может назвать outcome, но уже оценивает сроки.
- Stakeholders выбирают solution, а команде оставляют только delivery.
- Нет instrumentation, поэтому после релиза невозможно узнать, сработало ли решение.
- Риски value/usability/feasibility/viability обсуждаются по отдельности разными людьми и слишком поздно.

## Source Notes

SVPG описывает model на уровне принципов. Это не prescriptive process manual и не единственный способ организации product work. Используйте как operating lens, а конкретные rituals выбирайте под контекст.
