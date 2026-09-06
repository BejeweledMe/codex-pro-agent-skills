# 02. SLO, SLI, SLA

## Суть

SLA, SLO и SLI нельзя использовать как синонимы.

- SLA: внешнее контрактное обещание с последствиями, часто юридическими или финансовыми.
- SLO: внутренняя цель по качеству сервиса, на основе которой команда принимает решения.
- SLI: измеримая метрика, показывающая, насколько сервис выполняет цель.

SLO полезен только тогда, когда влияет на поведение. Если бюджет ошибок сгорел, но релизы продолжаются как раньше, это не SLO, а декоративная цифра. Если бюджет почти не расходуется, это тоже сигнал: возможно, цель слишком мягкая или ресурсы тратятся на избыточную надёжность.

Практически полезно выделять четыре основных типа SLI:

- Availability: доля успешных запросов.
- Latency: доля запросов быстрее заданного порога или распределение latency.
- Quality: корректность и полнота ответа, когда 200 OK ещё не означает успех.
- Freshness: актуальность данных в системах с кэшами, очередями, батчами и индексами.

Choose the initial SLIs from the critical journey. Availability and latency are useful starting points for request services; a data, search, or prediction journey may require quality or freshness from the beginning.

## Практики

- Начинайте с 3-5 критичных сервисов или пользовательских сценариев, а не со всех сервисов сразу.
- Делайте SLO эволюционно:
  1. Per-service SLO для критичных сервисов.
  2. Per-operation SLO для важных endpoint или методов.
  3. CUJ SLO для критичных пользовательских сценариев.
  4. Composite SLO с anyOf/allOf для сложной архитектуры.
  5. Автоматизация, прогнозирование, связь с бизнес-метриками.
- Используйте двухуровневую модель:
  - сервисные SLO для команд-владельцев;
  - продуктовые/CUJ SLO для видимости пользовательского опыта.
- Маршрутизируйте алерты по зоне действия. Сервисный SLO должен будить команду, которая может починить сервис. CUJ SLO должен идти IC, платформенной/SRE-команде или владельцу сценария.
- Разделяйте техническую и продуктовую надёжность. Техническая отвечает на вопрос "система корректно отвечает?", продуктовая - "пользователь достиг результата?".
- Для latency SLI используйте histogram, а не summary, потому что histogram корректнее агрегируется между инстансами.
- For low traffic, separate the recorded SLI from notification confidence. A single failure may consume a large real fraction of an event budget. Use explicit minimum-volume or longer-window alert policies where justified, and synthetic probes for additional coverage. Do not clamp away real failures or declare success when no eligible work was observed.

Implementation choices для SLI:

- Event-based SLO точнее учитывает объём: одна плохая минута с одной ошибкой не равна одной плохой минуте с миллионом ошибок. Но он сложнее для retries, batch/async flows и composite SLO.
- Timeslice SLO проще реализовать, проще комбинировать и обычно достаточно надёжен для операционных решений. Переходите на event-based только если потеря точности реально влияет на решения.
- Точка измерения меняет смысл SLI:
  - ingress/load-balancer metrics observe requests that reach that boundary; use external probes or client evidence for DNS, TLS, routing, and other failures before it;
  - сервисная метрика лучше показывает поведение owner-команды и проще связывается с кодом;
  - OpenTelemetry/traces помогают строить SLI по реальным путям запроса, но требуют зрелого instrumenting и sampling.
- Источник метрик должен соответствовать вопросу. Если SLO защищает checkout как CUJ, одной метрики `/healthz` или 200 OK от сервиса недостаточно.

## Measurement contract and SLI atomicity

Define the eligible population, observation point, terminal outcome, time window,
and treatment of retries, cancellations, unfinished work, and synthetic traffic.
Count each eligible operation once for the chosen SLI. An attempt-based metric
and a journey-based metric answer different questions.

Record mutually exclusive good/bad outcomes at one logical completion point.
Where practical, derive total from the same outcome-labelled counter rather than
independently updating total at admission and errors later. The requirement is
consistent event accounting, not a distributed atomic transaction across telemetry
backends; using `defer` is not inherently wrong when it records the same terminal
outcome consistently.

For a two-outcome classification, check `good + bad = eligible_total`,
`0 <= bad <= eligible_total`, and an SLI in `[0,1]` when the denominator is
positive. Investigate impossible values and spikes through label populations,
aggregation windows, counter resets, missing series, scrape timing, duplicate
counting, and asynchronous updates. Do not clamp away a broken measuring system
or change the SLO to hide it. A zero denominator means no eligible observations,
not demonstrated success.

Validate with representative success, failure, cancellation, timeout, retry,
restart, and no-traffic cases. Confirm both the classification and resulting
query before trusting budget decisions. During a measurement incident, retain
independent user-impact evidence and explicitly mark budget uncertainty.

## HTTP outcome classification

Agree classification before aggregation. Status codes are evidence about an
operation; they do not fully describe whether the protected journey succeeded.

| Observed outcome | Classification decision | Evidence to inspect |
| --- | --- | --- |
| Server failure such as 500 | An eligible operation that failed is bad even if it failed quickly | Operation result and error path; a fast failure must not improve latency success |
| 200 response | Good only if the promised result and applicable latency/quality conditions hold | Content, durable effect where promised, freshness, and elapsed time |
| 429 response | Rejection within the customer's agreed allowance is a bad outcome; exclusion for excess traffic must be an explicit contract | Customer allowance, admission/rate-limit decision, actual load, and rejected journey |
| Client abort, including a proxy's 499 | Distinguish service delay beyond the promise from voluntary cancellation or a shorter client deadline | Client/proxy timing, server progress, timeout contract, and any completed effect |
| Other 4xx | Distinguish expected invalid input or denied access from a valid journey broken by service behavior | Request eligibility, authorization/validation contract, and resulting user outcome |

A combined SLI can classify an operation as good only when all promised conditions
hold; retain separate availability, latency, quality, and freshness drill-downs.
Do not double-count one operation as multiple bad events in that combined SLI.
Keep exclusions visible and stable across releases.

Product/risk owners approve aggregate weights. Use separate segment SLOs when
different obligations would be hidden by traffic volume or a weighted average.
Inspect endpoint, region, version, tenant class, and journey contributions before
assigning an owner; contribution is a triage signal, not proof of causality.

If service metrics are green but the journey fails, probe from DNS through ingress
to the meaningful result and identify ownership of intermediate routing layers.

Source: *SRE: Коллективный разум*, SLI instrumentation, HTTP classification,
weighted indicators, and user-journey discussions.

Базовые формулы:

```text
SLI = good_events / total_events
```

Взвешенный SLI:

```text
SLI = sum(good_i * weight_i) / sum(total_i * weight_i)
```

The following composite formulas require independent component-success events
over the same specified interval and workload. Serial means every listed
component must succeed; parallel means any one can complete the promised operation
with sufficient capacity and working routing/failover. Include shared components.
These estimates do not replace measured CUJ reliability. For common failure
domains and recovery dependencies, see [10-reliability-architecture.md](10-reliability-architecture.md).

Composite reliability для последовательных зависимостей:

```text
R_serial = R_1 * R_2 * ... * R_n
```

Composite reliability для параллельных зависимостей:

```text
R_parallel = 1 - (1 - R_1) * (1 - R_2) * ... * (1 - R_n)
```

## Антипаттерны

- Ставить SLO без SLI и без policy.
- Считать SLO только по HTTP 200, когда бизнес-ответ может быть некорректным.
- Смешивать метрику трафика, маркетинга или конверсии с техническим SLI так, что алерты начинают шуметь от бизнес-кампаний.
- Делать чисто продуктовый SLO и будить команду, которая не может исправить причину.
- Покрывать 200 сервисов в первой итерации внедрения SLO.
- Считать latency по summary в кластере с несколькими инстансами и затем агрегировать квантили как будто они линейны.
- Учитывать latency ошибочных запросов как "успешную скорость": быстрый 500 не делает запрос хорошим.
- Полагаться на дефолтное "2xx хорошо, всё остальное плохо" без разбора 4xx, 429 и 499.

## Как валидировать

Для каждого SLO проверьте:

- Есть ли чёткая формулировка: какой пользовательский или сервисный результат защищаем?
- Есть ли owner, который может изменить систему?
- Есть ли SLI query, который можно воспроизвести и протестировать?
- Учитываются ли retries, async flows, batch jobs, low traffic и тестовый трафик?
- Понятно ли, что является good и bad event?
- Есть ли drill-down: какие endpoint, зависимости, регионы и версии внесли вклад?
- Может ли команда ответить: "что мы делаем иначе из-за текущего error budget?"
- Has observation covered representative traffic, failures, and no-data behavior before page activation? Two to four weeks is an illustrative observation period; volume and risk determine sufficient evidence.

Зрелый SLO проходит тест действия: значение SLO приводит к конкретному решению о релизах, рисках, техдолге или capacity.

## Связанные темы

- [03-error-budget.md](03-error-budget.md)
- [04-monitoring.md](04-monitoring.md)
- [06-alerting.md](06-alerting.md)
- [10-reliability-architecture.md](10-reliability-architecture.md)
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md)
