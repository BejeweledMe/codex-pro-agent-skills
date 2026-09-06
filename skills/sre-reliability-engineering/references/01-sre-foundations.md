# 01. Основы SRE

## Суть

SRE стоит рассматривать не как должность, стек инструментов или ребрендинг эксплуатации, а как систему обратной связи: определить, что значит "работает", измерять это, анализировать отклонения, улучшать сервис и повторять цикл. Главная сложность обычно не в Prometheus, Kubernetes или найме SRE-инженера, а в организационной ясности: кто владеет сервисом, кому нужен уровень надёжности, что именно обещано пользователю и какие решения меняются из-за измерений.

SRE находится рядом с DevOps и Platform Engineering, но фокус отличается:

- DevOps: скорость и качество доставки изменений.
- SRE: надёжность production и управляемый риск.
- Platform Engineering: внутренние платформы и self-service для команд.

На практике роли часто смешаны, особенно в российских и СНГ-компаниях. Смотрите не на название роли, а на практики: есть ли SLO, error budget, on-call, postmortems, ownership, архитектурные ревью, снижение toil.

Ключевая мысль: надёжность не равна максимальному числу "девяток". Цель SRE - не обещать абсолютную безотказность, а помочь бизнесу выбрать осознанный уровень риска, быстро локализовать сбои, восстанавливаться и не повторять одни и те же ошибки.

## Практики

- Начинать не с инструмента, а с вопроса: кто пользователь сервиса и что для него означает "работает".
- Выбрать 1-3 критичных сервиса или сценария и построить вокруг них минимальный SRE-цикл: SLI, SLO, error budget, алерт, runbook, postmortem.
- Назначить владельца сервиса и владельца пользовательского сценария. Если владелец не найден, SLO не будет приводить к действию.
- Разделять инженерные и бизнес-решения. Инженеры описывают риск, цену вариантов и технические последствия; бизнес выбирает допустимый уровень.
- Фиксировать риск-решения письменно: что решили, кто принял риск, какие последствия ожидаются.
- Оценивать SRE-навыки через production-мышление: timeouts, retries, rollback, observability, resource leaks, graceful shutdown, а не только через YAML или абстрактные алгоритмы.
- Строить мост между разработкой и эксплуатацией через общие SLO, совместные postmortems, self-service и SRE-чемпионов в продуктовых командах.

Минимальный стартовый цикл:

1. Определить критичный сервис или CUJ.
2. Choose the few SLIs that express the journey's success; include quality or freshness immediately when those determine whether the service works.
3. Согласовать SLO и error budget policy.
4. Настроить burn-rate alerting.
5. Провести первый blameless postmortem после реального или учебного инцидента.
6. Закрыть P1/P2 action items.
7. Повторить и масштабировать.

## Choosing how SRE is placed

Choose placement by service scale, operational load, and authority to change contributing causes. These are organizational alternatives, not mandatory maturity stages.

| Model | Useful when | Failure to watch | Operating check |
| --- | --- | --- | --- |
| Dedicated SRE team | Shared expertise and cross-service response justify a separate team | Responders become a repair queue without authority over causes | Product teams retain service ownership and commit capacity to corrective work |
| Embedded SRE | Reliability decisions require deep product context | Isolation duplicates solutions and weakens cross-service learning | Maintain a route for shared standards, learning, and escalation |
| Developer SRE champion | The reliability workload is bounded and does not justify a full-time role | Reliability becomes unpaid or unallocated extra work | Allocate time, backup coverage, and decision rights explicitly |
| Evolving ownership | A central response team is transferring operations to product teams | Handoff occurs before access, skills, or runbooks are ready | Transfer responsibility with readiness evidence and a supported escalation path |

Source: *SRE: Коллективный разум*, discussion of organizational placement models.

## Антипаттерны

- Переименовать Ops в SRE, не меняя практики.
- Начать внедрение SRE с найма "SRE-инженера", когда в компании нет ownership, SLO и процессов.
- Ставить SLO "99.9" без ответа на вопрос, что изменится при нарушении бюджета.
- Требовать 100% надёжности без расчёта стоимости и без понимания, кому она нужна.
- Строить "мониторинг на базе генерального директора", когда о проблемах узнают от руководства или клиентов.
- Считать героические ночные починки зрелостью. Это скорее симптом плохих систем, алертов, on-call и automation.
- Обсуждать DevOps/SRE/Platform как спор о титулах, а не как распределение ответственности.

## Как валидировать

Проверьте команду или сервис по вопросам:

- Может ли команда назвать пользователя сервиса и его критичные действия?
- Есть ли владелец сервиса и владелец критичного пользовательского сценария?
- Есть ли SLO, который реально меняет поведение команды?
- Кто получает алерт и может ли он его исправить?
- Пишутся ли postmortems с action items, которые закрываются?
- Видит ли бизнес надёжность в деньгах, потерянных минутах или нарушенных сценариях, а не только в процентах?
- Есть ли договорённая политика: что делать при сгоревшем error budget?
- Могут ли инженеры объяснить, какие риски приняты осознанно и кем?

Признак зрелости: команда узнаёт о проблеме раньше клиентов, умеет быстро определить влияние, назначить владельца действия и после инцидента улучшает систему, а не только тушит симптом.

## Связанные темы

- [02-slo-sli-sla.md](02-slo-sli-sla.md)
- [03-error-budget.md](03-error-budget.md)
- [07-incident-management.md](07-incident-management.md)
- [08-postmortems.md](08-postmortems.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
