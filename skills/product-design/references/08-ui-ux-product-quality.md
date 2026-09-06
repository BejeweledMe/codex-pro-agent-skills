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

## Deferred Readiness And Async Acceptance

For a flow with deferred code, data, or rendering, define when useful content is visible and when the first meaningful action succeeds. A painted control is not evidence that the user can operate it.

- Specify early-input behavior: accepted immediately, visibly held pending, or rejected with an understandable unavailable state. If input is queued or replayed, define what the user sees and how repeated activation avoids duplicate work.
- Make pending, timeout, error, and retry states truthful. Keep fallback geometry and semantic order stable enough that replacement does not move an action out from under the user or make the journey confusing.
- Define where focus stays or moves when content activates, is replaced, fails, or disappears. Preserve keyboard and touch completion, visible focus, and meaningful status/error announcements; do not make readiness depend on hover.
- For stale or asynchronous data, state the acceptable age and what happens after a write: whether the user must see their change immediately, may see pending confirmation, or must resolve a conflict. Distinguish local feedback, server acceptance, and an unknown outcome; a timeout alone does not mean the operation failed.
- Decide what a late result may change after navigation, cancellation, or a newer edit, and provide a recovery path when the promised state cannot be confirmed. Product acceptance cannot guarantee backend freshness or conflict handling without engineering evidence.

Check the journey under delayed code/data, early and repeated input, replacement of focused content, stale reads, and failed confirmation on representative devices and input modes. Record first-action success as well as visual progress. Pass these acceptance criteria to `$web-frontend-engineering` for implementation and to `$qa-testing` when a general verification strategy is needed. These checks extend the existing accessibility core; they do not establish WCAG conformance.

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
