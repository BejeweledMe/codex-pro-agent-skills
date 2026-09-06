# Agent Workflow References

## Route

- `01_agent_or_pipeline.md`: select the least-autonomous execution pattern within the product composition chosen with `$llm-system-design`.
- `02_tools_state_contracts.md`: tool contracts, state ownership, checkpoints, retries, idempotency, and validation.
- `03_orchestration_handoffs.md`: handoffs, multi-agent patterns, context boundaries, and partial failure.
- `04_control_observability_recovery.md`: limits, traces, stop conditions, recovery, rollout, and degraded modes.
- `05_templates.md`: workflow design, tool contract, state machine, handoff, and release templates.
- [Verified search and scaffold evolution](verified-search-and-scaffold-evolution.md): generate/select/revise/accept boundaries, anti-regression, restoration, and external promotion authority.
- [Durable memory and context lifecycle](durable-memory-and-context-lifecycle.md): candidate extraction, evidence, authority, conflict, commit, supersession, expiry, compaction, and resume.
- [MCP and tool integration](mcp-and-tool-integration.md): discovery, tool identity, schemas, sessions, response handling, and runtime authorization.

## Companion Boundaries

- `$agent-llm-evals` owns the test harness, graders, calibration, and release gates.
- `$genai-security-testing` owns threat models and authorized boundary testing; this workflow implements runtime permission checks, constrained tool dispatch, and recovery using the agreed controls.
- `$llm-system-design` owns product composition, provider routing, and product-level budgets.
- `$rag-engineering` owns corpus ingestion and retrieval. Durable agent-memory and context promotion remain local workflow effects with explicit authority.
- `$system-design` owns generic service, data, API, and distributed recovery mechanics; this skill supplies the agent state and effect contract.
- `$sre-reliability-engineering` owns service operations, SLOs, and incident response; this skill supplies terminal, trace, and recovery evidence.
- `$llm-council` applies only to independent multi-model deliberation and peer review.

## Evidence And Applicability

The added verification, memory, and scaffold contracts are engineering guidance informed by Stanford CS329A's Autumn 2025 selected readings on tools, planning, search, memory, evolution, verification, and autonomy. The available course and paper snapshot is partial; these contracts are not a canonical Stanford runtime or a claim of universal benchmark gains.

MCP documentation supplies integration concepts; vendor agent and long-running harness guidance supplies workload-dependent design patterns. Neither establishes current SDK defaults, complete protocol conformance, a universal context threshold, or automatic permission to act. Refresh the specific version-dependent mechanism when implementing it. Multiple model opinions do not provide independent primary evidence.
