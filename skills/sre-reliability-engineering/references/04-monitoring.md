# 04. Мониторинг

## Суть

Мониторинг начинается не с установки Grafana, а с вопроса: как пользователь поймёт, что система нарушила ожидание? Метрики должны быть связаны с поведением сервиса и реакцией команды. Графики без действия, владельца и алерта остаются дорогим украшением.

Связывайте мониторинг с SLO: метрики нужны не ради наблюдения, а чтобы быстрее обнаружить нарушение, локализовать причину и восстановить сервис.

Две базовые методики:

- RED для request-driven сервисов: Rate, Errors, Duration.
- USE для ресурсов: Utilization, Saturation, Errors.

RED показывает пользовательские запросы. USE показывает исчерпание ресурсов, пулов, воркеров, очередей и лимитов. В зрелой системе нужны обе.

## Практики

- Начинайте с критичных пользовательских сценариев: оформление заказа, авторизация, поиск, оплата, получение данных.
- Для каждого сервиса измеряйте inbound RED:
  - request rate;
  - error rate;
  - latency distribution.
- Для каждой downstream-зависимости измеряйте outbound RED:
  - сколько вызовов уходит в зависимость;
  - сколько ошибок возвращается;
  - как меняется latency.
- Добавляйте USE не только на CPU/disk/memory, но и внутри приложения:
  - connection pools;
  - worker pools;
  - queue length;
  - queue wait time;
  - file descriptors;
  - thread/goroutine count;
  - cache hit ratio.
- Для очередей отслеживайте:
  - length;
  - enqueue/dequeue rate;
  - growth rate;
  - consumer lag;
  - wait time.
- Стройте dashboard hierarchy:
  - overview для быстрого ответа "есть ли проблема";
  - service dashboard для owner-команды;
  - debug dashboard для зависимостей, ресурсов и релизов.
- Используйте whitebox и blackbox вместе:
  - whitebox видит внутренние метрики сервиса;
  - blackbox/probers проверяют DNS, TLS, ingress, routing и бизнес-логику глазами пользователя.
- Добавляйте annotations: деплои, feature flags, migration windows, load tests, incidents.
- Для аномалий начинайте с простых статистических baseline: тот же слот времени за предыдущие недели. ML нужен не всегда.

## Queue and journey diagnosis

Keep depth, arrivals, completed service, growth, lag, and wait time together.
Dequeue or acknowledgement is not necessarily successful completion; inspect the
queue's semantics and downstream result. Compare equivalent populations and
windows, and do not interpret an arrival/service ratio with a zero denominator.

| Observation | Distinguishing evidence | Next action and verification |
| --- | --- | --- |
| Empty queue, expected events absent | Producer traffic, enqueue acknowledgements, routing, and end-to-end event result | Locate the broken ingestion stage; verify a traceable event reaches the promised result |
| Empty queue, normal arrivals and completions | Matching flow, short waits, and successful journey probes | Treat as healthy flow while retaining missing-input detection |
| Sustained growth or older backlog | Arrivals versus successful completion, retries, oldest-item age, worker saturation, and dependency tails | Bound admission or restore the constrained stage; verify falling age/lag and successful completion |
| Depth falls but the journey remains broken | Drops, expiry, dead letters, premature acknowledgements, and missing sink effects | Reconcile affected operations with the owning service; emptying the queue is not recovery proof |
| One partition or item stalls | Partition progress, poison-record retry history, ordering requirements, and retention horizon | Use the owner's quarantine/replay procedure; verify progress without lost or duplicated effects |

A sustained trend may warn earlier than a maximum-depth threshold, but normal
bursts and batch schedules need their own baseline. Compare backlog age with the
user freshness promise and retained replay history.

Prefer a freshness SLI based on eligible work completed within its deadline.
When the owner needs a graded lag proxy, an optional bounded score is:

```text
degradation_score = clamp((lag - lag_ok) / (lag_bad - lag_ok), 0, 1)
```

Require `lag_bad > lag_ok`, both thresholds in the same units as measured lag,
and an agreed meaning for the chosen partition/aggregation. The score is zero
at or below `lag_ok`, one at or above `lag_bad`, and 0.5 at their midpoint.
Validate those cases and the link to user freshness before adoption. This is
an owner-defined proxy, not the measured fraction of failed messages. Any SLO
using it needs an explicit sample/time aggregation and missing-input policy.

The source's progressive lag formula lacks a lower clamp and disagrees with
its example table. The bounded form above is a corrected construction, not a
copy of that formula or evidence for its example thresholds.

When component dashboards are green and a CUJ is red, inspect DNS, TLS, ingress,
routing, and result validation from outside the service. A contribution dashboard
narrows hypotheses; it cannot assign blame without path evidence.

Source: *SRE: Коллективный разум*, queue diagnostics and CUJ monitoring.
For retention loss, integrity failures, or overload that persists after demand
falls, use [16-recovery-and-integrity.md](16-recovery-and-integrity.md).

## Антипаттерны

- Считать CPU > 80% production-инцидентом без влияния на SLO.
- Узнавать о сбоях от клиентов или генерального директора.
- Overload the incident dashboard with unrelated detail or make it too slow for the response deadline; five seconds is an illustrative usability target.
- Не мониторить зависимости, а во время инцидента начинать grep по логам.
- Смотреть только aggregate по сервису и не видеть конкретный endpoint, регион или зависимость.
- Не мониторить очереди до тех пор, пока lag не стал пользовательской деградацией.
- Полагаться только на `/healthz`, который проверяет живость процесса, но не проверяет бизнес-сценарий.
- Не размечать тестовый и нагрузочный трафик.

## Как валидировать

Проведите drill:

1. Выберите критичный сценарий.
2. Сымитируйте деградацию зависимости на staging или в ограниченном production blast radius.
3. Откройте overview dashboard.
4. Засеките время до ответа:
   - какой пользовательский сценарий затронут;
   - какой сервис или зависимость виноваты;
   - какие ресурсы исчерпаны;
   - сработал ли SLO alert.

Operational validation:

- Measure how quickly the responder identifies a useful next hypothesis; 10–20 seconds is an illustrative dashboard goal, not proof of root cause.
- В dashboard есть входные запросы, исходящие зависимости, ресурсы, очереди, релизы и SLO.
- Система обнаруживает проблему раньше клиентов.
- Blackbox падает, если routing/DNS/ingress ломает сценарий при зелёных whitebox-метриках.
- Метрики имеют owner и используются в runbooks.

## Связанные темы

- [02-slo-sli-sla.md](02-slo-sli-sla.md)
- [05-logs-traces.md](05-logs-traces.md)
- [06-alerting.md](06-alerting.md)
- [07-incident-management.md](07-incident-management.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
