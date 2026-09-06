# 03. Error Budget

## Суть

Error budget - это допустимый объём ошибок или недоступности за окно SLO. Он превращает спор "релизить или чинить надёжность" в управляемое решение. Пока бюджет есть, команда может осознанно рисковать. Когда бюджет близок к исчерпанию, поведение меняется. Когда бюджет исчерпан, включается стоп-кран на фичи, кроме исправлений надёжности.

Use a fractional SLO target, such as `0.999`. The allowance has the units of the
SLI: bad eligible events, bad timeslices, or unavailable duration. Event budgets
must not be silently converted to downtime minutes.

For a continuous time-based availability objective:

```text
error_budget = 1 - SLO
error_budget_minutes = (1 - SLO) * window_minutes
```

Для 30-дневного окна:

| SLO | Error budget |
| --- | ---: |
| 99% | 432 минуты |
| 99.9% | 43.2 минуты |
| 99.95% | 21.6 минуты |
| 99.99% | 4.32 минуты |

Burn rate показывает скорость расхода бюджета. Остаток бюджета без burn rate неполон: сервис может иметь 80% бюджета, но сжигать его так быстро, что через час будет нарушение.

## Практики

- Заводите error budget policy до инцидента, а не во время спора о релизе.
- An illustrative policy uses the following remaining-budget bands. Agree local boundaries, measurement window, treatment of exactly 20%/50%, and authorized actions before adoption:
  - `> 50%`: обычная работа, релизы и эксперименты разрешены.
  - `20-50%`: повышенное внимание, рискованные релизы требуют review и canary.
  - `< 20%`: режим надёжности, только багфиксы и reliability work.
  - `0%`: стоп-кран, релизы только для восстановления надёжности.
- Используйте rolling windows для операционных решений и calendar windows для понятной бизнес-отчётности.
- Define burn rate from the measured bad fraction and the allowed bad fraction.
  For an event-based SLI with `eligible_total > 0` and `SLO_target < 1`:

```text
allowed_bad_fraction = 1 - SLO_target
observed_bad_fraction = bad_events / eligible_total
burn_rate = observed_bad_fraction / allowed_bad_fraction
```

- For a time-based allowance, let `W` be the complete budget window, `H` the
  observation interval in the same units, and `f` the fraction of the complete
  allowance consumed during `H`. Dimensional derivation gives
  `burn_rate = f * W / H`. Thus 2% of a 30-day time allowance consumed in one hour
  gives `0.02 * 720 / 1 = 14.4x`. Do not divide again by the SLO allowance.
  For example, a 99.9% objective allows 43.2 unavailable minutes in 30 days.
  Five unavailable minutes in an hour give `(5 / 60) / 0.001 = 83.33x`.
  If that rate continued from an initially unused allowance, it would consume
  the full allowance in 8.64 hours, not eight minutes.
  These projections assume the same time basis and sustained rate. Translating
  an event-budget consumption fraction through elapsed time additionally requires
  event-volume assumptions; use the event ratio directly when measuring event burn.
- `burn_rate = 1` is the reference pace that would consume a complete allowance
  over a complete window under the stated model. It does not predict when the
  current rolling budget will run out: that also depends on prior consumption,
  events leaving the window, future traffic, and future failures.
- **Calculation note:** *SRE: Коллективный разум*, the burn-rate discussion,
  has an inconsistent percentage formula and downtime anecdotes. The equations
  here are derived from the definitions; its 2%-in-one-hour table also gives
  14.4x. Verify units, population, and calculation in the actual SLI implementation.
- For multi-window alerting, retain these illustrative response levels and calibrate them to the service:
  - 14.4x на окнах 1h/5m: быстрый пожар.
  - 6x на 6h/30m: устойчивый серьёзный расход.
  - 1x на 3d/6h: ticket для медленной деградации.
- For a rule comparing the observed bad fraction with a burn threshold:

```text
threshold = burn_rate * (1 - SLO_target)
```

- Используйте отдельную обработку тестового трафика: заголовки, отдельные pods/routes, исключение из SLI или отдельная среда.
- A mandatory dependency bounds journey availability over the same population,
  observation interval, and success definition. A contractual provider SLA is not
  a measurement of that availability. Examine observed behavior, exclusions, and
  fallback before drawing a ceiling:

```text
your_availability <= provider_availability
```

- Если инфраструктура и приложение принадлежат одной команде, единый budget может быть честным. Если команды разделены, используйте двухуровневую модель: сервисный budget для owner-команд и composite/CUJ budget для end-to-end опыта.

## Exceptions to budget policy

The agreed freeze remains the default when its trigger is met. A permitted
exception must use an authority named in the policy before the disputed release,
with authority over the affected risk beyond the releasing team where required.
An urgent feature request is not itself an exception.

Record the candidate and affected journeys, reason, named risk owner, bounded
scope and expiry, exposure/canary limits, rollback or safe roll-forward path,
abort signals, and the work required to restore normal policy. Recheck capacity
and current impact; an exception does not create technical rollback capability.
At expiry or an abort condition, stop the exception and follow the agreed recovery
path. Confirm that temporary bypasses are removed and normal policy is enforced.

Scale the record to the decision; a concise accountable decision is sufficient.
Availability budget authority does not authorize bypassing data-integrity or
security requirements.

Source: *SRE: Коллективный разум*, error-budget policy and release-exception discussions.

## Антипаттерны

- Error budget без policy и без последствий.
- Policy, которую менеджмент не поддерживает письменно.
- Сжёгшийся бюджет, но "надо релизить фичу, забейте".
- Calendar window как единственный механизм для операций: в конце месяца возникают искажённые стимулы.
- Считать все проблемы инфраструктуры бюджетом прикладной команды, которая не может их исправить.
- Маскировать нагрузочные тесты и автотесты "хаками сокрытия" без явной маркировки трафика.
- Целиться в 99.9%, когда критичная зависимость даёт 99%, и не менять архитектуру.
- Не измерять burn rate, а смотреть только на оставшиеся проценты.

## Как валидировать

Проверьте:

- Each SLO has an allowance with explicit population, denominator, units, and window; minutes are used only where the SLI supports a time allowance.
- Есть policy с режимами действий и владельцами.
- Stop-the-line поддержан руководством заранее.
- В алертах используются burn rate, а не только текущий error ratio.
- Page и ticket разделены по каналам и реакции.
- Тестовый, synthetic и load-test трафик явно размечен.
- Провайдеры, DNS, CDN, базы, очереди и внешние API учтены в модели доступности.
- Для каждого исчерпания budget есть postmortem или risk decision.

Практический тест: покажите команде "осталось 12 минут бюджета". Если никто не может сказать, какие релизы теперь разрешены, error budget не встроен в управление.

## Связанные темы

- [02-slo-sli-sla.md](02-slo-sli-sla.md)
- [06-alerting.md](06-alerting.md)
- [08-postmortems.md](08-postmortems.md)
- [10-reliability-architecture.md](10-reliability-architecture.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
