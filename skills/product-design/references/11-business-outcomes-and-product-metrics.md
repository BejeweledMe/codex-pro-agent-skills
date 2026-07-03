# Business Outcomes And Product Metrics

Related: [operating model](02-product-operating-model.md), [discovery](03-discovery-and-opportunity-solution-trees.md), [validation](05-validation-and-assumption-tests.md), [design system metrics](10-design-system-governance-adoption-metrics.md)

## Outcome Before Output

Output - что команда поставила. Outcome - что изменилось у пользователя, бизнеса или системы. Product design должен связывать every solution с outcome, иначе команда оптимизирует shipping, а не impact.

Примеры:

- Output: добавить AI summary.
- Product outcome: больше пользователей завершают review task за меньшее время без роста ошибок.
- Business outcome: сокращение support cost или рост activation.

## Customer Value И Business Value

Product Talk подчеркивает tension между customer value and business value. Продукт должен создавать customer value способом, который поддерживает business value over time. Lovable product без business viability может быть закрыт. Business value без customer value разрушает доверие and retention.

## Metric Layers

Полезно разделять:

- `Business metrics`: revenue, churn, retention, cost, margin, risk reduction.
- `Product outcome metrics`: behavior/sentiment в продукте, completion, adoption of workflow, user confidence.
- `Experience metrics`: task success, time, errors, satisfaction, trust calibration.
- `Operational metrics`: latency, uptime, defect rate, support tickets, moderation load.
- `Model metrics`: precision, recall, calibration, hallucination rate, unsafe output rate.
- `Design system metrics`: component usage, accessibility compliance, consistency, delivery speed.

Model/design/component metrics не заменяют product outcome metrics.

## Leading And Lagging Indicators

Lagging indicators говорят, что уже произошло. Leading indicators помогают раньше понять, движемся ли в верном направлении.

Пример AI writing tool:

- Leading: accepted suggestions, edit distance, correction rate, time to first useful draft.
- Lagging: user retention, paid conversion, support tickets, long-term trust.

Пример design system:

- Leading: component usage, migration progress, docs search success.
- Lagging: launch speed, defect reduction, accessibility compliance, reduced duplicated work.

## Success And Failure Thresholds

Перед test/release нужно определить:

- target metric;
- guardrail metrics;
- threshold for success;
- threshold for rollback or investigation;
- owner and response action.

Без thresholds команда будет rationalize любые данные.

## AI Metrics Need User Meaning

AI metric должна переводиться в user/business meaning. Precision/recall tradeoff имеет смысл только через цену false positives and false negatives. Confidence имеет смысл только если помогает пользователю принять лучшее решение.

Плохой пример: `model accuracy grew 3%`.

Лучше: `false positives в high-risk scenario снизились, review time не вырос, user correction rate упал`.

## Design System Metrics Need Outcomes

Component usage важно, но недостаточно. Оно не доказывает value само по себе. Дополняйте:

- time saved;
- reduced rework;
- fewer accessibility defects;
- improved consistency;
- faster onboarding;
- lower custom component drift;
- fewer support questions.

## Agent Checklist

- Какой desired outcome?
- Какая user behavior metric связана с outcome?
- Какая business metric связана с outcome?
- Какие leading indicators появятся раньше?
- Какие guardrails защищают от local optimization?
- Какие thresholds заранее приняты?
- Как metric будет instrumented?
- Что команда сделает при success, neutral, failure?

## Red Flags

- Метрика измеряет только output: shipped screens, components, prompts.
- AI оценивается только offline score.
- Design system оценивается только количеством компонентов.
- Business outcome назван, но команда не может на него влиять.
- Нет guardrails для negative impact.
