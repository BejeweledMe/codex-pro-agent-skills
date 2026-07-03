# Swift / Native Architecture

Use when: проектируешь SwiftUI/native app, native plugin/module, Swift layer inside Flutter app, или ревьюишь Swift code.

## Core Ideas

- Swift's language model strongly shapes iOS architecture: value types, optionals, protocols, access control, ARC and structured concurrency are design tools.
- Prefer `struct` and `enum` for most domain values and UI state because value semantics are easier to reason about.
- Use `class` when identity, inheritance, reference sharing, Objective-C/UIKit interop, lifecycle/deinit or ARC behavior is actually needed.
- ARC applies to class instances. Strong reference cycles can keep objects alive; `weak`, `unowned` and closure capture lists require deliberate ownership reasoning.
- Protocols define capabilities and contracts, but over-protocolizing every type can add indirection without improving testability.
- SwiftUI views are declarative descriptions. They should read state and emit actions, not become service locators or data stores.

## Native Layering

- UI: SwiftUI views/UIKit controllers render state and handle user interaction.
- Presentation/state: observable models, view models, reducers or app-specific state holders convert domain data into UI state.
- Domain: optional layer for business rules, validation and multi-repository operations.
- Data: API clients, persistence adapters, repositories, SwiftData/Core Data stores, Keychain wrappers.
- Platform services: push, location, camera, StoreKit, background tasks, HealthKit, App Intents and other Apple frameworks.

## Swift Language Guardrails

- Use `let` by default; use `var` only where mutation is part of the model.
- Avoid force unwraps in app logic unless an invariant is locally proven and crash is acceptable.
- Do not describe value types as "stack allocated" or classes as "heap only" in design docs; reason in terms of value/reference semantics.
- Remember Swift collections use copy-on-write optimization while preserving value-semantics behavior.
- Keep module boundaries explicit. Xcode targets and packages are architecture boundaries, not only build settings.

## Agent Checklist

- Is the type value-like or identity-like?
- Are ownership cycles possible through delegates, closures, observers or parent/child references?
- Are optionals modeled honestly rather than force-unwrapped?
- Are platform APIs isolated behind wrappers/protocols only where tests or substitution need it?
- Does SwiftUI state ownership match the view hierarchy and lifecycle?

## Anti-Patterns

- `SwiftUI = MVVM` as a universal rule.
- Massive observable object that stores every app concern.
- Class-first domain model without identity or shared mutable state requirements.
- Weak everywhere instead of correct ownership.
- Protocols for every concrete type before there is a second implementation or a test seam.

## Source / Provenance

- Swift language topics: `ClassesAndStructures`, `AutomaticReferenceCounting`, `Protocols`, `AccessControl`, `TheBasics`.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui): official learning path; use as conceptual tutorial source, not production architecture law.

## Cross-Links

- [08-concurrency-lifecycle.md](08-concurrency-lifecycle.md)
- [10-performance-memory-battery.md](10-performance-memory-battery.md)
- [07-networking-storage-persistence.md](07-networking-storage-persistence.md)
