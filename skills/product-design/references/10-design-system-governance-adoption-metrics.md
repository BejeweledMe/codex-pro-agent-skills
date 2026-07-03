# Governance, Adoption And Metrics

Related: [design systems](09-design-systems-as-product.md), [business outcomes](11-business-outcomes-and-product-metrics.md), [anti-patterns](13-anti-patterns.md)

## Why Governance Exists

Governance - это не бюрократия ради контроля. Это способ сохранить quality, consistency, accessibility and velocity при росте числа teams and contributors.

Нужен ответ на вопросы:

- кто может предложить change;
- кто review;
- какие quality gates;
- как принимаются tradeoffs;
- как versioning and release работают;
- как teams узнают о changes;
- как deprecated patterns removed.

## Ownership Models

zeroheight 2026 показывает распространенные модели: centralized, hybrid, federated. Каждая имеет failure modes:

- Centralized: bottleneck, under-resourcing, distance from product work.
- Federated: unclear accountability, low dedicated time, inconsistent quality.
- Hybrid: coordination cost, unclear responsibilities, conflicting opinions.

Выбор модели зависит от организации, но в любой модели должны быть clear owners and decision rights.

## Contribution

`synthesis`

Contribution должна быть достаточно открытой, чтобы product teams могли закрывать реальные needs, и достаточно управляемой, чтобы система не превратилась в набор случайных components.

Практический contribution path:

- intake template with user need, usage evidence, alternatives;
- design and engineering review;
- accessibility check;
- API and token review;
- docs/examples requirement;
- release and migration plan;
- owner for maintenance.

## Adoption

Adoption - главная проверка полезности design system. Система может быть trusted, но не adopted, если:

- нет mandate or incentives;
- docs incomplete;
- components не покрывают real needs;
- contribution path слишком тяжелый;
- product teams не знают, что есть;
- migration cost слишком высок;
- code and design artifacts расходятся.

## Metrics

zeroheight 2026 показывает, что teams чаще измеряют adoption, design/code component usage и accessibility compliance, но реже ROI, NPS, technical performance. Практический вывод: измеряйте не только activity, но и outcome.

`synthesis`

Полезная taxonomy для агента:

- `Adoption`: component usage in design/code, coverage by product, migration rate.
- `Quality`: accessibility compliance, bug/error volume, visual regressions, code quality.
- `Speed`: design delivery speed, development speed, time to implement common flows.
- `Consistency`: pattern drift, duplicated components, design-to-code parity.
- `Community`: contributors, office hours, support tickets, satisfaction.
- `Business`: cost avoidance, reduced rework, faster launches, lower support burden.

## Buy-In

Leadership buy-in требует numbers and stories. Одних компонентов недостаточно. Нужно показывать:

- какой duplicated work устранен;
- какие defects or accessibility risks снижены;
- какие releases ускорены;
- какие teams adopted систему;
- какие product outcomes система поддержала.

## Documentation And Communication

Docs are part of the product. Без docs система не масштабируется. Обязательные artifacts:

- component purpose and anatomy;
- when to use / when not to use;
- accessibility requirements;
- content guidance;
- code examples;
- design examples;
- migration notes;
- changelog and release notes.

## Automation

По zeroheight 2026 automation остается uneven. Где автоматизация обычно полезна:

- token pipelines;
- NPM bundling/releases;
- Storybook publishing;
- generated prop docs;
- release notes;
- visual regression tests;
- design-to-code parity checks;
- accessibility compliance checks.

Не автоматизируйте governance decisions, которые требуют product/design judgment.

## Agent Checklist

- Какая ownership model и где ее bottleneck?
- Кто может contribute?
- Какие gates must pass before release?
- Что измеряем кроме page views?
- Как product teams узнают о changes?
- Где docs incomplete?
- Какие adoption blockers evidence-backed?
- Какие automations дадут time back without quality loss?

## Source Boundary

zeroheight 2026 - self-reported survey with n=147 and geographic skew. Используйте проценты как industry snapshot, не как universal truth.
