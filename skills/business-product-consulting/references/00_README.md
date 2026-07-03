# Consulting Skills For Product Development

Эта папка - прикладная база знаний для агентов и разработчиков, которые должны думать не только о коде, но и о бизнесе, продукте, коммуникации, метриках, организации работы и будущих последствиях решений.

Практическая база для business/product consulting judgment: как формулировать проблему, видеть выгоду, находить минусы, строить аргумент, оценивать product/market смысл, не ломать flow команды и не путать активность с результатом.

## Core Rule

Не начинайте с реализации. Сначала сформулируйте:

1. Что изменилось в бизнесе, продукте, рынке, пользователях или системе.
2. Почему это важно сейчас.
3. Кто stakeholder и какая decision ему нужна.
4. Какой главный вывод или рекомендация.
5. Какие альтернативы, выгоды, риски и trade-offs.
6. Какие метрики покажут успех, вред или нейтральный результат.
7. Какая команда будет владеть решением и как оно повлияет на flow.

## How To Read

- Быстро оформить мысль для executive update, RFC, PRD или demo: [02](02-scr-scqa-communication.md) -> [03](03-pyramid-principle.md) -> [10](10-presentation-review-checklist.md).
- Разобрать проблему или метрику: [01](01-business-thinking.md) -> [04](04-mece-issue-trees.md) -> [05](05-product-discovery-and-market-analysis.md).
- Оценить продуктивность разработки или AI adoption: [06](06-developer-productivity-space.md) -> [07](07-ai-assisted-development-dora.md) -> [09](09-risk-and-second-order-effects.md).
- Проверить организационный и архитектурный impact: [08](08-team-topologies-fast-flow.md) -> [09](09-risk-and-second-order-effects.md).
- Подготовить будущий Codex skill: [11](11-agent-operating-model-and-skill-outline.md).

## Files

- [01-business-thinking.md](01-business-thinking.md): как переводить тикет в business/product decision.
- [02-scr-scqa-communication.md](02-scr-scqa-communication.md): SCR, SCQ, SCQA для коротких memo, emails, RFC, PRD, postmortems.
- [03-pyramid-principle.md](03-pyramid-principle.md): answer-first структура, логика аргументов, executive storyline.
- [04-mece-issue-trees.md](04-mece-issue-trees.md): MECE, issue trees, workstreams, root-cause decomposition.
- [05-product-discovery-and-market-analysis.md](05-product-discovery-and-market-analysis.md): продуктовый и рыночный анализ как structured inquiry.
- [06-developer-productivity-space.md](06-developer-productivity-space.md): SPACE framework и защита от vanity metrics.
- [07-ai-assisted-development-dora.md](07-ai-assisted-development-dora.md): DORA 2025, AI as amplifier, governance, measurement, value stream.
- [08-team-topologies-fast-flow.md](08-team-topologies-fast-flow.md): fast flow, cognitive load, team types, interaction modes, platform-as-product.
- [09-risk-and-second-order-effects.md](09-risk-and-second-order-effects.md): future impact, hidden work, operational burden, reversibility.
- [10-presentation-review-checklist.md](10-presentation-review-checklist.md): pre-flight checklist для deck, memo, RFC, demo narrative.
- [11-agent-operating-model-and-skill-outline.md](11-agent-operating-model-and-skill-outline.md): как использовать базу в будущем agent skill.

## Agent Minimum Workflow

1. State the `answer-first` recommendation in one sentence.
2. Write the situation and complication before proposing work.
3. Decompose the problem with MECE only where it clarifies the work.
4. Connect the recommendation to user value and business value.
5. Define metrics and guardrails, not only outputs.
6. Check SPACE/DORA if the work affects developer productivity or AI adoption.
7. Check Team Topologies if the work changes ownership, dependencies, platform, architecture or handoffs.
8. Surface risks, second-order effects and rollback/owner.
9. Format the final answer as a decision aid, not a diary of analysis.

## Direct Sources vs Extensions

Each topic file separates:

- `Direct source`: ideas directly grounded in the referenced public source.
- `Extension`: applied guidance for software/product work derived from the source.

This distinction matters. For example, DORA 2025 directly says AI is an amplifier of the organizational system. Applying that to Codex agents, eval loops, PR review and release guardrails is an extension.
