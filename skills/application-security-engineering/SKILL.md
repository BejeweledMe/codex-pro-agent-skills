---
name: application-security-engineering
description: "Design, implement, or remediate general application security controls: code-linked threat models, authentication and recovery, sessions, authorization and tenant isolation, OAuth/JWT, browser/API/uploads, secrets and data protection, secure failure, dependency policy, or ASVS implementation. Independent assessments belong to security-review; specialist LLM/RAG/agent threat modeling, security design/review, hardening and authorized testing belong to genai-security-testing."
---

# Application Security Engineering

Turn a protected outcome into an enforceable application control, evidence of its behavior, and a viable recovery path. Own control selection, implementation, remediation, and maintained application evidence. Scale the work to the changed boundary: a small fix needs a clear invariant and focused verification, not a new security program.

## Start with the requested outcome

Determine whether the user wants design, diagnosis, implementation, or independent assessment. Diagnose without silently implementing. For a requested fix, inspect the affected source, configuration, dependencies, and existing checks, implement within scope, and verify the security behavior in proportion to risk.

State the protected people or assets and the prohibited outcome. Map the actors, effective authority, data flow, trusted enforcement point, and normal and exceptional states that can reach it. Prefer removing unnecessary authority and using established framework controls over adding custom security mechanisms.

For each material control, answer:

- What invariant must hold, for which operation, actor, object, tenant, and state?
- Where is the decision enforced, and what assumptions or bypass paths could invalidate it?
- What occurs on rejection, timeout, partial completion, compromise, and recovery?
- What source/configuration and observed behavior support the claim, and what remains unverified?

Read only the relevant depth below; [the reference index](references/00_README.md) also records the source basis.

## Reference routing

| Task | Read |
| --- | --- |
| New feature, changed trust boundary, confused deputy, tenant or business authorization | [Threat models and effective authority](references/threat-models-and-effective-authority.md) |
| Injection, browser security, APIs, proxies, outbound requests, uploads and archives | [Web and API controls](references/web-api-controls.md) |
| Login, recovery, sessions, OAuth/OIDC, JWT, service credentials and crypto use | [Credential and recovery controls](references/credential-and-recovery-controls.md) |
| ASVS implementation, applicability, data copies, logging and remediation closure | [ASVS control implementation](references/asvs-control-implementation.md) |
| Dependency intake, SBOM/VEX policy, secure delivery evidence and escaped vulnerabilities | [Secure development and vulnerability feedback](references/secure-development-and-vulnerability-feedback.md) |

## Implement and verify the boundary

Keep authentication, token validity, authorization, and business correctness separate. Enforce sensitive decisions at the trusted tier using the originating subject and current relevant state; UI controls, signatures, gateways, and hidden identifiers do not replace that decision.

For a fix, trace one complete input-to-effect path, including alternate entry points and intermediaries. Change the control where it cannot be bypassed. Define a permitted case and a prohibited case that distinguish the original defect from the corrected behavior. Include degraded or recovery behavior when the change affects it. Preserve useful existing checks and report what was actually observed rather than converting a plan or scanner result into execution evidence.

Ordinary scoped implementation checks do not authorize live exploit execution, penetration testing, production fault injection, or testing another party's system. Such work requires separately established target/environment/identity authorization, allowed test classes, data and resource limits, stop conditions, and a recovery owner. Without these, produce a design-only plan. A handoff does not supply missing authorization.

## Ownership and handoffs

- Use `security-review` for a fresh independent assessment or release verdict. Supply the claim, target revision/environment, threat model, versioned requirements, implementation and effect evidence, exceptions, untested limits, and acceptance owner. Engineering self-checks remain useful but do not establish independence.
- Use `genai-security-testing` for LLM/RAG/agent threat modeling, security design and review, hardening, and authorized testing involving prompt or indirect injection, retrieval ACLs, model/tool misuse, excessive agency and paired safety/utility evaluation. AppSec supplies shared application identity, authorization, secret custody, parser and audit controls. Preserve that specialist's policy-before-side-effect, argument-provenance, least-agency, testing-authorization and recovery safeguards; its remit is broader than test execution.
- Use `system-design` for unresolved topology, authority, consistency, isolation or recovery architecture; `api-contract-engineering` for observable HTTP and consumer compatibility; backend/frontend and `software-engineering` owners for implementation mechanics; `qa-testing` for broader verification strategy.
- Use `platform-devops-engineering` for builder isolation, signing, artifact storage, provenance and deployment admission. AppSec retains supplier/component policy and requires evidence linked to the deployed application.
- Use `sre-reliability-engineering` for live incident coordination and operational recovery. Supply invariants, authority to contain, event semantics, minimum secure degradation, and the trust basis for restoration. Seek qualified identity, cryptography, data or privacy expertise when exact profiles, engine guarantees or legal obligations determine correctness.

## Deliverable

Lead with the control decision or completed fix and its effect. Include the affected boundary, assumptions, implementation, relevant denial/failure evidence, recovery implications, and remaining exposure with its owner. For broader work, attach the compact claim record from the threat-model reference. State whether evidence describes a design, inspected code, observed checks, or a deployed control. The product or designated risk authority accepts residual risk; this skill does not self-certify the system.
