# 11. Kubernetes и надёжность

## Суть

Kubernetes даёт primitives для self-healing, scheduling и декларативного управления, но не делает приложение надёжным автоматически. Между "запустить в Kubernetes" и "эксплуатировать надёжно" находятся runtime-настройки, resource management, probes, graceful shutdown, PDB, HPA и аккуратная шаблонизация.

Ключевая позиция: не существует универсального ответа "CPU limits всегда убрать" или "всегда оставить". Решение зависит от runtime, QoS, кластера, требований к latency и качества мониторинга.

Platform engineering implements manifests, runtime settings, scheduling, and
controllers. SRE judges their behavior through user outcomes, capacity,
degradation, and recovery evidence. Check actual Kubernetes, runtime, ingress,
and controller versions before relying on detailed timing or defaults.

## Практики

- Для ресурсов учитывайте runtime:
  - Go: inspect container awareness, `GOMAXPROCS`, `GOMEMLIMIT`, and any automaxprocs integration for the deployed runtime. An 80–90% memory-limit setting is an illustrative starting hypothesis; reserve measured space for memory outside the managed runtime and workload peaks.
  - Java: budget heap plus off-heap, metaspace, thread stacks, and direct buffers. A 75% heap allocation is an example, not a safe fraction for every application.
  - Python/Node.js: verify worker/thread sizing against the container's effective CPU and memory envelope rather than assuming a node CPU count is appropriate.
- Monitor throttling alongside throttled time, CPU demand, queueing, and latency.
  A throttled-period ratio above 25% is an investigation example, not an automatic
  limits change or incident criterion. Distinguish quota effects, worker sizing,
  and noisy-neighbor contention before changing resources.
- Выбирайте QoS осознанно:
  - critical services: consider Guaranteed where its resource contract helps predictability; it does not eliminate node failure or eviction risk;
  - обычные services: CPU requests без CPU limits может быть уместно, memory requests/limits обязательны;
  - batch/CronJob: возможны более мягкие гарантии.
- Настройте probes по назначению:
  - `livenessProbe`: жив ли процесс, без внешних зависимостей;
  - `readinessProbe`: can this instance accept the intended traffic? Include a dependency only when removing this pod improves outcomes; a shared dependency failure must not blindly make every replica unready;
  - `startupProbe`: защищает медленно стартующие приложения.
- Size the startup probe allowance from representative cold starts, initialization,
  storage/dependency delays, and resource contention. `failureThreshold *
  periodSeconds` is a rough failure-budget estimate; inspect timeout, delay, and
  scheduling semantics in the actual stack. A 1.5× startup margin is an example,
  not a guarantee. Verify that legitimate slow starts survive while stuck starts
  are detected within the accepted recovery time.

- Для rolling update:
  - приложение обрабатывает SIGTERM;
  - прекращает принимать новые запросы;
  - завершает текущие;
  - закрывает connections;
  - имеет `terminationGracePeriodSeconds`;
  - use a bounded drain/preStop delay only when measured endpoint and routing propagation requires it; five seconds is an example, not proof that traffic has stopped;
  - account for preStop execution and application draining within the termination grace period, and observe rejected, lost, and unfinished requests.
- Use PDBs where voluntary-disruption availability requires them. Check selectors,
  healthy replica counts, replacement capacity, and the disruption operation;
  PDBs do not establish protection from every failure or replace rollout policy.
- HPA делайте устойчивым:
  - stabilization window;
  - scale up быстрее, чем scale down;
  - метрики, отражающие реальную нагрузку, а не только CPU.
- Не делайте один сверх-универсальный Helm chart на всё. Лучше library chart плюс service wrappers или kustomize/Jsonnet/cdk8s для сложных случаев.
- Минимальный Kubernetes dashboard для SRE:
  - CPU throttling;
  - memory working set, peaks, OOMs, and remaining headroom; 90% of limit is an illustrative warning level to calibrate;
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
- Does throttling evidence explain user latency or lost throughput, and has the proposed resource/runtime change improved both without displacing risk?
- Memory working set имеет запас до limit?
- Liveness не зависит от внешних сервисов?
- Does readiness remove unusable instances while avoiding a fleet-wide withdrawal during a shared dependency failure?
- StartupProbe покрывает реальное время старта?
- SIGTERM обработан в коде?
- PDB не позволяет voluntary disruption уронить все replicas?
- HPA не скейлит вниз слишком агрессивно?
- Does an authorized controlled restart or normal rollout demonstrate safe probes, draining, PDB behavior, and traffic redistribution under representative load?

Use restart exercises when they answer an unresolved recovery question, with
available capacity, observers, blast-radius limits, and abort criteria. Weekly
restarts are not a universal requirement; normal rollout evidence or a safer
environment may answer the question. If users are affected, inspect probes,
PDBs, shutdown, routing propagation, and replacement capacity before repeating.

## Failure-to-action checks

| Observation | Distinguishing evidence | Action and acceptance |
| --- | --- | --- |
| Restarts surge during dependency failure | Probe failures, termination reasons, and dependency timeline | Remove inappropriate liveness coupling; verify degradation without restart amplification |
| New pods repeatedly die before ready | Startup durations, probe events, resource pressure, and initialization progress | Adjust the measured startup envelope or repair initialization; verify cold-start completion and bounded stuck-start detection |
| Errors occur only during rollout | SIGTERM/preStop timeline, endpoint changes, in-flight requests, and grace expiry | Repair draining or routing coordination; verify completed requests and bounded termination |
| Voluntary maintenance stalls | PDB selection/status, ready replicas, pending replacements, and available capacity | Restore feasible capacity or revise the disruption plan; verify the journey during the transition |
| HPA oscillates or scales without recovery | Scaling decisions, metric delay, offered work, queue age, readiness/warmup, retries, and dependency capacity | Tune the controller with the platform owner or repair the actual bottleneck; verify stable SLO recovery and safe scale-down |

Numerical examples in this reference are workload hypotheses. Refresh their
assumptions after runtime, cluster policy, workload, probe, or routing changes.

## Связанные темы

- [10-reliability-architecture.md](10-reliability-architecture.md)
- [04-monitoring.md](04-monitoring.md)
- [06-alerting.md](06-alerting.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
- [13-toil-automation.md](13-toil-automation.md)
