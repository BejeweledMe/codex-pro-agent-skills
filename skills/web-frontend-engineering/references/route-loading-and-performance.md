# Route Loading and Performance

## Optimize a User Milestone

Choose the affected milestone: useful content, first successful action, navigation completion, or optional-feature readiness. Inspect the production dependency graph from discovery through network, decode, execution, data availability, render, and activation.

Attribute waiting before selecting a technique. A smaller initial bundle may move work onto the first click; an earlier response may still wait on CSS or main-thread work.

## Match Loading to Need-Time

| Need | Candidate | Cost moves to | Preconditions and verification |
| --- | --- | --- | --- |
| Essential initial content/action | Eager loading and normal discovery | Initial network and CPU | Measure the first useful task and competing dependencies. |
| Distinct navigation | Route split | Navigation | Own transition pending/error state; compare direct entry and client navigation. |
| Near-viewport content | Visibility loading | Approach or activation | Supply lead time, reserved space, and keyboard/programmatic activation paths. |
| Optional expensive action | Interaction loading or facade | First use | First-use delay is acceptable; the facade is a real operable control with feedback and retry. |
| Probable future use | Prefetch | Speculative bandwidth and cache | Expected use justifies bytes without delaying critical work. |
| Certain current need discovered too late | Preload | Current resource contention | A trace identifies discovery delay and shows net benefit without harmful contention. |

Dynamic import moves cost. It creates a joint code/data/loading/error contract, not free performance. Handle repeated activation, failed downloads, navigation away, and focus during replacement.

For a heavy editor whose first-open latency worsened after splitting, inspect whether code now discovers data serially. Start independent code and data work together when possible, then compare interaction loading with earlier loading for likely users. Include unused bytes, first use, repeat use, and failure behavior in the decision.

## Verify Emitted Output

Inspect initial and asynchronous chunks, eager reachability, duplicated/shared dependencies, request depth, caching reuse, and parse/compile/execute work.

- A module also reachable through an eager path may defeat intended deferral.
- Micro-splitting can lose compression and cache reuse while multiplying discovery and fallback boundaries.
- Tree shaking depends on graph reachability and observable side effects. ESM syntax alone is insufficient; inspect barrels, transforms, top-level work, styles, polyfills, and package metadata.
- Fix normal discovery before adding hints. Preload affects current discovery/priority; it does not guarantee execution. Prefetch spends bandwidth on uncertain future use.

A preconnect is a candidate for a known required cross-origin dependency when connection setup delays the milestone; speculative connections also consume resources. Verify actual use before retaining it.

Check duplicate or mismatched hinted requests, unused downloads, cache identity churn between builds, and constrained-network contention. Remove hints that fail to improve the selected milestone. Exact resource typing, cross-origin, caching, and browser support details require current documentation.

Do not introduce a service worker solely to imitate a loading pattern. It needs actual offline/revisit value and an owned update, invalidation, failure, and recovery lifecycle.

## Diagnose by Cost

| Evidence | Intervention to evaluate | Proof |
| --- | --- | --- |
| Primary data waits on independent secondary work | Start independent work together or separate the useful boundary | Earlier useful content without incorrect partial state. |
| Large decode or media-driven geometry changes | Right-size delivered media and reserve intended geometry | Lower measured decode/shift cost on representative layouts. |
| Long script/activation work after bytes arrive | Reduce work or client scope; change scheduling only where semantics permit | Better action latency with working early input. |
| Repeated style/layout after DOM writes | Group reads and writes or simplify dependencies | Fewer forced layouts and unchanged geometry/interaction. |
| Optional third party dominates work | Reconsider need-time and loading/fallback ownership | Improved task outcome including users who invoke it. |

Use [browser diagnosis](browser-pipeline-and-diagnostics.md) to distinguish layout, paint, raster, and compositing costs before changing CSS or scheduling.

## Virtualization

Virtualize when profiles show material full-list render, DOM, layout, scroll, or memory cost. There is no universal row-count threshold.

Compare the simpler rendering path with a moving window under realistic row complexity. Check variable-height measurement, overscan, blank windows, range-fetch gaps/duplicates, errors, and scroll restoration.

Stable logical item identity must survive recycling. Verify focused/selected rows, keyboard traversal, semantic collection position, deep links, find-in-page, print, and selection workflows that the product supports. Check server initial-window agreement when hydration is involved.

If the performance gain depends on losing required collection behavior, repair the identity/focus protocol or choose a simpler approach. Package-specific capabilities and platform containment behavior require current evidence.
