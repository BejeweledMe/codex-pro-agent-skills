# Performance, Memory, And Battery

Use when: app has jank, startup issues, memory pressure, leaks, heavy images, expensive lists, slow network/data processing or battery concerns.

## Core Ideas

- Mobile performance is user-visible: startup, smooth scrolling, input latency, network wait, memory pressure and battery drain.
- Optimize after measuring. Use Flutter DevTools, Xcode Instruments, logs, traces and real devices.
- Avoid work on the UI execution context: Flutter main isolate or Swift main actor/thread.
- Memory problems in Swift often come from class reference cycles, closure captures and long-lived observers/tasks.
- Battery problems often come from polling, GPS, background work, chatty networking, large media and repeated rebuilds/re-renders.

## Flutter Notes

- Keep rebuild scopes small. Use selectors/Consumers or state partitioning where appropriate.
- Avoid heavy computation in `build`.
- Use list virtualization patterns for long lists.
- Control image sizes/caches; large image decode can dominate memory and frame time.
- Use isolates for CPU-heavy work and profile before/after.

## Swift / Native Notes

- ARC handles class-instance lifetime but cannot break strong reference cycles automatically.
- Use `weak` or `unowned` based on ownership, not habit.
- Be careful with closures that capture `self`, delegates, timers, observers and async tasks.
- Swift value types are easier to reason about, but copy-on-write and large data still require measurement.
- Use Instruments for leaks, allocations, time profiler and energy diagnostics.

## Agent Checklist

- Is there a measured performance problem?
- Does the issue reproduce on real devices and release/profile build?
- What is on the main isolate/main actor?
- Are rebuild/render scopes bounded?
- Are images/media sized and cached deliberately?
- Are long-lived closures/tasks/observers retaining owners?
- Are polling/background operations necessary and rate-limited?

## Anti-Patterns

- Optimizing by intuition only.
- Debug-build performance conclusions.
- Large synchronous JSON/image/file work on UI path.
- Permanent streams/timers without disposal.
- Capturing `self` strongly in long-lived Swift closures.
- "Fixing" leaks by making everything weak without ownership design.

## Source / Provenance

- The Swift Programming Language (Swift 6.3): `AutomaticReferenceCounting`, `ClassesAndStructures`, `Concurrency`.
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): animations, widgets, async/isolate educational examples.
- [Flutter docs](https://docs.flutter.dev): official performance/debugging sections should be checked for tool-specific steps when doing live optimization.

## Cross-Links

- [08-concurrency-lifecycle.md](08-concurrency-lifecycle.md)
- [11-testing-debugging-observability.md](11-testing-debugging-observability.md)
- [14-production-checklist.md](14-production-checklist.md)
