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

Install `information-writing-router` for natural-language routing of Russian and English writing requests. It selects one operation and, when useful, one audience and one artifact skill. The family contains:

- `information-writing-router`: Natural-language entry point for documentation, reports, summaries, rewrites, explanations, decisions, and presentations.
- `information-style`: Baseline clarity, structure, and information-density pass.
- `information-research-synthesis`: Multi-source and external research synthesis.
- `information-source-summary`: Faithful source-bound summaries of supplied material.
- `information-editing`: Copyediting, rewriting, audience adaptation, restructuring, and compression.
- `information-explanation`: Explanations that build a correct mental model.
- `information-decision-support`: Comparative decision analysis and recommendations.
- `information-technical-audience`: Adaptation for technical specialists.
- `information-nontechnical-audience`: Adaptation for non-specialist readers.
- `information-executive-audience`: Adaptation for executive decision-makers.
- `information-execution-audience`: Adaptation for delivery and operational owners.
- `technical-documentation`: Architecture and design docs, API references, runbooks, and troubleshooting guides.
- `technical-analysis-report`: Technical evaluations, benchmarks, experiments, and engineering analyses.
- `progress-reporting`: Project and work status reports.
- `decision-memo`: Decision-focused written memos.
- `engineering-execution-plan`: Actionable engineering delivery plans.
- `information-presentation`: Claim-driven slide content and speaker notes.

## Install All From GitHub

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/ml-system-design skills/system-design skills/sre-reliability-engineering skills/software-engineering skills/qa-testing skills/agent-llm-evals skills/ios-app-development skills/flutter-skill skills/swift-skill skills/telegram-mini-apps skills/business-product-consulting skills/product-design skills/llm-council skills/information-writing-router skills/information-style skills/information-research-synthesis skills/information-source-summary skills/information-editing skills/information-explanation skills/information-decision-support skills/information-technical-audience skills/information-nontechnical-audience skills/information-executive-audience skills/information-execution-audience skills/technical-documentation skills/technical-analysis-report skills/progress-reporting skills/decision-memo skills/engineering-execution-plan skills/information-presentation
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
skills/information-writing-router
skills/information-style
skills/information-research-synthesis
skills/information-source-summary
skills/information-editing
skills/information-explanation
skills/information-decision-support
skills/information-technical-audience
skills/information-nontechnical-audience
skills/information-executive-audience
skills/information-execution-audience
skills/technical-documentation
skills/technical-analysis-report
skills/progress-reporting
skills/decision-memo
skills/engineering-execution-plan
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
cp -R skills/information-writing-router "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-style "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-research-synthesis "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-source-summary "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-editing "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-explanation "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-decision-support "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-technical-audience "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-nontechnical-audience "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-executive-audience "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/information-execution-audience "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/technical-documentation "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/technical-analysis-report "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/progress-reporting "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/decision-memo "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/engineering-execution-plan "${CODEX_HOME:-$HOME/.codex}/skills/"
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
