# Reference Map and Evidence Limits

Choose a reference by the unresolved mechanism:

| Need | Reference |
| --- | --- |
| Stale state, identity, Effects, SSR/SSG, hydration, streaming | [State and rendering](react-next-state-and-rendering.md) |
| Client payloads, requests, actions, authorization enforcement, late responses | [Server-client boundaries](server-client-and-request-boundaries.md) |
| Slow route/action, splitting, discovery, hints, virtual lists | [Loading and performance](route-loading-and-performance.md) |
| Wrong pixels, targeting, invalidation, layout work, graphics, embeds | [Browser diagnosis](browser-pipeline-and-diagnostics.md) |
| Inert controls, lost focus, deferred content, semantic state | [Focus and deferred UI](accessibility-focus-and-deferred-ui.md) |
| Behavior checks, traces, lab experiments, field evidence | [Browser verification](browser-testing.md) |

## Source Grounding

- **Learning Patterns**: state and composition, rendering strategies, hydration, Server Components and islands, loading, splitting, resource hints, performance experiments, and virtualization. Its largely historical examples support decision mechanisms, not current React/Next.js APIs, package rankings, numerical budgets, or transferable speedups. Code shown as images is not a basis for executable recipes.
- **Web Browser Engineering**: layout and paint, input and forms, scheduling, compositing, invalidation, frames, and accessibility. It supplies a teaching model for locating the first incorrect derived artifact. Application-level lifecycle and diagnostic recommendations are adaptations of that model; they do not describe every production engine or establish standards conformance.
- **React documentation on state and Effects**: phase separation, nearest common ownership, conceptual identity, synchronization dependencies, and cleanup.
- **Next.js data-security and production guidance**: minimal serialized data, narrow browser boundaries, independently protected action paths, and production observations. This does not establish a complete router, caching, or authentication cookbook.
- **WCAG and WAI-ARIA Authoring Practices**: standards and pattern orientation. Practical focus and fallback obligations here are engineering guidance; component-specific normative techniques need the relevant source sections.
- **Core Web Vitals, Playwright, and Testing Library guidance**: field/lab distinctions and user-visible, isolated browser verification. These complement general QA, contract, accessibility, and security evidence.

## Targeted Refresh

Inspect installed versions and project behavior first. Consult the relevant current primary documentation when the implementation depends on an exact API or normative rule. If that evidence is unavailable, retain the useful mechanism and identify the specific unverified detail.

| Trigger | Refresh before making an exact claim |
| --- | --- |
| React API, compiler, subscription, or Effect Event change | Installed React behavior and current API guidance; do not use an API to conceal legitimate dependencies. |
| Next.js router, caching, revalidation, action, or proxy change | Router/runtime version, cache ownership, invalidation behavior, serialization support, and action origin/encryption requirements. |
| New resource hint, service worker, browser messaging, cookie, or Fetch behavior | Applicable browser support and normative semantics; existing source material is incomplete here. |
| Custom ARIA widget or conformance request | Applicable WCAG version/level, exact APG pattern, supported browser/assistive-technology behavior, and scoped evidence. |
| Core Web Vitals reporting or tool upgrade | Current metric definitions, thresholds, lifecycle, eligibility, and collection/tool behavior. |
| Engine-specific compositor or accessibility claim | Current engine/platform documentation and a reproduction on the supported target. |

Do not carry forward claims that props never change, Context intrinsically writes or forbids writes, Effects prevent side effects, Hooks were the first reuse mechanism, SSR implies immediate interactivity, or ESM guarantees tree shaking. Historical FID/TTI headlines, fixed JavaScript budgets, HTTP/2-push prescriptions, and book benchmark deltas are not current defaults.
