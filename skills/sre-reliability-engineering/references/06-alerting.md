# 06. Алертинг

## Суть

Алертинг - мост между наблюдаемостью и действием. Плохой алертинг хуже отсутствия алертинга: он будит людей без необходимости, снижает доверие к сигналам и приводит к пропуску настоящих инцидентов.

Рабочая модель: page-алерты должны быть привязаны к угрозе SLO/error budget, а не к сырым симптомам вроде CPU > 80%. Симптомные метрики нужны для диагностики, но не всегда должны будить ночью.

Хороший алерт:

- actionable: понятно, что делать;
- routable: пришёл тому, кто может исправить;
- proportional: severity соответствует влиянию;
- confirmed: есть подтверждение получения.

## Практики

- Разделяйте два типа реакции:
  - Page: immediate response to a reliability threat; an acknowledgement target such as 3–10 minutes must fit the intervention window and staffing.
  - Ticket: рабочее время, медленная деградация или плановая проверка.
- Используйте multi-window multi-burn-rate:
  - длинное окно подтверждает устойчивость проблемы;
  - короткое окно подтверждает, что проблема актуальна сейчас.
- Illustrative levels for a 30-day SLO window follow. Start with a fast-burn page
  and slow-burn ticket when those cover the needed actions; add intermediate
  levels only when they change response or routing. Verify burn definitions using
  [03-error-budget.md](03-error-budget.md). Require both windows of the chosen
  rule to breach its threshold; group overlapping severities so one event does
  not generate competing response instructions.

| Severity | Burn rate | Long window | Short window | Тип |
| --- | ---: | --- | --- | --- |
| Critical | 14.4x | 1h | 5m | page |
| Error | 6x | 6h | 30m | page или high-priority |
| Warning | 3x | 1d | 2h | ticket |
| Info | 1x | 3d | 6h | ticket |

- Используйте recording rules для SLO-метрик на больших объёмах.
- Генерируйте rules инструментами вроде Sloth/sloth-next, Pyrra или кастомного генератора, чтобы снизить риск ошибки в PromQL.
- Configure grouping, acknowledgement, repeat, and escalation for the actual alert stack:
  - `group_wait: 0s` is a possible urgent-page setting, not a universal default; balance response delay against duplicate pages;
  - distinguish repeat delivery from acknowledgement and escalation;
  - use a separate ticket route with a response cadence appropriate to working hours.
- В каждый page-алерт включайте:
  - сервис/SLO/endpoint;
  - burn rate и error ratio;
  - влияние на пользователей или сценарий;
  - ссылку на dashboard;
  - ссылку на runbook;
  - primary/secondary on-call;
  - время начала и длительность.
- Review alert outcomes at a cadence matched to volume and change: actionable,
  false positive/noise, duplicate, and missed violation. Around 80% actionable is
  a historical example, not an acceptance threshold. A perfect actionable rate
  warrants checking missed coverage; never create noise to lower it.
- Give every silence a named owner, reason, precise match scope, start and expiry,
  and a change/incident reference when relevant. Check duration units and ensure
  renewal is an explicit reassessment.
- Define local duration limits and an overdue-silence review or meta-alert.
  Historical examples such as 24 hours for review and seven days maximum are
  policy examples, not universal TTLs. Inspect the owner and active condition
  before renewal, and remove the silence when its reason ends.
- During a silence, retain visibility of the underlying signal and an independent
  way to detect unexpected user impact. Verify expiry restores notification,
  routing, and escalation; deleting a silence is insufficient if the route is broken.
- A page's runbook must provide first observations, plausible causes, bounded
  mitigation/recovery, and escalation. See [13-toil-automation.md](13-toil-automation.md).

## Антипаттерны

- Page на CPU, memory, disk без влияния на SLO.
- Ticket-алерты летят в тот же канал, что и ночные page.
- Алерт "service down" без runbook, dashboard и owner.
- Общий канал на 200 человек вместо маршрутизации к владельцу.
- Тысячи SMS в день, после которых дежурный перестаёт читать уведомления.
- Silence на месяцы вместо исправления причины.
- Алерт пришёл человеку без доступов к Grafana, Kubernetes, VPN или runbooks.
- Отсутствие мониторинга самой on-call/alerting-системы.

## Как валидировать

Fire drill для алертинга:

1. Отправьте тестовый page-алерт.
2. Засеките время до получения и подтверждения.
3. Проверьте, что primary не подтверждает - сработала ли эскалация?
4. Откройте dashboard и runbook из алерта.
5. Проверьте, что дежурный имеет доступы.
6. Завершите drill и убедитесь, что resolved notification доставлен.

Квартальный чеклист:

- Каждый page привязан к SLO или доказанно критичному симптому.
- Каждый page имеет runbook.
- Actionable outcomes and missed violations support the local coverage and response goals.
- Page alerts за смену не превращаются в постоянный шум.
- Escalation has been exercised at a risk-appropriate cadence and after changes to routing, access, or coverage.
- Нет silence дольше разрешённого максимума.
- Новые алерты проходят review как код.
- Ticket и page идут разными каналами.

Признак зрелости: ночной page означает реальную необходимость действий, а не просьбу "посмотреть график".

Source: *SRE: Коллективный разум*, Chapter 7 alerting, alert-health feedback,
minimum runbooks, and silence governance. Numerical examples require local calibration.

## Связанные темы

- [03-error-budget.md](03-error-budget.md)
- [04-monitoring.md](04-monitoring.md)
- [05-logs-traces.md](05-logs-traces.md)
- [07-incident-management.md](07-incident-management.md)
- [09-oncall.md](09-oncall.md)
