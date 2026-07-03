# 11. Kubernetes и надёжность

## Суть

Kubernetes даёт primitives для self-healing, scheduling и декларативного управления, но не делает приложение надёжным автоматически. Между "запустить в Kubernetes" и "эксплуатировать надёжно" находятся runtime-настройки, resource management, probes, graceful shutdown, PDB, HPA и аккуратная шаблонизация.

Ключевая позиция: не существует универсального ответа "CPU limits всегда убрать" или "всегда оставить". Решение зависит от runtime, QoS, кластера, требований к latency и качества мониторинга.

## Практики

- Для ресурсов учитывайте runtime:
  - Go: `GOMAXPROCS`, `GOMEMLIMIT`, automaxprocs; `GOMEMLIMIT` лучше держать около 80-90% memory limit.
  - Java: heap около 75% container memory, запас на off-heap, metaspace, thread stacks, direct buffers.
  - Python/Node.js: workers задавать явно, не полагаться на `os.cpu_count()` ноды.
- Мониторьте CPU throttling. Практический ориентир: если throttled periods > 25%, нужно пересматривать requests/limits или конфигурацию.
- Выбирайте QoS осознанно:
  - critical services: часто Guaranteed, если нужна предсказуемость и защита от eviction;
  - обычные services: CPU requests без CPU limits может быть уместно, memory requests/limits обязательны;
  - batch/CronJob: возможны более мягкие гарантии.
- Настройте probes по назначению:
  - `livenessProbe`: жив ли процесс, без внешних зависимостей;
  - `readinessProbe`: готов ли принимать трафик, может проверять зависимости;
  - `startupProbe`: защищает медленно стартующие приложения.
- Формула для startupProbe:

```text
failureThreshold * periodSeconds > max_startup_time * 1.5
```

- Для rolling update:
  - приложение обрабатывает SIGTERM;
  - прекращает принимать новые запросы;
  - завершает текущие;
  - закрывает connections;
  - имеет `terminationGracePeriodSeconds`;
  - часто полезен `preStop` sleep около 5 секунд для удаления pod из endpoints.
- Добавляйте PDB для критичных сервисов.
- HPA делайте устойчивым:
  - stabilization window;
  - scale up быстрее, чем scale down;
  - метрики, отражающие реальную нагрузку, а не только CPU.
- Не делайте один сверх-универсальный Helm chart на всё. Лучше library chart плюс service wrappers или kustomize/Jsonnet/cdk8s для сложных случаев.
- Минимальный Kubernetes dashboard для SRE:
  - CPU throttling;
  - memory > 90% limit;
  - restarts за последний час;
  - pending pods;
  - node utilization;
  - PDB violations;
  - HPA scaling events.

## Антипаттерны

- `livenessProbe` проверяет базу данных. При проблеме БД Kubernetes рестартит все pods и усиливает аварию.
- Go/Python/Node видят ресурсы ноды и создают слишком много workers/threads.
- JVM heap занимает почти весь memory limit и ловит OOM из-за off-heap.
- CPU limits удалены без LimitRange, мониторинга и понимания noisy-neighbor риска.
- BestEffort для критичного сервиса.
- Rolling update без graceful shutdown теряет запросы.
- HPA без stabilization создает flapping.
- Единый Helm chart превращается в single point of failure для деплоев десятков сервисов.

## Как валидировать

Kubernetes reliability review:

- Для каждого runtime заданы container-aware CPU/memory настройки?
- Есть requests и memory limits?
- Есть ли осознанное решение по CPU limits?
- CPU throttling ниже проблемного порога?
- Memory working set имеет запас до limit?
- Liveness не зависит от внешних сервисов?
- Readiness корректно снимает pod с трафика при деградации зависимости?
- StartupProbe покрывает реальное время старта?
- SIGTERM обработан в коде?
- PDB не позволяет voluntary disruption уронить все replicas?
- HPA не скейлит вниз слишком агрессивно?
- Weekly/controlled rolling restart проходит без пользовательской деградации?

Проверка практикой: плановый rolling restart в рабочее время при команде на месте. Если пользователи заметили, probes/PDB/shutdown/traffic routing требуют исправления.

## Связанные темы

- [10-reliability-architecture.md](10-reliability-architecture.md)
- [04-monitoring.md](04-monitoring.md)
- [06-alerting.md](06-alerting.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
- [13-toil-automation.md](13-toil-automation.md)
