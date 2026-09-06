# Containers and Kubernetes lifecycle

Use for build-to-run failures, cluster capability changes, rollout diagnosis and effective runtime isolation. Service owners define process behavior; platform implements the runtime contract; SRE assesses user-visible reliability under load and failure.

## Trace build to execution

A Dockerfile is a build program operating on a build context. Its output is an image distributed through a registry. An OCI image is a shipping artifact; an unpacked runtime bundle is host-local execution input. Host/runtime controls and orchestration complete the execution contract. Build success does not prove the runtime has the right architecture, user, mounts, privileges, configuration or process behavior.

When a build is stale, compare base-image identity, dependency inputs and cache reuse. Mutable tags obscure identity; digest pinning makes identity precise but requires a governed refresh path. Pulling a base and disabling instruction cache address different forms of staleness. Keep package index refresh and installation coherent within the build operation, use context exclusion to avoid accidental inputs, and use multi-stage construction when build-only material should not ship. Select a trusted base that supports the workload; smaller alone is not a security proof.

Trace secrets through context, build inputs, intermediate artifacts, final image, logs and runtime injection. Do not persist credentials in Dockerfile `ENV` or assume a later deletion removes earlier image exposure. Select supported secret mechanisms for the target builder and verify their output behavior. Record digest, target architecture, configuration references and process contract: start, readiness, termination, data ownership and resource assumptions.

## Diagnose a Deployment using controller evidence

| Observation | Discriminating evidence | Next action and validation |
|---|---|---|
| Expected rollout never starts | Whether the Pod template changed; desired generation and controller observations | Correct the intended template change; distinguish scaling/configuration elsewhere from a new revision |
| Controllers contend for Pods | Selectors, owner references and overlapping selection | Restore unambiguous ownership; account for selector immutability through a supported transition |
| Progress stalls | Deployment conditions, events, pending/starting/unready Pods, image/configuration and capacity | Fix the demonstrated cause or use a compatible retained revision; a stall report is not automatic rollback |
| Resource use exceeds surge estimate | New, available and terminating Pods; drain duration and resource requests | Include terminating work in temporary capacity; repair drain/readiness or capacity constraints before continuing |
| Rollback cannot restore service | Retained history, referenced artifacts/configuration, data compatibility and readiness | Choose available compatible recovery; revision history alone does not restore data or external dependencies |

Record the observed version and conditions rather than inferring health from a successful submission. Admission, scheduling, startup, readiness, traffic admission and consumer behavior are different gates.

SRE's Kubernetes diagnosis remains applicable: probe roles, container-aware workers/memory, throttling/OOM, requests/limits, PDB behavior, HPA stabilization and shutdown/drain. Platform should expose and implement these controls with the service owner. A liveness check tied to an unavailable dependency can amplify failure; readiness and startup answer different questions. Validate signal handling and in-flight work through traffic removal and termination. Use measured workload timing and failure behavior rather than a universal sleep, heap fraction, startup margin or CPU-limit rule. Pass observations to SRE for reliability acceptance; do not replace operational diagnosis with manifest inspection.

## Verify effective isolation and authority

Start from the threatened crossing: workload to workload, tenant to tenant, workload to node/control plane, CI to cluster, or operator to secrets. Inspect identity, networking, storage, host access, trust roots, deployment authority and recovery dependencies. A namespace label alone is not the isolation mechanism; a shared cluster retains common control-plane and upgrade failure modes.

For Kubernetes RBAC, enumerate effective authority beyond nominal read/write labels. Secret `list`/`watch`, workload creation under service accounts, token issuance, `nodes/proxy`, `bind`, `escalate`, `impersonate`, CSR approval, admission/webhook configuration, PersistentVolume creation and namespace policy changes may create indirect authority. Trace relevant paths for the role under review; do not turn the entire list into a mandatory audit for every manifest change. Reduce authority at the real control point and verify both needed access and denied unwanted access.

Pod Security Standards define workload requirements; enforcement is separate namespace/cluster configuration. A compliant Pod does not prove future Pods are constrained. Verify enforce/audit/warn behavior and exemptions for the target version and operating system. For Secret confidentiality, inspect actual etcd encryption and readers rather than base64 encoding or a Secret object name. Managed services can alter defaults; verify observed configuration and restore/key access.

Network isolation requires the actual CNI's enforcement semantics and coverage, including intended permitted paths; this reference supplies no universal NetworkPolicy recipe. Stronger isolation may require distinct accounts, clusters or control planes when shared authority invalidates the requirement. AppSec supplies the protected invariant/control policy; platform implements it and passes configuration plus observed effects to security review.

## Cluster lifecycle evidence

For the required availability level, establish API access and control-plane availability, resource governance, etcd backup/restore responsibility and upgrade compatibility. Confirm recovery can reach the artifacts, keys, identities and configuration it needs when the affected cluster is unavailable. Test the relevant recovery path in a controlled scope rather than assuming backups imply restoration.

Source and refresh: [Kubernetes production environment](https://kubernetes.io/docs/setup/production-environment/) supplies production concerns, not a complete hardening standard. Check target Deployment/API behavior, Windows and version-gated fields, RBAC/PSS enforcement, CNI behavior, builder flags and OCI specifications before executable guidance or guarantees. OCI internals and current hardening/admission recipes require additional primary documentation.
