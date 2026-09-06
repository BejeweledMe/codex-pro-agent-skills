# 08. Постмортемы

## Суть

Постмортем нужен для обучения и предотвращения повторения, а не для отчётности. Хороший postmortem отвечает на три вопроса:

1. Что произошло?
2. Почему это стало возможным?
3. Что изменим, чтобы снизить вероятность или impact повторения?

Blameless не означает "без ответственности". Это означает: анализируем систему, процессы, проверки и ограничения, а не ищем виноватого человека. Человек мог нажать неправильную кнопку, но зрелый postmortem спрашивает: почему система позволила опасное действие без проверки, dry-run, rollback или ограничения blast radius?

## Практики

- Пишите postmortem для всех P1/P2 и для повторяющихся P3.
- Используйте debug doc как основу timeline.
- Структура:
  - summary для не-инженеров;
  - impact: пользователи, деньги, SLO, support tickets;
  - timeline с точными временами;
  - trigger;
  - causes;
  - что сработало хорошо;
  - что можно улучшить;
  - action items с owner, priority, deadline, tracker issue.
- Разделяйте immediate cause и systemic causes.
- Для причин используйте классификацию, которая указывает, кто будет исправлять:
  - код/архитектура;
  - процессы;
  - тестирование;
  - автоматизация;
  - техдолг;
  - внешнее ПО/провайдер;
  - осознанно принятый риск.
- Проводите встречу разбора. Документ без обсуждения часто не создаёт shared learning.
- Встречу модерирует человек, который пресекает обвинения и возвращает к вопросу "как система позволила этому произойти?"
- Action item должен быть проверяемым. "Быть внимательнее" заменяйте на "добавить validation в CI", "сделать dry-run", "добавить canary", "запретить destructive command без second approval".
- P1/P2 action items должны закрываться до статуса "все работы завершены".
- Делайте sharing sessions по важным постмортемам между командами.

## From trigger to verified corrective work

The trigger is the observed initiating event. Contributing causes are conditions
that made the failure possible or amplified its impact. Preserve multiple
compatible explanations until evidence distinguishes them.

For each material cause, record the supporting observation, uncertainty, a
counterfactual such as "would this control have prevented or bounded this
failure?", the owner able to change it, and a verifiable action. Do not treat a
recent release, correlation, or team label as a complete causal explanation.

| Contributing condition | Primary corrective owner | Evidence that closes the action |
| --- | --- | --- |
| Missing behavioral coverage | QA with the implementation owner | A meaningful check detects the failure and passes for the corrected behavior |
| Code/configuration bypassed candidate safeguards | Software engineering; platform for apply/reconcile enforcement | The corrected path rejects the unsafe transition and is installed where used |
| Capacity or dependency assumption failed | System design with platform/runtime owners | Representative load and failure evidence supports the revised contract |
| Alert, escalation, runbook, or recovery control failed | SRE/service owner | A bounded exercise demonstrates observation, action, and recovery |
| Source data or model semantics failed | Data or model owner | Corrected invariants or quality criteria hold through replay/recovery and relevant slices |
| A known risk was accepted | Named product/risk authority | The acceptance is revisited with actual impact, bounded mitigation, and an owned disposition |

Track aged critical actions and repeated causes to direct organizational
investment. A threshold such as P1 actions older than 30 days is a local review
policy, not a universal SLA or team ranking. Closing an issue is not evidence
that the fix reached production or reduced recurrence.

Use `$technical-writing` for structure and audience clarity when needed; SRE and
the contributing engineering owners retain the timeline, causal evidence, action
status, and technical truth.

Source: *SRE: Коллективный разум*, trigger/cause analysis and Chapter 9 follow-through.

## Антипаттерны

- Постмортем из одного предложения.
- Action items не выполняются, потому что фичи всегда важнее.
- KPI на скорость закрытия всех action items. Это стимулирует мелкие задачи вместо глубоких.
- Обвинительная формулировка: "инженер не проверил". Надо: "процесс не требовал проверки" или "система не валидировала".
- Указывать одну "root cause" для сложного инцидента и игнорировать совокупность факторов.
- Не писать postmortem, потому что "и так понятно".
- Писать postmortem, но не обсуждать с командами, которых он касается.
- Отсутствие владельца и deadline у задач.

## Как валидировать

Проверьте postmortem:

- Понятен ли summary бизнесу без чтения технических деталей?
- Есть ли точный impact в пользователях, деньгах или error budget?
- Timeline основан на фактах, а не памяти?
- Trigger отделён от causes?
- Есть ли несколько изменяемых причин, а не поиск одного виноватого?
- Каждый action item имеет owner, priority, deadline и issue?
- Есть ли задачи, которые меняют систему, а не поведение конкретного человека?
- Is follow-up scheduled according to action risk and dependencies? Two to four weeks is an illustrative interval; urgent controls may need earlier verification.
- Попали ли уроки в runbook, alert, dashboard, tests или architecture review?

Квартальный мета-анализ:

- распределение trigger;
- распределение causes;
- повторяющиеся сервисы;
- повторяющиеся missing controls;
- доля просроченных P1/P2 action items;
- изменение MTTR и burn budget.

Признак зрелости: команда может назвать последние реализованные postmortem action items без поиска по wiki.

## Связанные темы

- [07-incident-management.md](07-incident-management.md)
- [09-oncall.md](09-oncall.md)
- [13-toil-automation.md](13-toil-automation.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
- [15-tools-glossary.md](15-tools-glossary.md)
