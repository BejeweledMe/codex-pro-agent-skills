# Codex Pro Agent Skills

![Codex Skills hero](assets/codex-skills-hero.png)

Niche, high-signal skills for professional Codex agents. The repo layout is intentionally small and direct: each skill lives under `skills/<skill-name>` and contains its own `SKILL.md`, optional `agents/` metadata, and optional bundled resources.

## Available Skills

- `ml-system-design`: ML system design, review, validation, productionization, and maintenance.
- `sre-reliability-engineering`: SLOs, observability, incidents, on-call, reliability architecture, and production readiness.
- `llm-council`: A Codex adaptation of Andrej Karpathy's `llm-council` multi-model review pattern.

## Install All From GitHub

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/ml-system-design skills/sre-reliability-engineering skills/llm-council
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
skills/llm-council
```

## Install From A Local Clone

From a local clone:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/ml-system-design "${CODEX_HOME:-$HOME/.codex}/skills/"
cp -R skills/sre-reliability-engineering "${CODEX_HOME:-$HOME/.codex}/skills/"
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
