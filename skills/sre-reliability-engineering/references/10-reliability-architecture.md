# 10. Архитектура надёжности

## Суть

Надёжность нельзя добавить в конце как библиотеку. Архитектура заранее определяет, как система будет деградировать при отказе. Падения неизбежны; вопрос в том, насколько больно они пройдут для пользователя и команды.

Основные источники риска в распределённых системах:

- сеть не всегда доступна;
- latency не нулевая;
- bandwidth и connection pools конечны;
- topology меняется;
- DNS, routing, control plane и внешние провайдеры могут стать hidden dependency;
- последовательные hard dependencies перемножают недоступность.

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
- Моделируйте composite reliability:

```text
R_serial = R_1 * R_2 * ... * R_n
R_parallel = 1 - (1 - R_1) * (1 - R_2) * ... * (1 - R_n)
```

- Помните: пять последовательных компонентов по 99.9% дают примерно 99.5% end-to-end, а десять - примерно 99.0%.
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
