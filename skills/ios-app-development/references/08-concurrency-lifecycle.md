# Concurrency And Lifecycle

Use when: feature uses async work, network calls, streams, isolates, Swift concurrency, background/foreground lifecycle or cancellation.

## Core Ideas

- Async is not the same as parallel. Async code can suspend and resume; parallel code runs simultaneously.
- UI work must stay responsive. CPU-heavy work should not block Flutter main isolate or iOS main thread/main actor.
- Cancellation and lifecycle interruptions are normal mobile behavior, not edge cases.
- Shared mutable state is the danger zone. Swift uses actors/isolation/Sendable to make many data-race problems visible; Dart isolates avoid shared memory by design.
- Async result should enter UI as explicit state: loading, success, empty, error, refreshing, stale.

## Flutter / Dart Notes

- `Future` represents one asynchronous result; `Stream` represents a sequence of asynchronous values.
- `async`/`await` improves readability but does not make CPU-heavy work parallel.
- Use isolates for CPU-heavy parsing, image/data processing or other work that would block the main isolate.
- Keep stream subscriptions and controllers lifecycle-aware; cancel/dispose them when owner ends.
- Avoid firing async side effects from build methods.

## Swift Notes

- Swift async functions can suspend at `await` points and resume later; Swift does not guarantee the same thread after resume.
- `await` marks possible suspension points, which helps reason about interleaving.
- Actors protect their mutable state through isolation and allow one operation on actor state at a time.
- Actor isolation does not make a multi-step operation atomic across `await`; actor reentrancy means invariants must be restored before suspension or guarded explicitly.
- `@MainActor` is the right boundary for UI-isolated work.
- `Sendable` marks values that can safely cross concurrency domains; mutable non-isolated classes are risky.
- There is no safe generic wrapper that lets synchronous code simply wait for async code. Convert from top layers down.

## Agent Checklist

- Which async operations can outlive the screen?
- What cancels work when the user navigates away?
- Is CPU-heavy work moved off the UI execution context?
- Are retries idempotent?
- Are actor/main-actor boundaries explicit in Swift?
- Are streams/subscriptions disposed?

## Anti-Patterns

- Blocking main isolate/thread with JSON parsing, image processing or synchronous IO.
- Detached/unstructured tasks as a default fix.
- Ignoring cancellation because "the request is quick".
- Updating UI from the wrong isolation context.
- Treating async errors as logs instead of user-visible/error-state outcomes.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): services expose async objects and repositories manage data flow.

## Cross-Links

- [05-ui-navigation-state.md](05-ui-navigation-state.md)
- [07-networking-storage-persistence.md](07-networking-storage-persistence.md)
- [10-performance-memory-battery.md](10-performance-memory-battery.md)
