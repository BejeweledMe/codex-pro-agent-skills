# Browser Pipeline and Diagnostics

Use this as an application diagnostic model informed by **Web Browser Engineering**. It is not a browser-construction procedure or an assertion about exact engine internals. Inspect artifacts exposed by supported tools; do not invent unavailable internal traces.

## Find the First Incorrect Artifact

Follow the affected path through source state, delivered representation, parsed DOM, computed style, geometry, paint/composition, and input or accessibility output. These are related projections, not interchangeable copies of the DOM.

| Symptom | Inspect first | Action and verification |
| --- | --- | --- |
| Wrong content or hydration structure | Actual response/data and browser-parsed DOM | Repair upstream output or invalid structure; compare initial and activated content. |
| Wrong styling | Matched rules, cascade winner, inheritance, computed values | Correct the winning input; verify affected states and viewport conditions. |
| Wrong wrapping, overlap, or height | Font actually used, intrinsic sizes, containing geometry | Correct geometry dependencies; recheck font/image completion and zoom. |
| Missing or covered pixels | Stacking, clip, transform, paint order, exposed paint/layer diagnostics | Repair the earliest incorrect input; verify scroll and overlap. |
| Wrong pointer or keyboard target | Overlay/geometry, event target, active focus path | Align visual and operable state; check keyboard and pointer independently. |
| DOM changes but output remains stale | Framework commit, cached derivation, invalidation, semantic state | Repair stale application state; reduce to a browser reproduction if upstream state is correct. |
| Old-page result changes the new screen | Request/subscription identity at completion and consumption | Reject obsolete work and repair cleanup; reproduce navigation during pending work. |

Screenshots establish symptoms; pair them with the state or trace that distinguishes causes. If evidence points to an engine defect, provide a minimal reproduction, supported versions, and the first observed divergence instead of prescribing internal engine changes.

## Invalidation and Layout

Cached derivations must account for every changing input. Under-invalidation causes incorrect output; over-invalidation costs work. For application-owned memoization or retained rendering, compare a conservative recomputation path with incremental output where available. Narrow reuse only after correctness and measurements justify it.

For application-owned derived state, identify inputs and consumers before narrowing invalidation. Rebuild aggregates without accumulating previous results, reject stale values where current results are required, and invalidate every dependent output when an input changes. Coalescing repeated work or stopping propagation after an equal result can reduce cost when that preserves the required intermediate outcomes. These are choices for state the application owns, not a demand to implement a browser scheduler.

Trace changes that affect more than pixels: geometry also affects hit testing, focus reveal, and semantic output. Image/font completion, viewport changes, and zoom can invalidate earlier layout assumptions.

A geometry read after a write may force synchronous style/layout work. Locate the actual freshness barrier in a trace before rearranging code. Group compatible reads and writes and reduce repeated work; moving everything into an animation callback does not by itself remove the dependency.

For input problems, distinguish code download, execution, handler registration, dispatch, and browser default behavior. A handler that never registered can look like a targeting failure. Asynchronous work cannot retroactively cancel a default action that already happened. Preserve native form and link behavior unless the application deliberately owns the replacement.

## Scheduling and Graphics

Separate input queueing, script execution, style/layout, paint/raster, upload/composition, and presentation where tools expose them. Average frame time can hide a few severely delayed actions.

Application callbacks and workers need lifecycle ownership, bounded pending work, and stale-result handling. Coalescing is appropriate only when intermediate states may be replaced; do not discard discrete user actions as though they were redundant visual updates.

Transforms and opacity can reduce repeated rendering work in some conditions, but they do not guarantee a compositor-only path or a GPU speedup. Inspect actual paint/raster work, layer/surface count and memory, oversized bounds, and allocation/promotion churn. A conceptual layer is not automatically a physical graphics surface.

Preserve group opacity, clipping, effect order, and input geometry when simplifying an animation. Compare a simpler static or non-promoted path if it helps isolate the cost. Verify interruption, reversal, settled state, focus, and reduced-motion behavior.

## Embeds and Messages

Treat an iframe as a nested document with its own navigation, state, and failure lifecycle. The parent owns placement and admission; the child owns its local behavior. Distinguish loading, active, blocked, failed, replaced, and detached states with stable appropriate fallback geometry.

For application messaging, check actual sender origin and source, expected message shape, workflow authority, and the active frame/document session. Payload claims alone do not identify the sender. Use a specific target-origin policy for private messages and bound payload size, pending work, and timeouts.

Where messages evolve across releases, identify the supported schema/session and reject incompatible or unexpected messages explicitly. Reject obsolete messages after frame replacement or teardown; clean up listeners. Verify keyboard traversal and focus across the supported embed path, plus slow/blocked/failed loading.

Origin, site/cookie scope, frame identity, and process placement are different concepts. Visibility or embedding never grants application authority. Exact messaging, sandbox, CORS, cookie, and browser isolation behavior requires current authoritative guidance; application security owns control design.
