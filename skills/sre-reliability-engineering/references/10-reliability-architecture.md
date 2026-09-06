# 10. Архитектура надёжности

## Суть

Надёжность нельзя добавить в конце как библиотеку. Архитектура заранее определяет, как система будет деградировать при отказе. Падения неизбежны; вопрос в том, насколько больно они пройдут для пользователя и команды.

Основные источники риска в распределённых системах:

- сеть не всегда доступна;
- latency не нулевая;
- bandwidth и connection pools конечны;
- topology меняется;
- DNS, routing, control plane и внешние провайдеры могут стать hidden dependency;
- serial hard dependencies require joint success; common failure domains and recovery dependencies determine the actual end-to-end risk.

## Практики

- Для каждой зависимости задавайте:
  - timeout;
  - retry с backoff и jitter;
  - circuit breaker;
  - bulkhead или изоляцию ресурсов;
  - метрики исходящих вызовов;
  - fallback или degradation mode.
- Аудит сетевых допущений:
  1. Список всех внешних и внутренних зависимостей.
  2. Проверка timeouts/retries/circuit breakers.
  3. Поведение при network partition.
  4. Метрики на outgoing calls.
  5. Game Day или staging-test с отключением зависимости.
- Use the following composite estimates only for independent success events over
  the same interval, workload, and success definition. Serial requires every
  component; parallel requires any one to complete the operation, including
  sufficient capacity and functioning routing/failover:

```text
R_serial = R_1 * R_2 * ... * R_n
R_parallel = 1 - (1 - R_1) * (1 - R_2) * ... * (1 - R_n)
```

- Under those assumptions, five serial components at 99.9% each give roughly
  99.5%, and ten roughly 99.0%. Count the calling service if it is one of the
  required components. These are topology examples, not measured CUJ SLOs.
- Identify shared networks, zones, identity, DNS, storage, deployment machinery,
  and control planes. Correlation invalidates the independent-product estimate;
  its error direction depends on the topology and joint distribution. Do not
  apply a universal "correlation penalty" or multiply contractual SLAs.
- Размечайте зависимости:
  - hard dependency: без неё сценарий невозможен;
  - soft dependency: можно деградировать.
- Проверяйте разметку chaos/stress tests. Если soft dependency при отключении роняет сценарий, она не soft.
- Проектируйте graceful degradation:
  - throttling/admission control;
  - waiting room, если подходит домену;
  - fallback/cache;
  - отключение некритичных функций;
  - load shedding по приоритету;
  - async processing через очередь вместо синхронного вызова.
- Для микросервисов требуйте minimum operational contract:
  - owner;
  - SLO;
  - CI/CD;
  - rollback;
  - observability межсервисных вызовов;
  - runbook;
  - documented API contract.
- Стройте graph of dependencies из tracing/service mesh и используйте его в incident dashboards.

## Recovery dependencies and bounded rollout

Review the bootstrap and recovery path separately from the serving path. A
runtime trace may miss dependencies on identity, DNS, repositories, credentials,
consoles, and communication tools needed only during recovery. Ask which tools
and authority survive each failed layer and whether they can restore it without
first requiring it to work. Route topology changes to `$system-design` and
implementation to `$platform-devops-engineering`; SRE owns the exercise and
user-reliability acceptance.

Last-known configuration or fallback can sustain service during a control-plane
failure only within its freshness, authorization, and capacity contract. Test
that degraded operation remains bounded and can safely converge when control
returns. See [16-recovery-and-integrity.md](16-recovery-and-integrity.md) for the
recovery procedure and trusted-state checks.

For client agents, firmware, or other fleets, a small rollout percentage can
produce large absolute traffic. Budget requests and cost per unit plus aggregate
DNS/API/dependency load, startup bursts, and retries. Pass measured limits and
abort signals to the release/platform owner; local error rate alone is not a
promotion criterion.

Source: *SRE: Коллективный разум*, dependency reliability, control-plane recovery,
and fleet external-request budgets. Independence qualifications describe the
mathematical assumptions; the source's universal claim about correlation direction
must not be carried into estimates.

## Антипаттерны

- HTTP client без timeout.
- Retry без backoff, создающий amplification при деградации зависимости.
- Все зависимости считаются hard по умолчанию.
- Некритичный сервис аватарок или рекомендаций роняет checkout.
- Десятки микросервисов без ownership и SLO.
- Кэширование IP-адресов в Kubernetes без уважения DNS TTL.
- Балансировщик перед параллельными кластерами имеет надёжность ниже, чем сами кластеры, и становится потолком всей системы.
- "Сеть где-то в хвосте причин" интерпретируется как "сеть можно игнорировать". Нельзя: просто чаще ломают релизы, конфиги, ресурсы и код.

## Как валидировать

Architecture review для сервиса:

- Какие пользовательские сценарии сервис поддерживает?
- Какие hard и soft dependencies есть на критическом пути?
- Какой composite SLO получается при текущих зависимостях?
- Что происходит, если каждая dependency недоступна 30 секунд, 5 минут, 1 час?
- Какие timeouts установлены? Они меньше пользовательского timeout?
- Есть ли retry budget и jitter?
- Где circuit breaker и как он виден в метриках?
- Какая часть функциональности деградирует, а какая должна сохраняться?
- Какие ресурсы изолированы: pools, queues, threads, workers?
- Можно ли переключить fallback или throttling конфигом без релиза?
- Проверено ли это stress/chaos/game day?

Признак зрелости: команда может нарисовать граф зависимостей, посчитать rough composite reliability и показать, какие soft dependencies реально проверены отказами.

## Связанные темы

- [02-slo-sli-sla.md](02-slo-sli-sla.md)
- [03-error-budget.md](03-error-budget.md)
- [04-monitoring.md](04-monitoring.md)
- [11-kubernetes-reliability.md](11-kubernetes-reliability.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
