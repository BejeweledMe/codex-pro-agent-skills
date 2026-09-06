# 12. Chaos и нагрузочное тестирование

## Суть

Chaos engineering стоит рассматривать не как "сломать прод", а как научный метод: сформулировать гипотезу, ограничить blast radius, провести эксперимент, наблюдать результат, сделать выводы и action items.

Для многих команд первый практический шаг - не полноценный chaos, а stress testing. Стресс-тест показывает точку деградации, порядок отказа компонентов и даёт команде опыт работы с нагруженной системой.

## Практики

- An illustrative staging load profile is:
  - 1x нормальной нагрузки;
  - 2x;
  - 3x;
  - 5x при необходимости;
  - каждая ступень 15-20 минут;
  - возврат к baseline для проверки восстановления.
- Choose load steps and duration from the unresolved capacity/recovery question,
  warmup, queue drain, scaling delay, and safe abort envelope. The multipliers and
  15–20-minute intervals above are examples, not a mandatory sequence.
- Документируйте результаты конкретно:
  - при каком RPS начались 5xx;
  - где исчерпался connection pool;
  - какой компонент первым деградировал;
  - сработали ли SLO alerts;
  - как повёл себя autoscaling.
- Любой нагрузочный инструмент должен иметь stop/circuit breaker:
  - остановка при error rate выше порога;
  - ограничение RPS;
  - изоляция тестового сегмента;
  - маркировка тестового трафика.
- Production load tests допустимы только при:
  - предупреждении команд;
  - marked traffic;
  - stop plan;
  - error budget;
  - наблюдении в реальном времени.
- Production chaos допустим только если:
  - есть запас error budget и явно принятый риск;
  - observability уже показывает SLI, зависимости, ресурсы и customer impact;
  - команда умеет вести инциденты: IC, коммуникации, rollback/failover, debug doc;
  - blast radius ограничен одним pod, малой долей трафика, одной зоной или другим контролируемым сегментом;
  - есть abort conditions и проверенный способ остановки;
  - люди не перегружены текущими P1, шумом алертов и toil. Иначе chaos станет дополнительным источником выгорания, а не обучением.
- Use controlled rolling restarts when needed to verify probes, PDBs, shutdown,
  and traffic rebalancing. Set cadence from risk and existing rollout evidence;
  do not create routine production disruption without a useful hypothesis.
- Делайте end-to-end probers:
  - не только `/healthz`;
  - реальный сценарий через API/UI;
  - content validation;
  - latency threshold;
  - cleanup тестовых данных;
  - choose vantage points and cadence from the detection objective, cost, and side effects; every 1–5 minutes is an illustrative schedule.
- Шаблон chaos experiment:
  - гипотеза;
  - blast radius;
  - affected services/users;
  - abort conditions;
  - baseline metrics;
  - steps;
  - result;
  - action items.
- Храните эксперименты в git рядом с сервисом.
- A possible progression, rather than a compulsory maturity ladder:
  1. Ничего не тестируем.
  2. Load tests на staging.
  3. Stress tests на staging и controlled restarts на prod.
  4. Targeted chaos на staging.
  5. Limited prod chaos.
  6. Chaos platform и Game Days.
- Game Day проверяет не только систему, но и людей, коммуникацию, escalation, runbooks и dashboards.

## Deployment and recovery evidence

After a change, exercise a small representative set of critical journeys from
entry point through meaningful result; three to five is an example, not a
coverage guarantee. Validate content and freshness where success requires them.
Tie observations to the actual candidate, configuration, cohort, and time window.

For reversible changes, failed probes stop promotion and trigger the agreed
rollback when it remains safe. For irreversible transitions, halt exposure and
follow the planned roll-forward or recovery branch. Release/platform owners
implement the gate; SRE supplies live signals and operational acceptance.
Choose an observation interval covering the affected behavior, including the
next representative peak when that exposes a material risk; arrange an explicit
handoff so a rollout is not left unobserved while risk remains.

For a fleet canary, inspect absolute exposed population, requests and cost per
unit, downstream request budgets, startup bursts, and retries. A tiny percentage
may still overwhelm a shared dependency. Check remaining capacity for unaffected
users and recovery, not just the canary's local error ratio.

Mark synthetic traffic and own test data, effects, and cleanup. Separating test
events from an SLI must not hide real customer failures induced by the test.
After stopping the generator, verify queues, retries, dependencies, and user
outcomes recover; return of offered load to baseline is not sufficient.

Use [16-recovery-and-integrity.md](16-recovery-and-integrity.md) for exercises
where recovery tools, identity, or authoritative state may be unavailable.

Source: *SRE: Коллективный разум*, business probes, controlled experiments,
and fleet external-request budgets.

## Антипаттерны

- Chaos на production без observability.
- "Сломать всё" без гипотезы и abort conditions.
- Нагрузочный генератор без автоматической остановки.
- Тесты без маркировки трафика, которые портят SLO и данные.
- Staging с микроскопическим объёмом данных, по которому делают выводы о production.
- Платформа chaos как игрушка, когда команда уже тонет в техдолге и алертах.
- Prober проверяет только 200 OK, но не бизнес-корректность ответа.
- Найденные проблемы не превращаются в action items.

## Как валидировать

Перед экспериментом:

- Гипотеза записана?
- Blast radius ограничен?
- Есть abort conditions?
- Есть owner, IC и канал коммуникации?
- Baseline метрики в норме?
- Error budget позволяет риск?
- Команда предупреждена?
- Остановка теста проверена?

После эксперимента:

- Гипотеза подтвердилась или опровергнута?
- Сработали ли alerts?
- Было ли влияние на пользователей?
- Есть ли конкретные action items?
- Обновлены ли runbooks, dashboards, SLO или architecture docs?
- Эксперимент можно повторить через git?

Признак зрелости: stress/chaos не является разовым шоу. Он регулярно даёт проверяемые изменения в архитектуре, мониторинге, runbooks и automation.

## Связанные темы

- [04-monitoring.md](04-monitoring.md)
- [06-alerting.md](06-alerting.md)
- [07-incident-management.md](07-incident-management.md)
- [10-reliability-architecture.md](10-reliability-architecture.md)
- [11-kubernetes-reliability.md](11-kubernetes-reliability.md)
