# Codex Pro Agent Skills

![Codex Skills hero](assets/codex-skills-hero.png)

Niche, high-signal skills for professional Codex agents. The repo layout is intentionally small and direct: each skill lives under `skills/<skill-name>` and contains its own `SKILL.md`, optional `agents/` metadata, and optional bundled resources.

## Available Skills

- `ml-system-design`: ML system design, review, validation, productionization, and maintenance.
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

## Install All From GitHub

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/ml-system-design skills/sre-reliability-engineering skills/software-engineering skills/qa-testing skills/agent-llm-evals skills/ios-app-development skills/flutter-skill skills/swift-skill skills/telegram-mini-apps skills/business-product-consulting skills/product-design skills/llm-council
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
```

## Install From A Local Clone

From a local clone:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/ml-system-design "${CODEX_HOME:-$HOME/.codex}/skills/"
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
