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
| User problem, discovery, UX, requirements, design system | `product-design` | `business-product-consulting` for strategic or executive choices; the relevant engineering owner for technical input during discovery and implementation once the decision is sufficiently clear |
| Business case, market or portfolio choice, operating model, executive recommendation | `business-product-consulting` | `product-design` for user evidence and UX; the affected engineering domain for implementation |
| Classical service architecture | `system-design` | `api-contract-engineering` for HTTP artifacts; backend/database/data/platform owners for implementation; SWE/QA/SRE for change, verification, and operation |
| Computer-vision problem, sensor, task, or end-to-end perception pipeline | `computer-vision-system-design` | CV data, modeling, evaluation, and inference specialists for their decision surfaces; classical service owners for the surrounding platform |
| iOS product or an unknown native/cross-platform split | `ios-app-development` | `swift-skill` for native implementation, `flutter-skill` for Flutter, both only at a defined mixed boundary |
| Telegram Mini App | `telegram-mini-apps` | `web-frontend-engineering` for generic browser state/rendering; `application-security-engineering` for general controls; system-design, software-engineering, and qa-testing for surrounding architecture, change, and verification; Telegram-specific authorization remains local |

## Writing Operations

`information-writing` is the shared discipline for every substantive answer or
artifact. A more specific primary skill controls the evidence contract or deliverable
workflow, but never overrides explicit language, reader, source boundary, required
form, or length. `audience-adaptation` is a companion layer, not a competing primary
operation. `humanize-text` is a voice and surface-style companion for Russian or
English prose; it preserves the primary owner's workflow and evidence boundary.

| Reader need or artifact | Primary skill | Add only when needed |
|---|---|---|
| Direct user answer without a narrower operation | `information-writing` | `audience-adaptation` |
| New profile, company description, outreach draft, release, or product-page copy | `information-writing` | local professional-genre reference; evidence route or `audience-adaptation` when needed |
| Faithful account of supplied material | `information-source-summary` | `audience-adaptation` |
| Finding that needs new/external evidence, or supplied sources that do not form the complete evidence boundary | `information-research-synthesis` | `information-decision-support`, `audience-adaptation` |
| Faithful synthesis of one or more supplied sources that form the complete evidence boundary | `information-source-summary` | `audience-adaptation` |
| Correct mental model | `information-explanation` | `audience-adaptation` |
| Recommendation among alternatives | `information-decision-support` | research or source-summary evidence route, `execution-writing` for a decision memo |
| Edit, rewrite, restructure, or compress existing text without an artifact-specific contract | `information-editing` | `audience-adaptation` |
| Humanize text, remove robotic phrasing, or apply a natural-voice pass | `information-editing` for ordinary rewrites; `information-writing` for new prose; artifact owner for specialized deliverables | `humanize-text` |
| Create or substantively revise a technical document or engineering analysis | `technical-writing` | source/research route, `audience-adaptation` |
| Status update, decision memo, or execution plan | `execution-writing` | `information-decision-support`, `audience-adaptation` |
| Presentation or slide narrative for live delivery or independent reading | `information-presentation` | evidence route, `audience-adaptation` |

See [product and writing decisions](docs/product-and-writing-skill-decisions.md)
for the eight existing owners expanded by the two-book update.

## Architecture Domains

| Question | Primary skill | Delegate detailed work to |
|---|---|---|
| How should a classical service boundary, data authority, queue, or distributed guarantee work? | `system-design` | API, backend, database, data, or platform owners for implementation; SRE for reliability judgment |
| How should a predictive or classical ML lifecycle, benchmark claim, or deployment choice work? | `ml-system-design` | Modality owners for model choices; `neural-training-systems` for neural execution; `ai-platform-llmops` for shared infrastructure |
| How should a computer vision product or perception pipeline be framed and decomposed? | `computer-vision-system-design` | CV data, modeling, evaluation, and inference specialists; generic `system-design` and SRE only for the surrounding service |
| How should visual data, labels, splits, leakage, augmentation, or active-learning loops be handled? | `computer-vision-data-and-labeling` | `computer-vision-evaluation`, `computer-vision-modeling-and-training` |
| Which vision model family or adaptation method should be used? | `computer-vision-modeling-and-training` | `computer-vision-data-and-labeling`, `computer-vision-evaluation`, `computer-vision-inference-optimization` |
| How should CV quality be measured, debugged, calibrated, and released? | `computer-vision-evaluation` | `computer-vision-data-and-labeling`, `computer-vision-modeling-and-training`, `agent-llm-evals` only for LLM/VLM/agent harnesses |
| Why is a non-LLM CV pipeline slow, expensive, or hard to deploy? | `computer-vision-inference-optimization` | `computer-vision-modeling-and-training`, `computer-vision-evaluation`, `system-design`, `sre-reliability-engineering` |
| How should an LLM product be composed from prompts, RAG, agents, models, and fallbacks? | `llm-system-design` | RAG, agent, adaptation, inference, eval, and security specialists; `ai-platform-llmops` for shared infrastructure and `neural-training-systems` for neural execution |
| Which text model family or adaptation method should we use? | `nlp-modeling-and-adaptation` | `llm-system-design`, `agent-llm-evals` |
| Why is self-hosted LLM request execution slow, expensive, or out of capacity? | `llm-inference-optimization` | `ai-platform-llmops` for provisioning/controller/fleet policy; product owner for acceptable degradation; SRE for operational response |
| How should documents be retrieved and grounded? | `rag-engineering` | `agent-llm-evals` for harnesses, `genai-security-testing` for authorized boundary tests, `data-engineering` for generic publication and replay machinery |
| How should an LLM agent call tools and recover? | `agent-workflows` | `agent-llm-evals`, `genai-security-testing` |
| How should an LLM system be measured and released? | `agent-llm-evals` | the affected domain skill |
| How should an owned LLM/RAG/agent system be hardened and authorized-tested? | `genai-security-testing` | `application-security-engineering` for general controls, `security-review` for independent assessment, eval/SRE owners for their evidence and response |

Use one primary skill for the decision, then load companion skills only for their
specialist implementation. This prevents a broad system-design request from dragging
every LLM reference into context.

For computer vision, choose the unresolved decision surface first. Classification,
retrieval, detection, segmentation, OCR/documents, and video/tracking are narrow
references within those owners rather than separate top-level skills.

## Implementation And Assessment Owners

Start directly with these owners when the unresolved question is already at their
boundary. A small implementation change need not pass through a complete system
design, security council, or ML lifecycle.

| Question | Primary skill | Boundary retained by neighbors |
|---|---|---|
| How should browser UI state, rendering, loading, focus, and first-action behavior work? | `web-frontend-engineering` | Product defines acceptable interaction; API owns wire compatibility; Node owns standalone services |
| How should a Python handler, task, async resource, or Session/UoW behave? | `python-backend-engineering` | API owns observable contracts; database owns engine proof; system owns cross-service guarantees |
| How should a Node/TypeScript service manage async outcomes, streams, workers, and shutdown? | `node-typescript-backend-engineering` | Frontend owns browser UI; API owns wire compatibility; system/data own durable cross-service effects |
| How should an HTTP/OpenAPI artifact be authored, debugged, and evolved across consumers? | `api-contract-engineering` | System defines domain obligations; backend executes handlers and effects; AppSec chooses security controls |
| How should schema, constraints, isolation, SQL plans, maintenance, or restore work? | `database-engineering` | System owns source authority/cross-system promises; data owns derived pipelines; backend owns Session use |
| How should temporal data, CDC, transforms, publication, backfill, or replay remain correct? | `data-engineering` | Database proves engine behavior; ML owns label/feature semantics; RAG owns retrieval quality |
| How should infrastructure intent safely build, apply, reconcile, and recover? | `platform-devops-engineering` | SWE owns source/candidate lifecycle; SRE judges user reliability; AppSec chooses control policy |
| How should application security controls be designed or repaired? | `application-security-engineering` | Platform enforces build/deploy identity; GenAI owns specialist LLM/RAG/agent threat analysis, hardening and authorized tests; review assesses evidence |
| Are security claims supported for this scoped design, dependency, change, or release? | `security-review` | Implementers fix controls; accountable owners accept risk; review does not grant active-test authority |
| How should a neural update execute correctly and efficiently, including distributed restart? | `neural-training-systems` | ML/CV/NLP own objective/data/quality; AI platform owns capacity/placement; inference owns deployed execution |
| How should predictive/GenAI serving and training-job infrastructure be operated? | `ai-platform-llmops` | Runtime supplies service curves/KV/readiness constraints; training owns updates/collectives; generic platform owns substrate |

Pass only the useful boundary contract: invariant or objective, versions and
authority, observed evidence, supported transition, and recovery constraints.
Runtime admission and measured warmup are not controller-level replica policy.
Security implementation and independent assessment are distinct responsibilities,
not two labels for the same author approving their own work.

## Installation Bundles

Bundles are task-oriented and deliberately overlap; the helper deduplicates shared
paths before invoking the official installer. The installer does not overwrite an
existing skill directory, while the helper's explicit `--replace` flow backs up and
replaces only selected skills. `base` is a compact default; computer vision remains
opt-in through a CV bundle, `all`, or explicit skill paths.

| Bundle | Intended work |
|---|---|
| `base` | General professional engineering and writing |
| `writing-specialists` | Full writing, source, research, decision, and presentation family |
| `product-and-consulting` | Product discovery, UX, business framing, and stakeholder decisions |
| `service-platform` | Classical services, API contracts, databases, infrastructure delivery, QA, and reliability |
| `classic-ml` | Predictive/classical ML and text-model selection/adaptation |
| `computer-vision-core` | CV-only decision surfaces for perception architecture, data, modeling, evaluation, and inference |
| `computer-vision-training` | CV dataset, model-training/adaptation, and evaluation work with generic ML/QA companions |
| `computer-vision-systems` | Production CV pipeline, serving, quality, software, and reliability work |
| `computer-vision-all` | Full CV vertical plus the generic ML, service, QA, SRE, and delivery companions |
| `llm-product` | User-facing LLM products, RAG, agents, evals, and security |
| `llm-platform` | Self-hosted LLM serving and platform operations |
| `llm-adaptation` | Fine-tuning/adaptation and deployment of text/LLM models |
| `agent-systems` | Agent workflow, evaluation, safety, and production controls |
| `ios-apps` | iOS, Swift, Flutter, and mixed-stack work |
| `telegram-mini-apps` | Telegram Mini Apps |
| `web-frontend` | Browser UI state, rendering, loading, accessibility, and verification |
| `python-backend` | Python services, API contracts, database use, and verification |
| `node-backend` | Node/TypeScript services, API contracts, database use, and verification |
| `data-platform` | Database and data-pipeline correctness, recovery, and reliability |
| `platform-delivery` | Infrastructure as code, builds, deployment, and reconciliation |
| `application-security` | Application control design and independent security assessment |
| `neural-training` | Neural step correctness, memory, distributed execution, and restart |
| `ai-platform` | Predictive/GenAI serving and training-job infrastructure |
| `all` | Every skill in this release |

The machine-readable membership is [bundles.yaml](bundles.yaml). Use
`./scripts/install-bundle.sh --list` to inspect it or
`./scripts/install-bundle.sh --bundle base --bundle llm-product` to print the exact
official installer command. `--run` performs a first installation; `--run --replace`
downloads to staging, then backs up and replaces the affected existing skills explicitly.
