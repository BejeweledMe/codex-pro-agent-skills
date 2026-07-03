# Managed Compute And Production Abstractions

Use when: designing production platforms, services that run on managed compute,
containerization strategy, workload abstraction, or reliability assumptions in runtime
environments.

## Core Ideas

- At scale, organizations need common production compute abstractions to reduce toil and standardize how workloads run.
- Managed compute changes the contract for application authors: software should expect restarts, rescheduling, resource limits, and platform-driven movement.
- Containers and schedulers hide some machine details but create new implicit dependencies if teams rely on unspecified behavior.
- Batch and serving workloads have different needs and failure modes.
- State management is central: stateless replicas are easier to move, scale, and replace than tightly coupled stateful processes.
- Abstraction level is a trade-off. Higher-level platforms reduce toil but constrain customization.
- Public/private and centralized/customized compute choices depend on organizational needs, not universal preference.

## Practices

- Design services to tolerate process death, rescheduling, and machine failure.
- Keep persistent state in systems designed for state rather than local process assumptions.
- Use discovery, load balancing, retries with backoff, and graceful degradation through shared libraries or platform primitives where possible.
- Right-size resources and autoscaling based on observed workload behavior.
- Treat submitted configuration as production code: version it, review it, test it.
- Choose compute abstraction by evaluating operational burden, flexibility, isolation, cost, and developer workflow.
- Watch for hidden dependencies on container runtime, host behavior, local disk, or scheduling quirks.

## Anti-Patterns

- Treating a managed container as a pet machine.
- Storing critical state in a place that disappears during rescheduling or restart.
- Hand-rolling retries without backoff, jitter, or cascading-failure awareness.
- Assuming platform abstraction removes the need to understand failure modes.
- Over-customizing every workload until the common platform loses leverage.
- Choosing serverless, containers, or VMs by trend rather than workload constraints.

## Agent Checklist

- What failures can the compute platform impose on this workload?
- Is state stored and recovered correctly?
- Are retries, timeouts, and degradation handled through safe shared patterns?
- Is configuration versioned, reviewed, and tested?
- What abstraction level fits the workload and team?
- Which runtime behaviors are guaranteed versus merely observed?

## Cross-Links

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md)
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
