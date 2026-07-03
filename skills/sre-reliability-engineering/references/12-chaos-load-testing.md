# 12. Chaos и нагрузочное тестирование

## Суть

Chaos engineering стоит рассматривать не как "сломать прод", а как научный метод: сформулировать гипотезу, ограничить blast radius, провести эксперимент, наблюдать результат, сделать выводы и action items.

Для многих команд первый практический шаг - не полноценный chaos, а stress testing. Стресс-тест показывает точку деградации, порядок отказа компонентов и даёт команде опыт работы с нагруженной системой.

## Практики

- Начинайте с load/stress на staging:
  - 1x нормальной нагрузки;
  - 2x;
  - 3x;
  - 5x при необходимости;
  - каждая ступень 15-20 минут;
  - возврат к baseline для проверки восстановления.
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
- Используйте плановые rolling restarts как mini-chaos для проверки probes, PDB, shutdown и traffic rebalancing.
- Делайте end-to-end probers:
  - не только `/healthz`;
  - реальный сценарий через API/UI;
  - content validation;
  - latency threshold;
  - cleanup тестовых данных;
  - запуск каждые 1-5 минут из разных точек.
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
- Лестница зрелости:
  1. Ничего не тестируем.
  2. Load tests на staging.
  3. Stress tests на staging и controlled restarts на prod.
  4. Targeted chaos на staging.
  5. Limited prod chaos.
  6. Chaos platform и Game Days.
- Game Day проверяет не только систему, но и людей, коммуникацию, escalation, runbooks и dashboards.

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
