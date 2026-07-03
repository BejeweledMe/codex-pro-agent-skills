# Design Systems As Product Infrastructure

Related: [UI/UX quality](08-ui-ux-product-quality.md), [governance and metrics](10-design-system-governance-adoption-metrics.md), [business outcomes](11-business-outcomes-and-product-metrics.md)

## Design System Не Только UI Kit

Design system может включать visual language, components, code snippets, design-tool libraries, guidelines, docs, patterns, tokens and workflows. В этой базе design system рассматривается как organizational practice and software product.

Если система состоит только из Figma components или React package, она еще не design system practice. Ей нужны users, adoption, docs, release process, governance, contribution, metrics and support.

## Зачем Она Нужна

Design systems помогают организациям с несколькими digital products:

- снижать duplicated work;
- повышать consistency;
- ускорять delivery;
- освобождать команды для unfamiliar problems and innovation;
- улучшать accessibility and quality at scale;
- создавать общий язык между design, engineering and product.

Но эти benefits не появляются автоматически. Система должна быть встроена в способ работы организации.

## Design System As Product

У design system есть пользователи:

- product designers;
- engineers;
- PMs;
- content designers;
- QA;
- accessibility specialists;
- support/ops where relevant;
- downstream product teams.

У нее есть jobs-to-be-done:

- быстро собрать consistent UI;
- понять correct component usage;
- ship without breaking accessibility;
- migrate safely;
- discover available patterns;
- request or contribute missing components;
- understand releases and breaking changes.

## Practical Product Surface

`synthesis`

Практический baseline для design system as product infrastructure. Это не формальный maturity standard, а рабочий набор поверхностей, которые агент должен искать или проектировать:

- foundations: typography, color, spacing, motion, accessibility rules;
- design tokens with ownership and versioning;
- reusable components in design and code;
- guidelines and examples;
- Storybook or equivalent developer docs;
- contribution path;
- release notes and changelog;
- support channel or office hours;
- adoption and quality metrics.

## System Boundaries

Design system не обязана решать все. Она должна покрывать repeated cross-product needs. One-off product-specific patterns могут жить в product code, пока evidence не покажет, что это reusable system need.

Вопросы:

- Это repeated need across teams?
- Компонент нужен для consistency or speed?
- Есть ли owner для maintenance?
- Как он будет documented, tested, versioned?
- Как он будет deprecated?

## Culture And Ownership

Публичные материалы `Design That Scales` подчеркивают organizational practice: многие системы проваливаются не из-за отсутствия kit/library, а потому что не встроены в работу организации.

Система не должна восприниматься как `чужая библиотека`. Если ее владельцы только диктуют правила, adoption страдает. Если contribution полностью uncontrolled, consistency страдает. Нужен баланс.

## AI And Design Systems

zeroheight 2026 показывает прагматичное отношение practitioners: AI интересен как tool for documentation, code generation, process automation, linting and guidance. К AI-generated design есть сильный скепсис.

Практическое применение AI:

- draft docs;
- generate release notes;
- detect component usage;
- lint against design system rules;
- generate examples;
- support MCP/chatbot access to docs;
- automate token pipelines and checks.

AI не должен заменять design judgment, governance and quality review.

## Agent Checklist

- Кто users design system?
- Какие repeated product needs она закрывает?
- Какие artifacts есть: design, code, docs, tokens, examples?
- Есть ли contribution process?
- Как releases communicated?
- Как измеряется adoption in design and code?
- Как система поддерживает accessibility?
- Как AI/automation помогает без ухудшения quality?

## Red Flags

- `Design system готова`, потому что есть Figma kit.
- Нет code implementation или docs для engineers.
- Компоненты есть, но product teams используют custom forks.
- Нет owner for breaking changes.
- Нет migration path.
- Нет metrics besides docs page views.
