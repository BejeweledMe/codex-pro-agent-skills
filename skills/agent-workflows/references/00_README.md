# Agent Workflow References

## Route

- `01_agent_or_pipeline.md`: decide between deterministic pipeline, RAG, single agent, multi-agent, or council.
- `02_tools_state_contracts.md`: tool contracts, state ownership, checkpoints, retries, idempotency, and validation.
- `03_orchestration_handoffs.md`: handoffs, multi-agent patterns, context boundaries, and partial failure.
- `04_control_observability_recovery.md`: limits, traces, stop conditions, recovery, rollout, and degraded modes.
- `05_templates.md`: workflow design, tool contract, state machine, handoff, and release templates.

## Companion Boundaries

- `$agent-llm-evals` owns the test harness, graders, calibration, and release gates.
- `$genai-security-testing` owns threat models, policy enforcement, and authorized tests of boundaries.
- `$system-design` owns generic service, data, and API contracts.
- `$llm-council` applies only to independent multi-model deliberation and peer review.
