# UI/UX Product Quality

Related: [operating model](02-product-operating-model.md), [AI trust](07-calibrated-trust-and-human-control.md), [design systems](09-design-systems-as-product.md), [checklists](12-agent-product-design-checklists.md)

Synthesis note: разделы про accessibility, instrumentation и implementation quality - практическое расширение для агента (`extension`), основанное на пересечении продуктовых рисков, Human-AI guidance и design-system thinking. Это не универсальный чеклист.

## UI - Это Product Decision Surface

UI не просто визуальное оформление. Это место, где product assumptions становятся поведением пользователя. Любая кнопка, state, label, empty screen, error message и loading behavior влияют на usability, trust, task completion и support cost.

Агент, который пишет UI, должен думать как product designer и engineer одновременно.

## Product-Grade UI Requirements

Для каждого user flow нужны:

- primary task and outcome;
- entry points and exit points;
- information hierarchy;
- happy path;
- empty state;
- loading state;
- error state;
- partial success state;
- permission/privacy state;
- undo/recovery path;
- accessibility;
- responsive behavior;
- instrumentation points;
- supportability and logs where relevant.

Если flow связан с AI, добавьте capabilities, limits, confidence, correction, feedback and fallback.

## Usability Risk

Usability risk не закрывается красивым интерфейсом. Нужно проверить:

- понимает ли пользователь terminology;
- видит ли next action;
- может ли исправить ошибку;
- не требует ли flow знания внутренней системы;
- насколько UI устойчив к long content, edge cases, mobile constraints;
- совпадает ли interaction с expectations from similar products.

## Accessibility And Inclusion

`extension`

Accessibility - не optional polish. Она влияет на product reach, legal risk, user trust and system quality.

Минимум:

- semantic structure;
- keyboard navigation;
- focus states;
- readable contrast;
- labels for form controls;
- screen-reader meaningful text;
- no information conveyed only by color;
- robust layout for zoom, long strings and small screens;
- captions/alternatives for media when relevant.

Для AI/data products проверяйте fairness, bias, localization and inclusive data representation.

## Design System Fit

Перед созданием нового component:

- есть ли existing component/pattern;
- почему он не подходит;
- является ли проблема one-off or repeated;
- можно ли расширить existing API без breaking change;
- какие docs/examples нужны;
- кто будет поддерживать change.

Новый UI должен быть consistent, но consistency не означает uniformity. Если context отличается, pattern может отличаться осознанно.

## Instrumentation

`extension`

UI должен помогать измерять outcome. События не должны ограничиваться `click button`. Нужны signals:

- task started/completed/abandoned;
- error shown/resolved;
- correction/undo used;
- AI output accepted/rejected/edited;
- component variant used;
- time to completion;
- support-triggering conditions.

Instrumentation должна уважать privacy and data minimization.

## Implementation Quality

`extension`

Продуктовый UI в коде должен быть поддерживаемым:

- clear state model;
- predictable data loading;
- explicit error handling;
- no hidden business logic in visual components;
- reusable components only when duplication and change pattern justify it;
- tests for high-risk behavior;
- no fragile layout shifts;
- observability for important failures.

## Agent Checklist

- Какой user outcome поддерживает этот screen/flow?
- Какие assumptions UI проверяет или реализует?
- Какие states отсутствуют?
- Что происходит при failure, latency, no data, permission denied?
- Можно ли отменить or recover?
- Какие accessibility requirements покрыты?
- Соответствует ли UI design system?
- Какие analytics events нужны?
- Какие product risks остаются после implementation?

## Red Flags

- Есть только happy path макет.
- Error state звучит как внутренний exception.
- Loading state скрывает, что система может долго думать.
- Component создан ради одного use case без evidence reuse.
- UI не измеряет completion or failure.
- AI output нельзя исправить.
