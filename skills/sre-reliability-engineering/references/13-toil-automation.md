# 13. Toil и автоматизация

## Суть

Toil - это ручная, повторяющаяся, автоматизируемая, реактивная работа без долгосрочной ценности, которая растёт линейно с размером сервиса. Не вся ручная работа является toil: postmortem, architecture review и сложное решение о rollback могут быть ценными. Ручной рестарт сервиса каждую ночь - toil.

The Google SRE 50% toil guideline is an organizational reference point, not a
universal staffing rule. Measure recurring work and preserve enough engineering
capacity to reduce it; agree the local target with those who control priorities.

## Практики

- Измеряйте toil, прежде чем автоматизировать:
  - двухнедельный дневник ручных операций;
  - лейбл `toil` в tracker;
  - оценка частоты и времени.
- Считайте Toil Score:

```text
Toil Score = frequency_per_year * time_per_execution * engineers_count
```

- Сортируйте операции по годовой стоимости и автоматизируйте top items.
- Путь от toil к self-service:
  1. Измерить.
  2. Стандартизировать.
  3. Описать runbook.
  4. Сделать скрипт с ручным подтверждением.
  5. Полностью автоматизировать.
  6. Дать self-service через UI/CLI/IaC.
- Runbooks полезны, когда:
  - привязаны к alert;
  - актуальны;
  - короткие и конкретные;
  - лежат в git рядом с кодом;
  - проходят review и CI checks.
- Храните runbooks в git:
  - локальная копия доступна при сбое wiki;
  - есть versioning;
  - изменения ревьюятся;
  - можно проверять ссылки и freshness.
- Use repetition and risk to nominate automation: three executions or more than
  twice a month are illustrative triggers, not requirements. A rare operation
  with severe manual-error consequences may deserve automation earlier; an
  operation requiring judgment may remain assisted.
- Любая автоматизация требует собственных метрик и алертов. Operator, scaler, secret sync и self-healing scripts тоже могут ломаться.
- Примеры снижения toil:
  - External Secrets Operator вместо ручной ротации секретов;
  - Crossplane/Terraform operator вместо тикетов на базы и очереди;
  - KEDA/HPA вместо ручного scaling перед акциями;
  - CI checks вместо ручной проверки конфигов.

## Minimum useful runbook

A responder needs four things:

1. **First observations:** the affected journey, relevant dashboard/query, expected
   state, and how to distinguish a measurement failure from a service failure.
2. **Plausible causes:** a short evidence-led set from the service's behavior and
   incidents, with the observation that distinguishes each branch.
3. **Bounded action and recovery:** preconditions, exact operation, expected
   postcondition, blast radius, stopping condition, and rollback or alternate
   recovery. Restart or scaling is useful only when the diagnosis supports it.
4. **Escalation:** who can take the next decision, how to reach them, and the
   elapsed-time or impact condition for escalation.

Keep an accountable owner, applicable versions, last verified behavior, and a
refresh trigger. Link the runbook from the alert. In the existing alert-rule review
or CI path, reject page rules missing a usable runbook link and flag overdue review
where automation is available. A small service can perform the same check during
review; no separate CI system is needed. A successful link check does not prove
that instructions work or that on-call has access.
Six months is a historical freshness example; service change and operational risk
determine the review interval.

Verify access and execution assumptions during an appropriate exercise. Keep
necessary copies and recovery instructions reachable when the normal wiki,
identity, repository, or control plane is unavailable; see
[16-recovery-and-integrity.md](16-recovery-and-integrity.md).

Use `$technical-writing` for document form and clarity. Pass the verified state
transition, pre/postconditions, authority, failure evidence, version limits,
observability, and escalation route. SRE and the implementing owner remain
responsible for operational truth, installed behavior, and freshness.

## Bounded recovery automation

For self-healing actions, name the observed condition, action authority, target
scope, change-rate limit, expected recovery signal, and stop condition. Preserve
manual override and observe the automation's own failures. A successful restart
or reconciler loop is not proof that useful work recovered.

Do not let automation undo deliberate human quarantine or reuse suspect capacity
before evidence preservation. Reversing an action that automation introduced may
be useful, but is not blanket permission to reverse later human decisions. If
reconciliation conflicts with containment, pause the affected automation and
resolve desired state with the incident and platform owners. Verify that normal
reconciliation resumes without repeating the unsafe action.

Sources: *SRE: Коллективный разум*, minimum runbooks and runbook maintenance;
*Building Secure and Reliable Systems*, controlled degradation, bounded
automation, and incident recovery.

## Антипаттерны

- "Мы всегда так делали" как аргумент против автоматизации.
- Ранбук стал вечным финалом, хотя операция повторяется постоянно.
- Скрипт без owner, логов, метрик и rollback.
- Автоматизация хаоса: 15 разных ручных процессов автоматизированы как 15 разных скриптов без стандартизации.
- Wiki-runbook недоступен во время инцидента.
- Устаревший runbook хуже отсутствия runbook.
- Героизм на дежурстве награждается, а причина ночных побудок не устраняется.
- "Нет времени автоматизировать", потому что всё время ушло на toil.

## Как валидировать

Toil review:

- Команда знает top-10 ручных операций по годовой стоимости?
- Есть ли toil dashboard или tracker report?
- Есть ли цель по снижению toil в каждом спринте?
- Какие runbooks выполнялись чаще 2 раз в месяц?
- Какие операции требуют человеческого суждения, а какие можно автоматизировать?
- У каждой автоматизации есть owner, метрики, alerts и rollback?
- Self-service снижает нагрузку SRE, а не создаёт новый поток ручных approvals?
- Устаревшие runbooks помечаются на review?

Зрелость автоматизации:

| Уровень | Состояние |
| --- | --- |
| 0 | знания в головах, импровизация |
| 1 | runbooks есть, выполняются вручную |
| 2 | scripts требуют ручного запуска |
| 3 | orchestration по событиям, мониторинг automation |
| 4 | self-healing для типовых проблем |

Признак зрелости: новая ручная процедура создаётся как временная и сразу получает критерий автоматизации.

## Связанные темы

- [06-alerting.md](06-alerting.md)
- [08-postmortems.md](08-postmortems.md)
- [09-oncall.md](09-oncall.md)
- [11-kubernetes-reliability.md](11-kubernetes-reliability.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
