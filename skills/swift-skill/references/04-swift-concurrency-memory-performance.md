# Swift Concurrency, Memory, And Performance

Use when: reviewing async work, actors, lifecycle, memory leaks, ARC, performance, jank, startup or battery.

## Concurrency

- Async is not the same as parallel. Async code can suspend and resume; parallel code runs simultaneously.
- Swift async functions suspend at `await` points and may resume on a different thread.
- `@MainActor` is the right boundary for UI-isolated work.
- Actors protect mutable state through isolation, but actor isolation does not make a multi-step operation atomic across `await`; account for actor reentrancy.
- `Sendable` matters for values crossing concurrency domains.
- There is no safe generic wrapper that lets synchronous code simply wait for async code. Convert top layers down.

## Memory / ARC

- ARC manages class instance lifetime.
- Strong reference cycles can occur through parent/child graphs, delegates, observers, timers, closures and async tasks.
- Use `weak` when the reference may become nil; use `unowned` only when lifetime guarantees justify it.
- Value types are easier to reason about, but do not reduce Swift design to stack vs heap.

## Performance

- Measure before optimizing.
- Use release/profile builds and real devices for performance conclusions.
- Avoid heavy work on the main actor.
- Watch image/media memory, startup work, polling, GPS and background tasks.
- Use Instruments-style evidence for leaks, allocations, time and energy.

## Source / Provenance

- The Swift Programming Language (Swift 6.3): `Concurrency`, `MemorySafety`, `AutomaticReferenceCounting`, `ClassesAndStructures`.
