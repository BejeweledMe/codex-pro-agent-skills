# SRE reliability engineering references

Эта папка содержит reference-файлы для глобального skill `sre-reliability-engineering`. Они собраны из тематических SRE-заметок и предназначены для агентов, занимающихся проектированием, ревью, эксплуатацией и улучшением production-систем.

Материалы написаны как самостоятельные рабочие инструкции для SRE-агента: они фиксируют практики, чеклисты, failure modes и вопросы для review.

## Как пользоваться

1. Для общего понимания начните с [01-sre-foundations.md](01-sre-foundations.md).
2. Для проектирования SLO и алертинга читайте цепочку [02-slo-sli-sla.md](02-slo-sli-sla.md), [03-error-budget.md](03-error-budget.md), [06-alerting.md](06-alerting.md).
3. Для production-ready архитектуры используйте [10-reliability-architecture.md](10-reliability-architecture.md), [11-kubernetes-reliability.md](11-kubernetes-reliability.md), [12-chaos-load-testing.md](12-chaos-load-testing.md).
4. Для процессов эксплуатации смотрите [07-incident-management.md](07-incident-management.md), [08-postmortems.md](08-postmortems.md), [09-oncall.md](09-oncall.md), [13-toil-automation.md](13-toil-automation.md).
5. Для общего поведения агента используйте [sre-agent-operating-model.md](sre-agent-operating-model.md) как системную модель.

## Файлы

- [01-sre-foundations.md](01-sre-foundations.md): что такое SRE, чем оно отличается от DevOps/Platform, почему это система обратной связи.
- [02-slo-sli-sla.md](02-slo-sli-sla.md): SLA, SLO, SLI, CUJ, composite SLO, выбор индикаторов.
- [03-error-budget.md](03-error-budget.md): error budget, burn rate, policy, rolling/calendar windows, связь с релизами.
- [04-monitoring.md](04-monitoring.md): RED/USE, метрики зависимостей, очереди, dashboards, whitebox/blackbox.
- [05-logs-traces.md](05-logs-traces.md): логи, трейсы, OpenTelemetry, sampling, exemplars, требования к логированию.
- [06-alerting.md](06-alerting.md): page/ticket, multi-window multi-burn-rate, Alertmanager, signal/noise, silence.
- [07-incident-management.md](07-incident-management.md): lifecycle инцидента, роли, debug doc, плановые работы.
- [08-postmortems.md](08-postmortems.md): blameless postmortem, структура, action items, follow-through.
- [09-oncall.md](09-oncall.md): ротации, эскалации, оплата, handoff, метрики здоровья дежурств.
- [10-reliability-architecture.md](10-reliability-architecture.md): fallacies, зависимости, composite reliability, graceful degradation.
- [11-kubernetes-reliability.md](11-kubernetes-reliability.md): resources, runtime, probes, graceful shutdown, PDB/HPA, Helm anti-patterns.
- [12-chaos-load-testing.md](12-chaos-load-testing.md): stress tests, chaos experiments, probers, Game Day, maturity ladder.
- [13-toil-automation.md](13-toil-automation.md): toil score, runbooks, git, автоматизация, self-service.
- [14-business-culture-war-stories.md](14-business-culture-war-stories.md): бизнес-язык надёжности, культура, выгорание, war stories, change checklist.
- [15-tools-glossary.md](15-tools-glossary.md): инструменты, SLO tooling, краткий глоссарий.
- [sre-agent-operating-model.md](sre-agent-operating-model.md): как агенту применять знания из папки в проектировании, ревью, incident work и коде.

## Принципы обновления

- Сохраняйте формат прикладных инструкций, а не учебника.
- Если заметка содержит численные пороги, помечайте их как практический ориентир.
- Инструменты и внешние сервисы могут устаревать. Перед применением проверяйте актуальность отдельно.
- Любое расширение вне текущей базы помечайте как `external extension`.
