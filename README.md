# Codex Pro Agent Skills

![Codex Skills hero](assets/codex-skills-hero.png)

Focused, high-signal skills for professional Codex agents. Every skill lives in
`skills/<skill-name>` with a compact `SKILL.md` and optional references. The library
uses narrow primary owners instead of one catch-all guide: an agent first selects the
right decision surface, then follows only the companion skills it needs.

Read [the skill catalog](CATALOG.md) for the navigation model and bundle purpose.

## Available Skills

**Classical systems**

- `system-design`: Services, APIs, data, queues, capacity, and distributed systems.
- `software-engineering`: Long-lived software design, change safety, testing, and delivery.
- `qa-testing`: Classic software QA strategy, suites, and quality gates.
- `sre-reliability-engineering`: SLOs, observability, incidents, on-call, and reliability.

**ML and LLM systems**

- `ml-system-design`: Predictive/classical ML lifecycle, data, validation, training, and drift.
- `llm-system-design`: LLM-product composition, model/provider routing, prompt/RAG/agent/adaptation choice, budgets, and fallback.
- `nlp-modeling-and-adaptation`: Text-model selection from rules/TF-IDF/BM25/BERT through SFT/PEFT/preference optimization.
- `llm-inference-optimization`: Self-hosted LLM runtime, KV cache, batching, quantization, and capacity.
- `rag-engineering`: Grounded RAG ingestion, retrieval, context, diagnostics, and release.
- `agent-workflows`: Agent control loops, tools, state, handoffs, and recovery.
- `agent-llm-evals`: LLM/agent evals, graders, traces, regression, and release gates.
- `genai-security-testing`: Defensive hardening and authorized testing of LLM/RAG/agent systems.
- `llm-council`: Codex adaptation of the multi-model review pattern inspired by [karpathy/llm-council](https://github.com/karpathy/llm-council).

**Computer vision**

- `computer-vision-system-design`: CV product and perception-pipeline framing across cameras, tasks, stages, and handoffs.
- `computer-vision-data-and-labeling`: CV data collection, annotation schemas, label QA, splits, leakage, augmentation, and active learning.
- `computer-vision-modeling-and-training`: CV model-family choice, training, transfer learning, SSL, metric learning, OCR/VLM adaptation, and losses.
- `computer-vision-evaluation`: CV metrics, visual error analysis, calibration, slices, robustness, drift, and release evidence.
- `computer-vision-inference-optimization`: Non-LLM CV inference profiling, preprocessing, video timing, vector search, conversion, compression, and deployment.

**Product and mobile**

- `business-product-consulting`: Product/business framing, decisions, metrics, and organization.
- `product-design`: Product discovery, UX, AI product design, validation, and design systems.
- `ios-app-development`: Cross-stack iOS architecture, release, and maintenance.
- `swift-skill`: Native Swift, SwiftUI/UIKit, concurrency, testing, and release readiness.
- `flutter-skill`: Flutter architecture, iOS integration, testing, and release readiness.
- `telegram-mini-apps`: Telegram Mini App architecture, authentication, payments, testing, and production readiness.

**Information writing**

- `information-writing`: Adaptive baseline for substantive chat answers and informational writing.
- `information-editing`: Copyediting, rewriting, audience adaptation, restructuring, and compression.
- `information-source-summary`: Faithful source-bound summaries of supplied material.
- `information-research-synthesis`: Multi-source and external research synthesis.
- `information-explanation`: Explanations that build a correct mental model.
- `information-decision-support`: Comparative decision analysis and recommendations.
- `audience-adaptation`: Technical, nontechnical, executive, and execution reader modes.
- `technical-writing`: Documentation, design docs, runbooks, benchmarks, and technical analyses.
- `execution-writing`: Status reports, decision memos, and engineering execution plans.
- `information-presentation`: Claim-driven slide content and speaker notes.

## Install A Bundle

Install `base` first for general professional work, then opt into the domains an agent
will actually use. This keeps optional domains, including computer vision, out of the
installed selection set unless explicitly requested.

Clone the repository and inspect available bundles:

```bash
git clone https://github.com/BejeweledMe/codex-pro-agent-skills.git
cd codex-pro-agent-skills
./scripts/install-bundle.sh --list
```

The helper uses the official Codex GitHub installer. It prints the exact command by
default; add `--run` to execute a first installation. Bundles can be combined and
deduplicate shared skills:

```bash
./scripts/install-bundle.sh --bundle base --bundle llm-product --run
```

The official installer does not overwrite existing skill directories. To update a
bundle explicitly, add `--replace`: the helper first downloads the complete bundle to
a staging directory, then moves only the affected installed directories into
`~/.codex/skills/.bundle-backups/<timestamp>/` and replaces them.

```bash
./scripts/install-bundle.sh --bundle base --bundle llm-product --run --replace
```

Examples for other focused installs:

```bash
./scripts/install-bundle.sh --bundle classic-ml --run
./scripts/install-bundle.sh --bundle computer-vision-core --run
./scripts/install-bundle.sh --bundle computer-vision-training --run
./scripts/install-bundle.sh --bundle computer-vision-systems --run
./scripts/install-bundle.sh --bundle computer-vision-all --run
./scripts/install-bundle.sh --bundle llm-platform --run
./scripts/install-bundle.sh --bundle agent-systems --run
./scripts/install-bundle.sh --bundle ios-apps --run
./scripts/install-bundle.sh --bundle telegram-mini-apps --run
```

Install every skill in this release:

```bash
./scripts/install-bundle.sh --bundle all --run
```

`bundles.yaml` is the source of truth for membership. Bundles intentionally overlap:
they describe a job to be done, not a filesystem hierarchy.

## Install With The Official GitHub Command

The official installer accepts explicit skill paths. This is useful when installing a
single skill or when a local helper is not desired.

Install one skill:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/llm-system-design
```

Install the `base` bundle directly:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/information-writing skills/information-editing skills/audience-adaptation skills/technical-writing skills/execution-writing skills/software-engineering skills/qa-testing skills/system-design skills/sre-reliability-engineering
```

Install all current skills directly:

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --method git \
  --repo BejeweledMe/codex-pro-agent-skills \
  --path skills/agent-llm-evals skills/agent-workflows skills/audience-adaptation skills/business-product-consulting skills/computer-vision-data-and-labeling skills/computer-vision-evaluation skills/computer-vision-inference-optimization skills/computer-vision-modeling-and-training skills/computer-vision-system-design skills/execution-writing skills/flutter-skill skills/genai-security-testing skills/information-decision-support skills/information-editing skills/information-explanation skills/information-presentation skills/information-research-synthesis skills/information-source-summary skills/information-writing skills/ios-app-development skills/llm-council skills/llm-inference-optimization skills/llm-system-design skills/ml-system-design skills/nlp-modeling-and-adaptation skills/product-design skills/qa-testing skills/rag-engineering skills/software-engineering skills/sre-reliability-engineering skills/swift-skill skills/system-design skills/technical-writing skills/telegram-mini-apps
```

Restart Codex after installing or updating skills.

## Adding Skills

Keep new skills flat under `skills/<skill-name>`. Give them a discriminating
frontmatter description, a compact entrypoint, references only for conditional detail,
and explicit handoffs to adjacent owners. Add the skill to `bundles.yaml`, update the
catalog, and run the validation scripts before publishing.
