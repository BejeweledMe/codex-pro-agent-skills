# AI/ML Product UX

Related: [trust and control](07-calibrated-trust-and-human-control.md), [validation](05-validation-and-assumption-tests.md), [UI/UX quality](08-ui-ux-product-quality.md), [anti-patterns](13-anti-patterns.md)

## Сначала Спросить: Нужен Ли AI

AI должен решать реальную user need уникальным способом. Не начинайте с `как добавить AI`. Начинайте с `какую проблему решаем` и `может ли AI решить ее лучше обычного UX, правил, фильтров, поиска, ручного workflow или vendor`.

AI чаще оправдан, когда нужны:

- personalization at scale;
- prediction under uncertainty;
- natural language understanding;
- recognition of broad classes;
- detection of changing low-frequency patterns;
- dynamic recommendation or generation;
- assistance in large, complex or ambiguous task spaces.

AI часто плохой выбор, когда важнее:

- predictability;
- simple static information;
- very low cost and speed to market;
- complete transparency of behavior;
- extremely high cost of error;
- tasks users strongly want to own themselves.

## Automation Vs Augmentation

Не все стоит автоматизировать. Automate, когда task boring, repetitive, dangerous, low agency, high scale, or easy to judge. Augment, когда task creative, personally meaningful, high-stakes, preference-heavy or socially valuable.

Продуктовый вопрос: пользователь хочет `сделай за меня` или `помоги мне сделать лучше`?

## AI UX Должен Показывать Capabilities И Limits

Пользователь должен понимать:

- что система умеет;
- насколько часто она может ошибаться;
- в каком контексте ей можно доверять;
- какие данные используются;
- что делать, если output плохой;
- как исправить, отклонить или настроить поведение.

Не обещайте human-like intelligence, если система не выдерживает такие ожидания. Не продавайте модель вместо пользы.

## Data Needs Are Product Needs

Google PAIR связывает user needs с data needs. Для AI-фичи агент должен явно проверить:

- какие examples, features, labels нужны;
- достаточно ли data coverage для target users and contexts;
- есть ли bias, privacy, security and fairness risks;
- как будет документироваться dataset;
- кто labels data и как проверяется label quality;
- как команда будет tuning and maintenance.

Data quality - не backend detail. Она формирует user experience.

## Reward Function И Product Metrics

Reward/objective function задает, что система считает успехом. Если она оптимизирует proxy, который не совпадает с user benefit, продукт будет вести себя неправильно.

Нужно обсуждать:

- false positives vs false negatives;
- precision vs recall tradeoff;
- second-order effects;
- long-term user benefit;
- negative impact metrics;
- thresholds and response actions.

Пример framing: если rejection rate рекомендаций превышает meaningful threshold, команда проверяет model/data/UX, а не только `улучшает prompt`.

## Explainability

Объяснение нужно не ради полноты, а ради user understanding and action. Иногда full explanation невозможна или непонятна пользователю; тогда лучше partial explanation, которая отвечает на вопрос пользователя: почему это предложено, какие inputs важны, что можно изменить.

Опасно показывать technical explanation, которая создает false confidence или перегружает decision.

## Feedback Loops

Feedback должен быть полезен пользователю и системе:

- explicit feedback: ratings, corrections, forms, preferences;
- implicit feedback: behavior signals;
- granular feedback: что именно было wrong/useful;
- consequence visibility: как feedback изменит future behavior;
- reset/override: пользователь может исправить learning mistakes.

Не собирайте feedback, если не можете объяснить value, privacy и impact.

## Agent Checklist

- AI дает unique value?
- Что будет non-AI baseline?
- Что пользователь должен понять об AI до первого использования?
- Как система показывает uncertainty or limits?
- Как пользователь correct/dismiss/undo output?
- Какой fallback при ошибке?
- Какие data/model risks влияют на UX?
- Как оценивается false positive/false negative cost?
- Какие signals пойдут в tuning?
- Как changes in model behavior будут communicated?

## Red Flags

- AI добавлен потому, что это возможно.
- UX скрывает неопределенность и ошибки.
- Пользователь не может отклонить или исправить output.
- Confidence показывается числом без объяснения смысла.
- Нет non-AI fallback.
- Dataset и reward function не обсуждались с product/design.
