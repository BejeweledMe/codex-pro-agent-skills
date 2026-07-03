# 15. Инструменты и глоссарий

## Суть

Инструменты не заменяют SRE-практики. Они полезны, когда поддерживают SLO, observability, incident response, on-call, automation и learning loop. Список инструментов нужно воспринимать как справочник, а не как догму: стек выбирается по масштабу, компетенциям команды, бюджету и ограничениям среды.

Важно: инструментальные рекомендации быстро устаревают. Перед внедрением нужно проверять текущий статус проектов, лицензии, поддержку и доступность.

## Практики

Метрики и мониторинг:

- Prometheus: стандарт для метрик и PromQL.
- VictoriaMetrics: вариант для больших объёмов и экономии ресурсов.
- Grafana: единое окно для dashboards, metrics/logs/traces.
- Thanos: HA и long-term storage для Prometheus-экосистемы.

Логи:

- Loki: удобен для средних объёмов и Grafana-стека.
- ClickHouse: сильный вариант для больших объёмов логов и аналитики.
- Elasticsearch: мощный полнотекстовый поиск, но высокая стоимость эксплуатации.
- Vector/Fluent Bit: сбор, трансформация, маршрутизация логов.

Трейсинг:

- OpenTelemetry: рекомендуемый стандарт инструментирования.
- Grafana Tempo: trace storage с Grafana/Loki integration.
- Jaeger: зрелый tracing-инструмент.

Алертинг и on-call:

- Alertmanager: routing, grouping, inhibition, silence.
- Grafana OnCall: open-source on-call, schedules, escalation.
- PagerDuty/OpsGenie: SaaS on-call, учитывать доступность и vendor risk.

Инфраструктура:

- Kubernetes: orchestration standard.
- Helm: полезен, но единый super-chart на всё - anti-pattern.
- Terraform: infrastructure as code.
- ArgoCD: GitOps.
- Crossplane: self-service provisioning через Kubernetes CRD.

Load/chaos:

- k6: load tests на JavaScript, удобен для сценариев.
- Locust: Python-based distributed load testing.
- Яндекс.Танк: часто упоминаемый российский инструмент нагрузочного тестирования.
- Chaos Mesh/LitmusChaos: Kubernetes chaos experiments.

SLO tooling:

- Sloth: генерация Prometheus recording/alert rules; перед использованием проверьте текущий статус проекта.
- sloth-next: community fork.
- Pyrra: SLO tool с UI и Kubernetes CRD.
- OpenSLO: спецификация, не полноценная runtime-система.
- Custom generator: полезен при composite SLO, MetricsQL, service catalog и снижении cardinality.

Выбор по масштабу:

| Масштаб | Метрики | Логи | Трейсинг | On-call |
| --- | --- | --- | --- | --- |
| Малый | Prometheus | grep/Loki | Jaeger/Tempo | Alertmanager |
| Средний | Prometheus + VictoriaMetrics | Loki | OTel + Tempo | Grafana OnCall |
| Крупный | VictoriaMetrics Cluster/Thanos | ClickHouse/Elasticsearch | OTel + Tempo/Jaeger | PagerDuty/Grafana/custom |
| Enterprise | кастом/clustered stack | ClickHouse + pipeline | OTel + custom backend | custom/enterprise process |

Численные ориентиры из приложений:

| Решение | Когда обычно достаточно | Когда нужен следующий уровень |
| --- | --- | --- |
| Prometheus local storage | меньше 500K samples/sec и retention до 15 дней | больше 500K samples/sec или retention больше 15 дней: VictoriaMetrics/Thanos/remote storage |
| Loki для логов | меньше 100 GB/day | больше 100 GB/day: ClickHouse или Elasticsearch |
| Hot logs retention | 7-14 дней | для 30-90 дней используйте cold/object storage |
| Traces retention | 2-7 дней | обычно не хранят долго; важнее tail sampling и linkage к логам |
| SLO tooling | Sloth/Pyrra/OpenSLO достаточно для Prometheus-like workflow | custom generator нужен при composite SLO, MetricsQL, service catalog, cardinality control |

Перед внедрением агент должен проверять текущий статус проектов, лицензии, поддержку и доступность в конкретной среде.

## Антипаттерны

- Покупать observability platform и считать, что SRE внедрён.
- Выбирать инструмент без владельца, runbook, backup и cost model.
- Sloth/Pyrra/custom без понимания cardinality и нагрузки на Prometheus.
- Логи хранятся дорого, поэтому важные события отключены.
- On-call зависит от одного SaaS без альтернативного канала.
- Helm-чарт становится платформой с тысячами строк условий.
- Tool sprawl: для каждой команды свой стек без общих стандартов и cross-team incident visibility.
- Забывать мониторить саму платформу мониторинга и алертинга.

## Как валидировать

Tooling review:

- Какую SRE-практику поддерживает инструмент?
- Есть ли owner?
- Есть ли runbook для отказа инструмента?
- Что произойдёт, если инструмент недоступен во время инцидента?
- Есть ли cost/cardinality/retention limits?
- Инструмент поддерживает links между metrics, traces и logs?
- Можно ли экспортировать или мигрировать данные?
- Есть ли локальная альтернатива для category A dependencies?
- Проходят ли конфигурации review как код?

Мини-глоссарий:

| Термин | Краткое значение |
| --- | --- |
| Alerting | автоматическое уведомление о нарушении SLO или важного порога |
| Blast radius | масштаб последствий изменения или отказа |
| Blameless postmortem | разбор, сфокусированный на системе, а не виноватых |
| Burn rate | скорость расхода error budget |
| Canary deployment | выкладка на малую долю трафика для проверки |
| Circuit breaker | паттерн остановки вызовов к деградирующей зависимости |
| CUJ | critical user journey, критичный пользовательский сценарий |
| Error budget | допустимый объём ошибок за окно SLO |
| Graceful degradation | сохранение частичной функциональности при сбое |
| IC | Incident Commander, координатор инцидента |
| MTTD | mean time to detect |
| MTTA | mean time to acknowledge |
| MTTR | mean time to recover/resolve |
| MTTRC | mean time to root cause |
| Observability | способность понять состояние системы по её сигналам |
| On-call | дежурство с обязанностью реагировать |
| RED | Rate, Errors, Duration |
| USE | Utilization, Saturation, Errors |
| Runbook | инструкция для конкретного alert/операции |
| SLI | измеритель уровня обслуживания |
| SLO | целевой уровень обслуживания |
| SLA | внешний контракт об уровне обслуживания |
| Toil | ручная повторяющаяся автоматизируемая работа без долгосрочной ценности |

## Связанные темы

- [04-monitoring.md](04-monitoring.md)
- [05-logs-traces.md](05-logs-traces.md)
- [06-alerting.md](06-alerting.md)
- [12-chaos-load-testing.md](12-chaos-load-testing.md)
- [13-toil-automation.md](13-toil-automation.md)
