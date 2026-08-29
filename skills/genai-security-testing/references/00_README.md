# GenAI Security Testing References

## Route

- `01_threat_model_boundaries.md`: assets, trust boundaries, identities, data, tools, and high-consequence paths.
- `02_enforcement_hardening.md`: ACL, least privilege, provenance, pre-execution policy, sandboxing, and kill paths.
- `03_authorized_self_test.md`: authorization, isolation, paired test corpus, controlled execution, stop conditions, and reporting.
- `04_evaluation_false_refusals.md`: safety/utility measurement, false refusals, human calibration, release gates, and regressions.
- `05_operations_governance.md`: inventory, observability, incidents, policy ownership, and change control.
- `06_templates.md`: threat model, control table, test plan, report, and regression-case templates.

## Companion Boundaries

- `$agent-llm-evals` owns test harnesses, graders, calibration, and CI/release operations.
- `$rag-engineering` owns corpus and retrieval mechanics; this skill owns authorized ACL/injection testing of their boundaries.
- `$agent-workflows` owns control-loop/tool architecture; this skill owns enforcement and testing of permissions and side effects.
- `$system-design` owns generic security/multitenancy architecture; `$sre-reliability-engineering` owns live incident response.
