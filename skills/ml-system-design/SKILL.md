---
name: ml-system-design
description: "Design, review and debug predictive/classical ML systems: whether ML is needed, build or buy, metrics, data, validation, baselines, lifecycle pipelines, predictive serving, benchmark claims, placement, A/B versus canary, monitoring, drift, degradation and ownership. Includes ML system design interviews. Modality-specific CV/LLM work and neural execution have dedicated owners."
---

# ML System Design

Use this skill to design or review ML systems end to end. Treat a model as only one component of a production system: problem framing, data, metrics, validation, baseline, training, inference, integration, monitoring, ownership, and maintenance all matter.

## Core Rule

Do not start from model choice. First clarify the business problem, success criteria, constraints, price of mistakes, available data, baseline, validation schema, fallback, monitoring, and ownership.

Translate product questions into the relevant lifecycle decision: whether rules,
manual work, a vendor, or ML can improve the outcome; what first-release ambition
is justified; whether an offline gain changes business outcomes; what evidence
permits wider exposure; and who can operate and recover the system after launch.
For a bounded question, read and answer that part without requiring a full design document.

## Boundaries

This is the primary skill for predictive and classical ML lifecycle decisions:
problem/metric/data/validation/baseline/training/deployment/monitoring. For a broad
computer-vision product or pipeline, start with `$computer-vision-system-design`;
route visual data, model, evaluation, and runtime work to the corresponding dedicated
CV owner. For a new LLM product
architecture, start with `$llm-system-design`; for how a text model is chosen or
adapted use `$nlp-modeling-and-adaptation`; for self-hosted LLM runtime bottlenecks
use `$llm-inference-optimization`. The LLM references in this skill remain as
compatibility bridges, not detailed primary routes.

Keep generic predictive data/label meaning, experiments, serving, and ML design
decisions here. Use named companions only when their decision is needed:

- `$data-engineering` implements ingestion, event-time processing, replay and
  backfill mechanics; ML supplies feature/label meaning, prediction-time
  availability, split constraints and semantic acceptance.
- `$neural-training-systems` owns step correctness, memory, precision, collectives
  and coherent restart. ML supplies objective, data/split, sample/order/batch
  assumptions and quality gates, then checks returned lifecycle evidence.
- `$ai-platform-llmops` owns shared training/serving infrastructure, fleet capacity,
  registry, scheduling, controllers and supported edge rollout. ML chooses
  deployment placement and defines quality, compatibility and fallback acceptance.
- `$api-contract-engineering` owns HTTP/OpenAPI and consumer compatibility;
  ML defines prediction meaning and degraded-result semantics.
- `$system-design` owns service topology; `$software-engineering` owns code/build
  lifecycle; `$qa-testing` owns classic verification strategy. ML retains semantic
  and statistical acceptance.
- `$sre-reliability-engineering` owns SLO operations, on-call and incident response;
  ML supplies diagnosis, label-delay limits and fallback/retrain authority.
- `$product-design` and `$business-product-consulting` help establish outcomes,
  acceptable harm and economics. `$technical-writing` or `$execution-writing`
  can shape the document or debrief while ML retains decision correctness.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- Always start with `references/01_principles_process_agent_checklist.md` for broad system design or review.
- For problem definition, risks, and cost of mistakes, read `references/02_problem_framing.md`.
- For build-vs-buy, decomposition, vendors, open source, and innovation level, read `references/03_preliminary_research_build_vs_buy.md`.
- For design doc creation or review, read `references/04_design_doc.md`.
- For metrics, losses, proxy metrics, consistency metrics, and guardrails, read `references/05_metrics_losses.md`.
- For data sources, ETL, labeling, metadata, cold start, and data pipeline health, read `references/06_data_labeling_metadata.md`.
- For validation schemas, leakage, adversarial validation, and split updates, read `references/07_validation_leakage_splits.md`.
- For baseline strategy and fallback baselines, read `references/08_baselines.md`.
- For learning curves, residual analysis, fairness, groups, and corner cases, read `references/09_error_analysis.md`.
- For reproducible training workflows, scalability, configurability, and testing, read `references/10_training_pipelines.md`.
- For feature engineering, feature selection, feature importance, and feature stores, read `references/11_features_feature_store.md`.
- For measuring real effect, human evaluation, simulation, A/B tests, and reporting, read `references/12_measuring_ab_reporting.md`.
- For API design, release cycle, operations, overrides, and fallbacks, read `references/13_integration_api_release_fallbacks.md`.
- For serving, latency/throughput/cost tradeoffs, profiling, and inference optimization, read `references/14_serving_inference_optimization.md`.
- For a performance comparison or vendor claim, read `references/benchmark-contract-and-claims.md`; its worksheet is optional context for a bounded benchmark.
- For cloud, edge or hybrid placement and sustained device constraints, read `references/deployment-placement-and-device-envelope.md`.
- For monitoring, drift, reliability, accountability, bus factor, documentation, and complexity, read `references/15_monitoring_ownership_maintenance.md`.
- For a legacy overview of LLM selection/adaptation before handing off to the new
  primary owner, read `references/16_llm_model_selection_and_adaptation.md`.
- For a legacy overview of self-hosted LLM serving before handing off to the new
  primary owner, read `references/17_llm_inference_serving_and_bottleneck_diagnosis.md`.

## Workflow

1. Classify the request:
   - New system design: read references `01` through `08`, then add `10`, `12`, `13`, `14`, `15` as needed.
   - Design doc review: read `04`, then read topic files for every missing or risky section.
   - Metrics or experiment design: read `05`, `07`, `09`, `12`.
   - Data/validation/debugging issue: read `06`, `07`, `09`, `11`, and `15` if production is involved.
   - Production, serving, or reliability review: read `13`, `14`, `15`, and `08` for fallback/baseline behavior.
   - Whether ML is justified, build/buy/manual alternatives, or first-release ambition: read `02`, `03`, `08`.
   - Benchmark validity or deployment placement: read the corresponding focused reference, adding `05`, `07`, `13`, or `14` only for unresolved quality, evaluation, release, or serving decisions.
   - Computer-vision architecture or task decomposition: start with `$computer-vision-system-design`; use the dedicated data, modeling, evaluation, or inference owner when that decision is already clear.
   - LLM product architecture, provider/model routing, prompt/RAG/agent/adaptation choice, or product budget: start with `$llm-system-design`.
   - Text-model selection, fine-tuning, PEFT, tokenizer, or adaptation question: start with `$nlp-modeling-and-adaptation`, then use the relevant ML lifecycle references.
   - LLM serving bottleneck or self-hosted capacity question: start with `$llm-inference-optimization`, then use `14`, `15`, and companion system/SRE references as needed.
2. Identify unknowns before proposing architecture. Ask only for blocking information; otherwise state assumptions.
3. Produce a practical design or review with explicit tradeoffs.
4. Validate the design against baseline, validation, data quality, integration, monitoring, fallback, ownership, and maintainability.
5. Mark any ideas not grounded in the references as `external extension` if you add them.

For RAG pipeline work, use `$rag-engineering` for corpus-to-context decisions. For agent control loops, use `$agent-workflows`. For threat modeling or authorized boundary testing, use `$genai-security-testing`. This skill remains the owner of the predictive/classical ML lifecycle decision.

## Output For New System Design

Include:

- Problem statement.
- Goals and antigoals.
- Constraints and price of mistakes.
- Candidate non-ML and ML baselines.
- Data, labeling, metadata, and data pipeline plan.
- Metrics, loss, guardrails, and validation schema.
- High-level architecture with major blocks.
- Training pipeline and feature strategy.
- Inference/serving and integration/API plan.
- Fallback, rollback, and release plan.
- Measuring/A/B/reporting plan.
- Monitoring, drift response, ownership, and maintenance plan.
- Risks, open questions, and next steps.

## Output For Review

Lead with risks and missing decisions:

- Critical issues.
- Risky assumptions.
- Missing problem framing or goals/antigoals.
- Weak metric, validation, leakage, or baseline plan.
- Data, labeling, metadata, or pipeline gaps.
- Integration, serving, fallback, monitoring, or ownership gaps.
- Concrete fixes and questions to unblock the design.

## Quality Bar

- Prefer a simple working baseline before complex ML unless the references justify skipping it.
- Tie offline metrics to product/business metrics.
- Make validation resemble production use.
- Evaluate validation-derived choices on an outer surface; keep fixed comparability and fresh relevance visible.
- Treat data, labels, metadata, and split design as first-class architecture.
- Do not call a model production-ready without integration, fallback, monitoring, and ownership.
- Attribute behavior to the complete semantic release bundle and distinguish what replay, shadow, canary, A/B, and rollout actually proved.
- Diagnose data, skew, model/objective, and runtime failures before choosing retraining.
- Keep recommendations scoped to the user's system and constraints.
