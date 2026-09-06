---
name: "web-frontend-engineering"
description: "Build and debug browser UI, including React and Next.js state, rendering, hydration, route loading, performance, accessible interaction, and browser checks. Product discovery and interaction acceptance belong to product-design."
---

# Web Frontend Engineering

Turn an observed route, action, or freshness requirement into correct, operable browser behavior. Follow the work from authoritative state through requests, rendering, activation, and successful user action.

## Working Loop

1. Inspect the affected route/component, installed framework versions, existing design-system primitives, request adapters, and relevant checks. Establish expected versus observed behavior and the smallest reproduction.
2. Identify canonical state, conceptual identity, lifetime, and update owner. Distinguish render computation, interaction handlers, external synchronization, and subscriptions.
3. Trace the critical code, data, server, style, and media dependencies. Separate content visibility from interaction readiness; identify where freshness or lifecycle agreement first fails.
4. Make the smallest justified change. Preserve truthful pending, stale, empty, failure, and recovery behavior, including early input and focus where affected.
5. Verify the changed behavior at the necessary fidelity. For performance work, compare representative production output and user milestones, not just source size or one lab score.

A component fix needs a focused diagnosis and check, not a new architecture document. For broader changes, state route/region ownership, freshness, first successful action, failure behavior, and the evidence that would justify keeping or reverting the change.

## References

Read only the relevant bodies:

- [State and rendering](references/react-next-state-and-rendering.md): React phase discipline, identity, rendering choices, hydration, streaming, and islands.
- [Server-client and request boundaries](references/server-client-and-request-boundaries.md): serialized data, runtime adaptation, reachable actions, request races, and UI outcomes.
- [Route loading and performance](references/route-loading-and-performance.md): need-time loading, dependency waterfalls, emitted bundles, resource hints, and virtualization.
- [Browser pipeline diagnosis](references/browser-pipeline-and-diagnostics.md): first incorrect artifact, invalidation, layout, input, compositing, and embedded documents.
- [Focus and deferred UI](references/accessibility-focus-and-deferred-ui.md): native semantics, early input, replacement, focus, and accessible recovery.
- [Browser verification](references/browser-testing.md): isolated user-visible checks, traces, production measurements, and lab/field interpretation.
- [Reference map and source limits](references/00_README.md): source grounding and targeted refresh triggers.

## Ownership

Frontend owns actual browser/request adaptation and the implementation of visible, operable state behavior. A handoff does not remove that responsibility.

| Unresolved decision | Primary owner and frontend contribution |
| --- | --- |
| User need, interaction acceptance, design-system choice | `product-design`; implement the accepted journey and return behavior/focus evidence. |
| HTTP/OAS, media, errors, consumer compatibility | `api-contract-engineering`; supply actual request/response evidence and implement the agreed client adapter. |
| Service topology and data authority | `system-design`; supply route dependencies and freshness requirements. |
| Service runtime, transactions, durable side effects | `node-typescript-backend-engineering` or `python-backend-engineering`; implement browser coordination against their outcomes. |
| Application control design | `application-security-engineering`; enforce the applicable boundary and return implementation evidence. |
| Independent security assurance | `security-review`; provide the scoped implementation and evidence without claiming an assurance verdict. |
| General verification strategy | `qa-testing`; retain ownership of local browser checks and diagnosis. |
| Codebase lifecycle, infrastructure, operational reliability | `software-engineering`, `platform-devops-engineering`, or `sre-reliability-engineering`, according to the decision. |
| Telegram host lifecycle, authentication, native integration, payments | `telegram-mini-apps`; apply generic browser mechanisms within its host contract. |

Pass only what the next decision needs: failing route/action, relevant identity and version, authority/freshness expectation, observed outcome, and redacted evidence. Neighboring skills are optional named handoffs, not mandatory dependencies.

## Reporting

Lead with the resulting behavior or finding. Explain the owning state/phase, why the change addresses it, what was checked, and material remaining uncertainty. Separate measured improvement from a proposed improvement. Do not claim framework conformance, WCAG certification, or current browser-engine internals from these references.
