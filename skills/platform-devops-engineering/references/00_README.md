# Reference guide

Choose by the decision being made; references are not a mandatory reading sequence.

| Reference | Decision and evidence |
|---|---|
| [Components, state and environments](components-state-and-environments.md) | What can change independently, what consumers rely on, and which tests prove that capability |
| [Containers and Kubernetes lifecycle](containers-kubernetes-lifecycle.md) | What is built versus executed, why a rollout fails, and where runtime/access isolation is enforced |
| [OpenTofu safe transitions](opentofu-safe-transitions.md) | How configuration identities map to existing objects through refactoring, drift, replacement and recovery |
| [GitOps, apply and recovery](gitops-apply-and-recovery.md) | Who applies which candidate, what each loop controls, and how to stop and recover it |
| [Provenance and deployment admission](provenance-and-deployment-admission.md) | Which release claims are authenticated, which identities are authorized, and how enforcement corresponds to deployed artifacts |

## Evidence basis and limits

Kief Morris, *Infrastructure as Code, Third Edition*, Chapters 5–13 and 14–21, supports decomposition, environments, delivery, testing and transition design. Its commands, product comparisons and numerical examples are not executable specifications or universal targets. *Software Engineering at Google*, testing, release engineering and large-scale change discussions, supports candidate identity and consumer-migration ownership; it does not make CI an SRE-owned service.

[Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/), controlled production access, deployment integrity and recovery discussions, supports narrow mutation paths, bounded automation and the source-to-deployed-state evidence chain. Its historical experience does not prove that a modern toolchain meets a standard. [NIST SP 800-218, SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final) supports tailored secure-development outcomes, toolchain protection and response feedback. Pin the applicable edition and task identifiers before a conformance claim; examples are not mandatory controls, and this guidance is not certification or legal interpretation.

Before giving commands or hard guarantees, verify the target versions and relevant primary documentation for provider resource replacement/import semantics; Terraform/OpenTofu state formats, locking, encryption and migration scope; Kubernetes APIs, RBAC, Pod Security and operating-system qualifiers; CNI NetworkPolicy enforcement; OCI formats/runtime lifecycle; Argo CD setup, policy and sync behavior; cloud IAM and GitHub OIDC claim formats; Cosign verification behavior; and SLSA normative requirements. In particular, do not assume a captured Argo `stable` page or an OIDC subject format is unchanged for the user's deployment.

The mechanisms here do not supply a complete OCI specification, Kubernetes hardening baseline, provider/backend matrix, admission-controller implementation, cloud trust-policy template or SLSA level mapping. Obtain only the missing detail needed for the target task. Keep unknowns explicit and continue design or inspection that does not depend on them.
