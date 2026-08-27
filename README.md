# Codex Pro Agent Skills

![Codex Skills hero](assets/codex-skills-hero.png)

Niche, high-signal skills for professional Codex agents. The repo layout is intentionally small and direct: each skill lives under `skills/<skill-name>` and contains its own `SKILL.md`, optional `agents/` metadata, and optional bundled resources.

## Available Skills

- `ml-system-design`: ML system design, review, validation, productionization, and maintenance.
- `system-design`: Classical software systems and distributed architecture design, review, capacity planning, and production readiness.
- `sre-reliability-engineering`: SLOs, observability, incidents, on-call, reliability architecture, and production readiness.
- `software-engineering`: Long-lived software design, review, testing, migration, and maintainability.
- `qa-testing`: QA strategy, automated tests, CI/CD quality gates, and release validation.
- `agent-llm-evals`: LLM evals, agent workflow evals, graders, traces, and continuous evaluation.
- `ios-app-development`: Production iOS architecture, Flutter/native integration, release, and maintenance.
- `flutter-skill`: Flutter architecture, iOS integration, testing, performance, and release readiness.
- `swift-skill`: Native Swift, SwiftUI/UIKit, SwiftData, concurrency, testing, and App Store readiness.
- `telegram-mini-apps`: Telegram Mini App architecture, initData auth, WebApp API, payments, testing, and production readiness.
- `business-product-consulting`: business/product consulting judgment for product engineering, communication, metrics, AI adoption, and org flow.
- `product-design`: Product discovery, UI/UX, AI product design, design systems, validation, and business outcomes.
- `llm-council`: A Codex adaptation of Andrej Karpathy's `llm-council` multi-model review pattern.

### Information Writing Skill Family

For natural-language writing requests in Russian and English, install `information-writing`. It is chat-first: it adapts to the conversation, task context, and the user's demonstrated fluency. Add a specialized skill only when the operation or deliverable needs its additional discipline.

- `information-writing`: Adaptive baseline for substantive chat answers and informational writing.
- `information-editing`: Copyediting, rewriting, audience adaptation, restructuring, and compression.
- `information-source-summary`: Faithful source-bound summaries of supplied material.
- `information-research-synthesis`: Multi-source and external research synthesis.
- `information-explanation`: Explanations that build a correct mental model.
- `information-decision-support`: Comparative decision analysis and recommendations.
- `audience-adaptation`: Technical, nontechnical, executive, and execution reader modes.
- `technical-writing`: Documentation, architecture/design docs, API references, runbooks, troubleshooting, benchmarks, and technical analyses.
- `execution-writing`: Status reports, decision memos, and engineering execution plans.
- `information-presentation`: Claim-driven slide content and speaker notes.

## Install All From GitHub

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/ml-system-design skills/system-design skills/sre-reliability-engineering skills/software-engineering skills/qa-testing skills/agent-llm-evals skills/ios-app-development skills/flutter-skill skills/swift-skill skills/telegram-mini-apps skills/business-product-consulting skills/product-design skills/llm-council skills/information-writing skills/information-editing skills/information-source-summary skills/information-research-synthesis skills/information-explanation skills/information-decision-support skills/audience-adaptation skills/technical-writing skills/execution-writing skills/information-presentation
```

Restart Codex after installing or updating skills.

## Install One Skill From GitHub

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/ml-system-design
```

Replace the path with any available skill:

```bash
skills/ml-system-design
skills/system-design
skills/sre-reliability-engineering
skills/software-engineering
skills/qa-testing
skills/agent-llm-evals
skills/ios-app-development
skills/flutter-skill
skills/swift-skill
skills/telegram-mini-apps
skills/business-product-consulting
skills/product-design
skills/llm-council
skills/information-writing
skills/information-editing
skills/information-source-summary
skills/information-research-synthesis
skills/information-explanation
skills/information-decision-support
skills/audience-adaptation
skills/technical-writing
skills/execution-writing
skills/information-presentation
```

## Install From A Local Clone

From a local clone:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/ml-system-design "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/system-design "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/sre-reliability-engineering "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/software-engineering "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/qa-testing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/agent-llm-evals "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/ios-app-development "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/flutter-skill "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/swift-skill "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/telegram-mini-apps "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/business-product-consulting "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/product-design "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/llm-council "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-writing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-source-summary "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-editing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-research-synthesis "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-explanation "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-decision-support "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/audience-adaptation "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/technical-writing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/execution-writing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-presentation "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Restart Codex after installing or updating skills.

## Adding Skills

Use this shape for every new skill:

```text
skills/<skill-name>/
├── SKILL.md
├── agents/
│   └── openai.yaml
└── references/
```

Keep `SKILL.md` compact and put detailed domain notes in `references/` so Codex can load only the files needed for the current task.
