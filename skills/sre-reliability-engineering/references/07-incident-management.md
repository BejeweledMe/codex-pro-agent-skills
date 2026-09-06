# 07. Incident Management

## Суть

Инцидент-менеджмент превращает хаос аварии в управляемый процесс. Важна не только техническая починка, но и координация, коммуникация, фиксация фактов и доведение корректирующих действий до конца.

Используйте lifecycle из пяти стадий:

1. Обнаружен.
2. Устраняется.
3. Устранён.
4. Разбор завершён.
5. Все работы завершены.

Инцидент не закрыт на стадии "сервис восстановлен". Он закрыт только когда выполнены действия, снижающие риск повторения. Иначе команда тушит один и тот же класс проблем снова.

## Практики

- Назначайте роли явно в первые минуты:
  - Incident Commander: координация, решения, эскалация, статус.
  - Operations Lead: техническое расследование и распределение задач.
  - Communications Lead: обновления для бизнеса, клиентов, status page и других команд.
- Scale staffing to impact. A small incident may combine responsibilities; keep coordination, technical action, and communication explicit, and separate them when the workload makes combination unsafe. The IC must retain the capacity to track impact, time, hypotheses, decisions, and escalation.
- Ведите debug doc с первой минуты:
  - старт инцидента;
  - impact;
  - роли;
  - timeline;
  - гипотезы;
  - проверенные факты;
  - решения;
  - что осталось для postmortem.
- Разделяйте trigger и cause:
  - trigger: событие, запустившее отказ;
  - cause: системные условия, которые сделали отказ возможным.
- Держите два канала:
  - рабочий канал для тех, кто чинит;
  - канал обновлений для бизнеса и наблюдателей.
- Для плановых работ используйте тот же уровень дисциплины:
  - written plan;
  - rollback plan;
  - dry-run;
  - pre-checks и post-checks;
  - capacity check;
  - criteria for rollback;
  - owner и escalation contacts.
- Сокращайте diagnosis time через:
  - dashboard зависимостей;
  - runbooks;
  - queue metrics;
  - recent changes;
  - debug doc;
  - тренировочные инциденты.

## Executable planned work

For a risky transition, make the plan usable under stress. A small reversible
change may need only a short checklist; migrations and authority changes need
more explicit state and recovery evidence.

| Plan element | Required operational meaning |
| --- | --- |
| Identity and preconditions | Exact target, candidate/configuration/state version, current health, required access, dependencies, and starting state |
| Capacity reserve | Space for temporary copies/logs, concurrent workload, rebuild/restore, and remaining serving capacity; derive reserve from measured demand rather than a universal multiplier |
| Actions and postconditions | Tested commands or tool operations with parameters, expected result, observation, and next permitted step |
| Recovery path | Rehearsed rollback or safe roll-forward, compatible state, restore duration/capacity, and who can execute it |
| Points of no return | The step after which rollback is unsafe or unavailable, and the alternate recovery action |
| Abort and incident triggers | Explicit elapsed-time, user-impact, capacity, integrity, or loss-of-observability limits, with the owner who stops work |
| Completion | CUJ probes, state/integrity checks, resumed normal controls, cleanup, and a recorded outcome |

Rehearse consequential steps against representative versions and data volume.
Dry-run output alone does not prove restore capacity or postconditions.
At a trigger, stop promotion and execute the pre-agreed recovery branch; do not
extend the window repeatedly because completion seems close. If that branch is
unsafe or fails, enter incident coordination and escalate with the observed state.
Avoid improvising a new migration or recovery design while fatigued.

For a queue incident, first compare arrivals, successful processing, growth, lag,
and oldest work; an empty queue may mean failed ingestion. For a green component
dashboard with failed customer outcomes, follow the entire journey through
routing and dependencies. See [04-monitoring.md](04-monitoring.md).

For integrity, uncertain external effects, or lost recovery authority, use
[16-recovery-and-integrity.md](16-recovery-and-integrity.md). Separate restored
serving from verified recovery and the later completion of corrective work.

Source: *SRE: Коллективный разум*, Chapter 8 planned work and incident diagnosis.

## Антипаттерны

- Все чинят, никто не координирует.
- Роли предполагаются молча, а не назначаются явно.
- IC одновременно принимает решения, пишет команды и отвечает менеджменту.
- В аварийный звонок добавляют всех подряд.
- Timeline восстанавливается по памяти через неделю.
- Инцидент закрывается сразу после восстановления сервиса.
- Плановые работы проводятся ночью "по памяти".
- Фраза "релиз виноват" заменяет анализ причин.
- "Не на нашей стороне" закрывает инцидент без проверки end-to-end пути.

## Как валидировать

Проведите tabletop или fire drill:

1. Сымитируйте P1/P2 сценарий.
2. Дежурный принимает алерт и становится временным IC.
3. Assign responsibilities within the agreed mobilization window; five minutes is an illustrative drill target.
4. Создаётся debug doc.
5. IC публикует первый статус.
6. Operations Lead распределяет 2-3 параллельные гипотезы.
7. Communications Lead отправляет регулярные обновления.
8. После drill создаётся postmortem или короткий learning review.

Метрики процесса:

- MTTD: время обнаружения.
- MTTA: время подтверждения.
- MTTM: время мобилизации команды.
- MTTR: время восстановления.
- MTTRC: время до понимания причин.
- Доля инцидентов с закрытыми P1/P2 action items.
- Доля инцидентов с debug doc.

MTTD/MTTA/MTTR and related timings describe response performance. Compare incident
distributions, severity, frequency, user impact, and budget consumption; a lower
average MTTR alone does not prove better reliability. Define restoration and
closure consistently so changing labels cannot manufacture improvement.

Признак зрелости: любой новый участник инцидента за 2 минуты читает debug doc и понимает статус, impact, проверенные гипотезы и следующий шаг.

## Связанные темы

- [06-alerting.md](06-alerting.md)
- [08-postmortems.md](08-postmortems.md)
- [09-oncall.md](09-oncall.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
