# State, Lifecycle, and Rendering

## Assign Work to Its Owning Phase

| Work | Placement | Failure evidence and correction |
| --- | --- | --- |
| Value determined by current inputs | Render computation | Mirrored state becomes stale or causes another update; derive directly unless an independent draft/history is required. |
| Work caused by a specific user action | Interaction handler | Effect chains obscure which action caused a request; keep the action and its consequences explicit. |
| Synchronization with an external resource | Effect or framework lifecycle mechanism | Trace inputs, setup, cleanup, and replacement; repair dependencies instead of suppressing them. |
| State outside the component tree | Explicit store subscription | Define snapshot, subscription, mutation, reset, and lifetime; verify the installed integration mechanism. |

Keep rendering free of externally observable mutations. Rendering describes the current inputs; requests caused by user actions and synchronization with external systems need their own lifetimes.

Props are read-only to the receiver for a render and can change across renders. Keep independent temporary input local. Lift coordinated state to the nearest legitimate common owner. Use a reducer when explicit transitions clarify a complex state model; it is not an automatic performance optimization.

Context distributes an owner's value and actions. A broad provider can hide provenance and amplify updates; scope it to a coherent domain and update cadence. Custom hooks normally share logic, not state between calls. Shared state requires an actual common owner or store.

Before resetting with a key, establish conceptual identity. Switching records may warrant a new editor lifetime; an ordinary rerender does not. A key reset also discards drafts, focus, and subscriptions. Preserve independent unsaved input when that is the accepted behavior.

For example, stale totals after switching records can come from a redundant total, a preserved draft, or a late request. Derive the total from canonical inputs, reset only the intended record state, and prevent the previous record's response from committing. Verify a switch while a request is pending and while the user has edited input.

Choose composition for a concrete responsibility. Hooks can remove unnecessary wrappers, but a working container/view, render-prop, or HOC boundary need not be rewritten merely to modernize its spelling.

| Reuse boundary | Benefit to establish | Cost to inspect |
| --- | --- | --- |
| Custom hook | Repeated stateful logic with clear inputs and cleanup | Hidden lifetime or mistaken sharing between calls. |
| Container/view or render prop | Separate policy from markup, or let a caller supply presentation | Wrapper depth and callback ownership. |
| Higher-order component | Uniform policy across consumers | Prop collisions, wrapper order, and opaque provenance. |
| Compound component | Flexible composition of one semantic control | Structural assumptions, coordinated keyboard behavior, disabled state, dismissal, and announcements. |

A shared exported mutable object has a lifetime beyond an individual component and can leak state between tests. Make its mutation and reset ownership explicit. Freezing its outer object does not establish deep immutability.

## Select Rendering per Useful Region

Establish personalization, discovery needs, allowed data age, primary content, first action, and browser-required behavior. Distinguish build-fresh, bounded-stale, request-fresh, and live-after-load needs.

| Strategy | Applies when | Cost or failure to prove acceptable |
| --- | --- | --- |
| CSR | A connected interactive application benefits from browser-owned behavior | Initial code/API discovery, execution, and first-task delay. |
| Classic server HTML with links/forms | Request-time content and round trips satisfy the journey | Origin latency and round-trip behavior; rich client interaction may be unnecessary. |
| SSR plus hydration | Early HTML and rich interaction are both useful | Initial-output agreement, activation cost, and visible-but-inert controls. |
| SSG | Shared content remains valid until publication | Build growth, allowed age, and any remaining client activation. |
| Bounded-stale regeneration | Serving older content during refresh is acceptable | Cold generation, failed refresh, maximum acceptable age, and invalidation. |
| Streaming | Independently useful regions have uneven completion times | Whether a useful shell actually reaches and paints before slow work. |
| Server Components | Server reads/transforms belong within the UI tree | Serialized payloads, data fan-out, cache ownership, and client descendants. |
| Islands | A document has mostly independent widgets | Duplicate code/data and cross-widget coordination. |

Server Components and SSR are complementary. Moving implementation code to the server does not itself solve request latency, freshness, payload exposure, or hydration cost in client regions.

Islands are independent widget entrypoints, not merely lazy branches in one connected application. If widgets require tightly synchronized shared state, consider consolidating the client region rather than inventing a coordination protocol.

## Hydration and Activation

Trace server output, serialized initial data, browser code arrival, initial client output, activation, and first successful action separately.

- Investigate mismatches at the first divergent input: record/version, time-dependent output, browser-only state, or structurally repaired HTML. Hiding warnings does not repair the agreement.
- Define what early input does: works through a server/native path, waits visibly, or uses supported queuing/replay. Do not assume framework replay covers every event or failure.
- Give dormant/loading regions truthful semantics, stable geometry, and a usable error/retry path.
- Scope completions to the active route/component identity. Cleanup and rejection of obsolete results must prevent abandoned work from changing the new screen.
- Preserve or deliberately transfer focus when activation replaces content.

Developer-scheduled progressive activation and framework-selective hydration have different scheduling mechanisms. Neither automatically prevents mismatches. Verify exact framework support before prescribing APIs.

## Streaming and Freshness Recovery

Measure first byte, first delivered flush, shell paint, and each important boundary's completion. Early headers alone do not demonstrate useful streaming.

If nothing useful paints earlier, inspect dependencies that hold the shell: data awaits, metadata/style collection, whole-document templates, and delivery buffering. Start independent work together where valid. Compare the origin and deployed path before attributing the problem to React or the network.

Define failures before and after headers are committed. A late stream failure cannot be treated as though a fresh HTTP response were still available; provide coherent boundary failure behavior and observable delivery errors. Backend/platform owners handle runtime backpressure and delivery infrastructure.

For stale output, trace the authority and invalidation path through server data, rendered output, client cache, and navigation. An optimistic client update is not proof that later navigation sees fresh server data. Verify mutation followed by revisit, reload, cold access, and refresh failure as applicable. Exact cache/revalidation calls require the installed framework contract.

Use [focus guidance](accessibility-focus-and-deferred-ui.md) for replacement behavior and [browser verification](browser-testing.md) for representative evidence.
