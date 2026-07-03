# Calibrated Trust And Human Control

Related: [AI/ML UX](06-ai-ml-product-ux.md), [UI/UX quality](08-ui-ux-product-quality.md), [validation](05-validation-and-assumption-tests.md), [anti-patterns](13-anti-patterns.md)

## Цель: Не Больше Доверия, А Точнее Доверие

В AI-продукте пользователь должен доверять системе там, где она сильна, и перепроверять или брать контроль там, где она слаба. Overtrust и undertrust одинаково вредны: первый ведет к ошибочным решениям, второй делает AI бесполезным.

## HAX 18 Guidelines Как Checklist

Microsoft HAX группирует важные требования к Human-AI interaction. Для агента практичная версия:

1. Сделать clear, что система может делать.
2. Сделать clear, насколько хорошо она это делает.
3. Тайминг действий зависит от context.
4. Показывать contextually relevant information.
5. Учитывать social norms.
6. Снижать social biases.
7. Обеспечить efficient invocation.
8. Обеспечить efficient dismissal.
9. Обеспечить efficient correction.
10. Scope services when in doubt.
11. Объяснять, почему система так поступила.
12. Помнить recent interactions, где это помогает.
13. Учиться на behavior.
14. Адаптироваться осторожно.
15. Собирать granular feedback.
16. Показывать consequences of user actions.
17. Давать global controls.
18. Уведомлять о changes in capabilities or behavior.

## Capability And Limit Disclosure

Onboarding должен объяснять benefit and limits, не модельную магию. Пользователь должен быстро понять:

- какие задачи поддерживаются;
- какие задачи не поддерживаются;
- какие inputs улучшают result;
- когда output вероятностный;
- как проверить или исправить результат.

Не завышайте expectations. Если chatbot говорит как человек, пользователь может ожидать human-level language understanding and intent handling.

## Confidence И Uncertainty

Показывать confidence стоит только если это помогает принять решение. Число вроде `87%` часто хуже понятного indication: `high confidence`, `needs review`, `based on limited data`, `similar cases disagree`.

Перед показом confidence проверьте:

- понимает ли пользователь, что это значит;
- меняет ли это decision quality;
- не создает ли overtrust;
- нужен ли альтернативный UI: ranking, categories, explanation, warnings, review gates.

## Correction, Dismissal, Undo

AI должен быть easy to invoke и easy to dismiss. Если система ошиблась, пользователь должен иметь path forward:

- edit output;
- regenerate or retry;
- choose another option;
- report incorrect result;
- undo automated action;
- switch to manual flow;
- reset learned preferences.

Correction должна быть частью core UX, а не hidden support path.

## Global Controls

Global controls особенно важны для personalization, monitoring, notifications and automation. Пользователь должен понимать, что система отслеживает, как учится, где применяет feedback, и как это изменить.

Примеры controls:

- отключить personalization;
- очистить или reset preferences;
- выбрать domains/data sources;
- ограничить automation level;
- настроить notification/change behavior.

## Graceful Failure

AI system will fail. Хороший product design заранее проектирует failure:

- признать ошибку человеческим языком;
- объяснить limit без оправданий;
- показать next step;
- сохранить user work;
- не оставлять dead end;
- собрать useful feedback;
- мониторить recurring failures.

## Agent Checklist

- Пользователь видит capabilities and limits до риска?
- Есть efficient dismiss/correct/undo?
- Есть manual or lower-risk fallback?
- Есть explanation tied to user action?
- Feedback granular and useful?
- Адаптация не ломает привычное поведение?
- Изменения capabilities communicated?
- Controls доступны глобально, не только в момент ошибки?

## Red Flags

- AI output выглядит authoritative, но uncertainty скрыта.
- Нет easy dismissal.
- Correction требует обращения в support.
- Персонализация меняет поведение без уведомления.
- Пользователь не знает, как feedback повлияет на future outputs.
