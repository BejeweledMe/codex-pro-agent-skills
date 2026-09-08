# Discovery And Opportunity Solution Trees

Related: [user research](04-user-research-and-interviewing.md), [validation](05-validation-and-assumption-tests.md), [business metrics](11-business-outcomes-and-product-metrics.md), [anti-patterns](13-anti-patterns.md)

## Что Такое OST

Opportunity Solution Tree - визуальная карта путей к desired outcome. В дереве:

1. Вверху находится desired outcome.
2. Ниже - opportunity space: потребности, боли и желания клиентов.
3. Ниже - solution space: возможные решения для selected opportunity.
4. Еще ниже - assumption tests: проверки, которые помогают выбрать, что строить.

OST полезно не как красивая диаграмма, а как shared thinking tool. Оно показывает, почему команда выбрала именно эту opportunity и почему solution стоит строить.

## Prerequisites

Перед первым деревом нужны:

- гипотеза о target customer и value proposition;
- clearly defined outcome;
- минимум несколько story-based customer interviews, чтобы не выдумывать opportunities из головы.

Если inputs слабые, дерево будет выглядеть структурно, но окажется фикцией.

## Outcome Вверху

Product Talk рекомендует ставить product outcome, потому что он обычно достаточно близок к команде. Business outcome может быть слишком широким, traction metric одной фичи - слишком узким.

Outcome задает scope discovery. Если outcome меняется, дерево может стать нерелевантным.

## Opportunity Space

Opportunity - это не `сделать экспорт`, не `добавить AI`, не `переписать onboarding`. Это потребность, боль или желание: что пользователь пытается сделать, что мешает, чего он хочет, почему это важно.

Как искать:

- story-based interviews: конкретные истории о прошлом поведении;
- experience maps: моменты в journey, где возникают opportunities;
- support/sales/product analytics как inspiration, но с осторожностью: часто там нет контекста.

Важно не overreact to latest signal. Один support ticket может быть важным, но без context и comparison он не должен автоматически становиться roadmap.

Дополнительные источники гипотез: выполнить часть работы вручную после обучения у пользователя; исследовать повторяющееся неожиданное использование продукта. Сначала понять задачу и ограничения поведения. Наблюдение не обязывает поддерживать любой обходной путь, автоматизировать работу или открывать API.

## Solution Space

Для target opportunity нужно придумать несколько решений. Не стоит brainstorming решений по всему дереву сразу: это размывает фокус. Product Talk предлагает выбрать несколько promising ideas и разложить их на assumptions.

Пример:

- Opportunity: пользователь не понимает, почему AI-рекомендация подходит ему.
- Solutions: explanation panel, source citations, confidence hint, editable preferences, compare alternatives.
- Assumptions: explanation повысит correct reliance; sources доступны; пользователи поймут confidence; UI не замедлит task.

## Assumption Tests

Тестируйте самые рискованные assumptions среди нескольких solutions. Цель - не доказать любимую идею, а быстрее понять, какая solution создает customer value и business value.

После тестов команда может:

- отказаться от ideas и сгенерировать новые;
- доработать одну solution и перейти к delivery;
- признать, что opportunity не стоит усилий или сейчас не достижима;
- вернуться к opportunity selection.

## Ограниченный Discovery Sprint

Для трудного вопроса, явно медленного цикла обучения или освоения discovery можно предложить ограниченную совместную работу. Выбрать вопрос, участников, время и методы по препятствию; результатом становятся наблюдения, оставшаяся неопределенность и следующее решение. Окончание sprint не подтверждает готовность к выпуску. Если нужен coach, оценивать опыт решения обнаруженного пробела: delivery-опыт сам по себе не устанавливает компетенцию в discovery или бизнес-модели. Фиксированный пятидневный сценарий и новый OST не обязательны.

## Stakeholder Communication

OST помогает рассказывать stakeholders не только `что мы строим`, но и `почему`. Разные stakeholders требуют разного уровня детализации:

- близким к работе можно показать interviews, assumptions и tests;
- senior stakeholders часто нужны top-level opportunities, target opportunity, decision rationale и expected outcome.

## Связь С Roadmap

В date-based roadmap обычно попадают solutions, уже сопоставленные с opportunities и проверенные assumption tests. В outcome-oriented roadmap могут попадать outcomes, opportunities и candidate solutions.

OST не заменяет product vision. Vision говорит, куда идет продукт; OST помогает выбрать путь к конкретному outcome.

Проверить, не воспринимаются ли candidate solutions как уже обещанный scope. Roadmap сохраняет приоритеты и координацию важных дат; различать период оценки outcome, прогноз и обязательство по поставке. Для обещания использовать [основание обязательства](02-product-operating-model.md#основание-для-обязательства). Смена формата roadmap сама по себе не отменяет договоренности.

## Story Map Для Связного Scope

Если плоский backlog скрывает целостность сценария, дополнить OST картой действий пользователя: ход работы, задачи/истории под действиями и границы связных поставок. OST объясняет выбор opportunity и решений; story map проверяет, можно ли завершить задачу выбранным набором историй. Пересматривать карту по наблюдениям прототипа. Например, экспорт без поиска нужных записей и подтверждения результата может закрыть тикеты, оставив работу незавершенной. Карта не подтверждает ценность функций и не нужна для каждой небольшой правки.

## Agent Checklist

Использовать для работы с OST; это не обязательный цикл для заданной реализации.

- Outcome измерим и не является фичей?
- Есть evidence по target customer и value proposition?
- Opportunities взяты из customer stories, а не придуманы?
- Opportunity можно решить несколькими ways?
- Есть selected target opportunity?
- Рассмотрено несколько solutions?
- У каждой solution есть assumptions?
- Существенные assumptions проверены либо явно приняты как остаточный риск при решении о build?
- Decision rationale понятен stakeholders?

## Red Flags

- Opportunity сформулирована как `нужна кнопка`, `добавить чат`, `сделать dashboard`.
- Дерево построено на opinions команды, а не на discovery inputs.
- Одна company-wide OST пытается покрыть все teams и outcomes.
- Команда работает над несколькими unrelated outcomes одним деревом.
- Effort оценивается на opportunity level до генерации solutions.

## Дополнительный Источник

Ограниченный discovery sprint, ручное выполнение работы, story map и уточнения roadmap — синтез по «Вдохновленным» Марти Кагана; см. [границы источника](00-index.md). Они дополняют Product Talk OST, не заменяют его prerequisites и не составляют полный метод story mapping.
