---
name: "security-review"
description: "Assess security claims for a scoped design, application change, release, repository, or OSS dependency. Use for abuse-path review, application-verification evidence, supplier posture, and security findings or release recommendations; ordinary maintainability review belongs to software-engineering."
---

# Security Review

Determine which security claims the evidence supports, what could still cause harm, and who can act. Bind the judgment to the inspected target and scope. Review does not itself certify software, authorize attack execution, or accept residual risk.

## Assessment approach

Establish the requested decision, target revision/release and relevant configuration, protected outcomes, included paths and exclusions, available evidence, methods, and decision owner. Add baseline edition/level when a standard is used. Use existing context; resolve missing information only when it affects the conclusion. A small review can be a short scope statement and concrete findings. Broader coverage needs traceability, not a prescribed number of records or reviewers.

1. Frame the claim in terms of a prohibited outcome, actor capabilities, assumptions, and evidence that could disprove protection. For architecture, independence, or recovery questions, read [scope and assurance](references/review-scope-and-assurance.md).
2. Trace the relevant path through input, effective authority, protected state/action, detection, and recovery. Include exceptional or indirect paths when they can defeat the assessed property.
3. Compare intended policy, its adequacy, actual enforcement, and correspondence to the target. Read [evidence and findings](references/evidence-register-and-findings.md) for method selection, dispositions, remediation and retest.
4. Select the needed track: [application and release review](references/application-release-review.md) for application controls, ASVS and release integrity; [repository and OSS review](references/repository-ossf-review.md) for dependency posture, OSPS, Scorecard, analysis gates and supplier evidence.
5. Return a bounded conclusion, reproducible findings, uncertainties, remediation direction and retest criteria. Name the actual release/risk authority and changes that would require reassessment.

Read [source versions and refresh](references/source-versions-and-refresh.md) before exact standards scoring, current-tool interpretation or provider-specific claims. The [reference index](references/00_README.md) supports selective reading.

## Ownership and authority

- `application-security-engineering` chooses and implements application controls and supplier/component policy. Pass the failed property, affected path, evidence, constraints and retest criteria; assess the returned implementation evidence.
- `platform-devops-engineering` implements repository/CI/build, signing, artifact admission and deployment enforcement. Review scrutinizes what those mechanisms actually establish.
- `genai-security-testing` supplies specialist LLM/RAG/agent threat-boundary analysis and authorized adversarial tests with observed effects. This skill owns the requested independent assurance judgment; consume the specialist's scoped evidence without duplicating or weakening its authorization contract.
- `software-engineering` owns ordinary correctness and maintainability review; `system-design` resolves architectural invariants and authority choices; `sre-reliability-engineering` owns live incident coordination, containment and operational recovery.
- Engineering owns remediation; the authorized product/system owner decides release and residual exposure. Legal or contractual interpretations need the relevant authority.

A review request alone does not authorize exploit execution or external attack simulation. Before active adversarial testing, establish ownership or explicit owner authorization, allowed targets/environments/identities and test classes, appropriate data and rate/cost limits, stop conditions and recovery responsibility. Reuse sufficient existing authorization; otherwise continue permitted inspection and describe the additional test needed.

Describe reviewer authorship, material conflicts and evidence-access limits honestly. A second reviewer or model does not independently corroborate a shared assertion. If later asked to implement a fix, follow that authorized scope and disclose authorship when assessing it.

## Reporting

Lead with the conclusion and material findings. Include enough target, scope, method and evidence detail to support them. Distinguish observed failures, plausible hypotheses, missing evidence and unassessed paths; keep confidence separate from consequence. Report remediation state and risk acceptance separately from whether a claim was supported.

Do not invent severity thresholds, remediation SLAs, minimum reviewer counts, pass percentages or scalar security scores. A clean scan, signature, SBOM, badge or self-attestation supports only its specific claim. Preserve enough restricted evidence for authorized reproduction while redacting secrets and personal content. Publication or supplier notification requires authorization beyond merely reviewing.
