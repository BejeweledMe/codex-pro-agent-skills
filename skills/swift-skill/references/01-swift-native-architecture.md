# Swift Native Architecture

Use when: designing or reviewing native Swift iOS app/module architecture, SwiftUI/UIKit boundaries, ownership or type modeling.

## Core Ideas

- Swift's language model shapes architecture: value types, optionals, protocols, access control, ARC and structured concurrency are design tools.
- Prefer `struct` and `enum` for value-like domain data and UI state because value semantics are easier to reason about.
- Use `class` when identity, reference sharing, inheritance, deinitialization, Objective-C/UIKit interop or ARC behavior is required.
- ARC applies to class instances. Strong reference cycles require ownership reasoning with `weak`, `unowned` and closure capture lists.
- Protocols define contracts, but over-protocolizing every type adds indirection without improving design.
- SwiftUI views should render state and emit actions, not become service locators or data stores.

## Layering

- UI: SwiftUI views or UIKit controllers.
- Presentation/state: observable models, view models, reducers or app-specific state holders.
- Domain: optional business rules and validation.
- Data: API clients, persistence adapters, repositories, SwiftData/Core Data stores, Keychain wrappers.
- Platform services: push, location, camera, StoreKit, background tasks, HealthKit, App Intents and other Apple frameworks.

## Anti-Patterns

- `SwiftUI = MVVM` as a universal rule.
- Class-first domain model without identity/reference requirements.
- Force unwraps in normal app flow.
- Weak everywhere instead of correct ownership.
- Protocols for every concrete type before a second implementation or test boundary exists.

## Source / Provenance

- The Swift Programming Language (Swift 6.3): classes/structures, ARC, protocols, access control, basics.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
