# Focus, Semantics, and Deferred UI

Implement the accepted operable behavior as part of frontend correctness. Prefer existing native controls and established design-system primitives. A screenshot cannot prove keyboard operation, meaningful names, current state, or focus continuity.

The guidance here applies rendering and lifecycle mechanisms to practical accessibility. It is not a complete ARIA technique catalog or evidence of WCAG conformance.

## Keep State Truthful

| Transition | Implementation obligation | Useful verification |
| --- | --- | --- |
| Visible control awaits code/hydration | Provide working native/server behavior or understandable unavailable/pending behavior | Keyboard/touch activation before readiness has the promised outcome. |
| Deferred region replaces a placeholder | Reserve appropriate geometry and expose meaningful loading/failure state | Replacement does not unexpectedly move the user's target or lose focus. |
| Action fails | Preserve recoverable input and associate errors with the relevant controls | Users can locate, understand, correct, and retry. |
| Background content becomes stale | Distinguish allowed old content from a current authoritative result where it matters | Refresh failure does not falsely report current success. |
| Focused item disappears or is recycled | Preserve logical identity or move focus to an appropriate surviving target | Focus never silently belongs to a different record or vanishes into an unusable location. |
| Async completion arrives | Update status without gratuitously stealing focus or repeating announcements | The result is discoverable while ongoing work remains usable. |

Do not implement a facade as an image that merely looks interactive. Its activation must be available through the relevant input modalities, with pending, failure, and recovery behavior.

## Focus and Semantic Continuity

Inspect focus before and after navigation, hydration, streamed replacement, dialog/widget activation, removal, and virtualized recycling. Choose preservation or transfer according to the accepted interaction; do not focus every newly loaded region automatically.

Keep the visual focus indication, actual keyboard target, and exposed semantic state coherent. Visual order alone does not establish reading or focus order. Screen-reader virtual navigation is distinct from DOM focus.

For custom controls, establish name, role, state/value, keyboard behavior, visible focus, and dismissal/disabled behavior as applicable. Refresh the exact APG pattern and relevant browser/assistive-technology behavior before inventing a widget-specific keyboard map.

Use meaningful, bounded status announcements. Check ordering and duplication when multiple regions resolve. Loading skeletons and temporary duplicate content should not create a confusing semantic experience.

Visibility-based loading must also support keyboard and programmatic access. Pointer hover and scrolling cannot be the only routes to activation.

## Representative Checks

Select checks for the changed behavior: forward/reverse keyboard traversal, early activation, focus after replacement/removal, associated field errors, relevant assistive technology, zoom/reflow, small viewport and long content, forced colors/high contrast, and reduced motion.

For animations, preserve the same settled semantic outcome when motion is reduced or interrupted. For virtual lists, verify collection position and focus on logical items as well as smooth scrolling.

Product design owns missing acceptance decisions. Frontend owns the implementation and evidence. Report specific observed behavior and untested combinations; automated checks or APG usage alone do not certify accessibility.
