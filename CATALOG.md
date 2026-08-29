# Skill Catalog

Install only the skills that an agent is likely to use. Codex selects a skill from its
name and concise description before it reads the skill body, so an unrelated domain
adds selection noise without improving a task.

The physical layout intentionally remains flat under `skills/`: that is the discovery
shape expected by Codex. Navigation is provided by narrow primary owners, the catalog,
and named installation bundles rather than nested skill directories.

## Navigation Contract

The hierarchy is a decision convention, not a forced runtime call stack. Codex sees a
skill's name and concise description before it reads the skill body. A discriminating
primary owner handles the broad decision, then explicitly hands implementation or
specialist questions to a narrower skill. Do not load every neighbouring skill merely
because a request touches the same product.

1. Choose the domain owner from the unresolved decision, not from a technology named
   in passing.
2. Let that owner select a stack, architecture, product direction, or component.
3. Load a specialist only for its implementation surface.
4. Add quality, reliability, evaluation, or security skills only when their evidence
   is needed.

| Domain | Start with | Then route to |
|---|---|---|
| User problem, discovery, UX, requirements, design system | `product-design` | `business-product-consulting` for strategic or executive choices; the appropriate implementation domain after validation |
| Business case, market or portfolio choice, operating model, executive recommendation | `business-product-consulting` | `product-design` for user evidence and UX; the affected engineering domain for implementation |
| Classical service architecture | `system-design` | `software-engineering` for changeability, `qa-testing` for verification, `sre-reliability-engineering` for operation |
| iOS product or an unknown native/cross-platform split | `ios-app-development` | `swift-skill` for native implementation, `flutter-skill` for Flutter, both only at a defined mixed boundary |
| Telegram Mini App | `telegram-mini-apps` | `system-design`, `software-engineering`, or `qa-testing` only for the non-Telegram layer they own |

## Architecture Domains

| Question | Primary skill | Delegate detailed work to |
|---|---|---|
| How should a classical service, API, queue, database, or distributed system work? | `system-design` | `sre-reliability-engineering`, `software-engineering`, `qa-testing` |
| How should a predictive or classical ML system be designed, trained, validated, and operated? | `ml-system-design` | `nlp-modeling-and-adaptation` for text-model changes |
| How should an LLM product be composed from prompts, RAG, agents, models, and fallbacks? | `llm-system-design` | RAG, agent, adaptation, inference, eval, and security specialists |
| Which text model family or adaptation method should we use? | `nlp-modeling-and-adaptation` | `llm-system-design`, `agent-llm-evals` |
| Why is a self-hosted LLM slow, expensive, or out of capacity? | `llm-inference-optimization` | `llm-system-design`, `sre-reliability-engineering` |
| How should documents be retrieved and grounded? | `rag-engineering` | `agent-llm-evals`, `genai-security-testing` |
| How should an LLM agent call tools and recover? | `agent-workflows` | `agent-llm-evals`, `genai-security-testing` |
| How should an LLM system be measured and released? | `agent-llm-evals` | the affected domain skill |
| How should an owned LLM/RAG/agent system be hardened and authorized-tested? | `genai-security-testing` | `agent-llm-evals`, `sre-reliability-engineering` |

Use one primary skill for the decision, then load companion skills only for their
specialist implementation. This prevents a broad system-design request from dragging
every LLM reference into context.

## Installation Bundles

Bundles are task-oriented and deliberately overlap. A repeated path is safe to
install: the official installer replaces the same skill directory. `base` is a compact
default; all other domains are opt-in. There is no empty computer-vision bundle today:
future CV skills will use explicit `computer-vision-*` bundles and will not be added to
`base`.

| Bundle | Intended work |
|---|---|
| `base` | General professional engineering and writing |
| `writing-specialists` | Full writing, source, research, decision, and presentation family |
| `product-and-consulting` | Product discovery, UX, business framing, and stakeholder decisions |
| `service-platform` | Classical services, engineering delivery, QA, and reliability |
| `classic-ml` | Predictive/classical ML and text-model selection/adaptation |
| `llm-product` | User-facing LLM products, RAG, agents, evals, and security |
| `llm-platform` | Self-hosted LLM serving and platform operations |
| `llm-adaptation` | Fine-tuning/adaptation and deployment of text/LLM models |
| `agent-systems` | Agent workflow, evaluation, safety, and production controls |
| `ios-apps` | iOS, Swift, Flutter, and mixed-stack work |
| `telegram-mini-apps` | Telegram Mini Apps |
| `all` | Every skill in this release |

The machine-readable membership is [bundles.yaml](bundles.yaml). Use
`./scripts/install-bundle.sh --list` to inspect it or
`./scripts/install-bundle.sh --bundle base --bundle llm-product` to print the exact
official installer command. `--run` performs a first installation; `--run --replace`
downloads to staging, then backs up and replaces the affected existing skills explicitly.
