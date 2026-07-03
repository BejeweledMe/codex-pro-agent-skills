# SwiftUI State And Navigation

Use when: designing or reviewing SwiftUI views, state ownership, navigation, UIKit interop or UI architecture.

## Core Ideas

- SwiftUI views are declarative descriptions of UI from state.
- Keep view bodies focused on rendering and action dispatch; move business rules out.
- Choose state ownership according to lifecycle: local view state, parent binding, environment, observable model, repository-backed state or persistent model query.
- Navigation state describes user location and should not become hidden business storage.
- UIKit interoperability is valid, but wrappers should be narrow and explicit.

## Practices

- Keep state mutation in clear owners: model/view model/store/reducer/service depending on architecture.
- Model loading/error/empty/success states explicitly.
- Validate navigation input and deep-link parameters.
- Keep SwiftUI views small enough that ownership remains visible.
- Use previews and UI tests as aids, not substitutes for device QA.

## Anti-Patterns

- Network or database work directly in view body.
- Massive observable object with every app concern.
- `@State` used as persistence.
- Tutorial examples treated as production architecture law.
- UIKit bridge objects leaking framework details into domain logic.

## Source / Provenance

- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui): official learning path for SwiftUI concepts.
- The Swift Programming Language (Swift 6.3): value/reference and concurrency background.
