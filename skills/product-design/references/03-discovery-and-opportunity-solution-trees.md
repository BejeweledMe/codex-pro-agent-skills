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

## Stakeholder Communication

OST помогает рассказывать stakeholders не только `что мы строим`, но и `почему`. Разные stakeholders требуют разного уровня детализации:

- близким к работе можно показать interviews, assumptions и tests;
- senior stakeholders часто нужны top-level opportunities, target opportunity, decision rationale и expected outcome.

## Связь С Roadmap

В date-based roadmap обычно попадают solutions, уже сопоставленные с opportunities и проверенные assumption tests. В outcome-oriented roadmap могут попадать outcomes, opportunities и candidate solutions.

OST не заменяет product vision. Vision говорит, куда идет продукт; OST помогает выбрать путь к конкретному outcome.

## Agent Checklist

- Outcome измерим и не является фичей?
- Есть evidence по target customer и value proposition?
- Opportunities взяты из customer stories, а не придуманы?
- Opportunity можно решить несколькими ways?
- Есть selected target opportunity?
- Рассмотрено несколько solutions?
- У каждой solution есть assumptions?
- Самые рискованные assumptions проверены до build?
- Decision rationale понятен stakeholders?

## Red Flags

- Opportunity сформулирована как `нужна кнопка`, `добавить чат`, `сделать dashboard`.
- Дерево построено на opinions команды, а не на discovery inputs.
- Одна company-wide OST пытается покрыть все teams и outcomes.
- Команда работает над несколькими unrelated outcomes одним деревом.
- Effort оценивается на opportunity level до генерации solutions.
