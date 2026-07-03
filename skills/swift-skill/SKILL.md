---
name: swift-skill
description: Use when designing, reviewing, validating, debugging, implementing, or releasing native iOS applications and modules built with Swift, SwiftUI, UIKit, SwiftData, or Apple frameworks. Trigger for Swift language architecture, value vs reference semantics, ARC and memory ownership, SwiftUI state and navigation, UIKit interoperability, SwiftData persistence, URLSession/networking, async/await, actors, MainActor, Sendable, app lifecycle/background work, permissions/privacy/security, Keychain, performance/Instruments, XCTest/XCUITest, TestFlight/App Store signing and release readiness, and long-term native iOS app maintenance.
---

# Swift Skill

Use this skill to design, review, validate, debug, implement, or release native iOS applications and modules built with Swift, SwiftUI, UIKit, SwiftData, and Apple frameworks. Treat native iOS quality as the product of Swift language design, Apple platform constraints, state/data ownership, privacy, performance, testing, signing/release, and maintenance.

## Core Rule

Do not start from a pattern name like MVVM, Clean, TCA, or "pure SwiftUI". First clarify product goals, target iOS versions, Apple frameworks/capabilities, data/offline needs, SwiftUI/UIKit boundaries, concurrency/lifecycle constraints, privacy/security requirements, performance budget, testing depth, signing/release target, and ownership.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/01-swift-native-architecture.md` for broad Swift/native design or review.
- For SwiftUI views, state ownership, navigation, UIKit interoperability, and UI architecture decisions, read `references/02-swiftui-state-navigation.md`.
- For SwiftData, persistence, networking, repositories, cache/offline, migrations, and source-of-truth design, read `references/03-swiftdata-networking-persistence.md`.
- For Swift concurrency, `async`/`await`, actors, actor reentrancy, `MainActor`, `Sendable`, app lifecycle, background work, ARC, leaks, and performance, read `references/04-swift-concurrency-memory-performance.md`.
- For Apple APIs, permissions, entitlements, privacy manifests, SDK signatures, Keychain, client trust boundaries, testing, observability, signing, TestFlight, App Store, and production readiness, read `references/05-swift-platform-security-testing-release.md`.

## Workflow

1. Classify the request:
   - New native app/feature design: read `01`, then `02`, `03`, `04`, `05` as needed.
   - Swift architecture/code review: read `01`, `04`, and the topic-specific references.
   - SwiftUI/UI-state/navigation: read `02`, then `04` for lifecycle/concurrency risks.
   - Persistence/offline/networking: read `03`, then `04` and `05`.
   - Concurrency/memory/performance debugging: read `04`, then `01` or `02`.
   - Privacy/security/platform capability work: read `05`, then `03` or `04` if data/concurrency is involved.
   - TestFlight/App Store/release readiness: read `05`, then `04` for performance/lifecycle risk.
2. Ask only for blocking details; otherwise state assumptions and proceed.
3. Preserve Swift semantics: distinguish value/reference behavior, ARC ownership, actor isolation, and SwiftUI state ownership.
4. Prefer the simplest architecture that preserves testability, lifecycle correctness, platform compliance, and maintainability.
5. Mark ideas not grounded in the references as `external extension`.

## Output For Design

Include platform assumptions, app/module boundaries, SwiftUI/UIKit architecture, state ownership, domain/data/repository/service boundaries, SwiftData/networking/offline plan, concurrency/lifecycle plan, Apple framework integration, privacy/security checks, testing/observability plan, signing/App Store plan, risks, and next steps.

## Output For Review

Lead with risks: incorrect value/reference modeling, force unwraps, ARC leaks, actor/main-actor misuse, SwiftUI state ownership problems, persistence/source-of-truth gaps, privacy/security blockers, testing/release gaps, and concrete fixes.

## Fact-Check Guardrails

- Do not claim SwiftUI requires MVVM or any single production architecture.
- Do not claim SwiftData replaces Core Data for every app or solves migrations/sync/availability without target-specific Apple docs.
- Do not call Swift actors atomic across `await`; account for actor reentrancy.
- Do not describe Swift value/reference semantics as simply stack vs heap.
- Do not use `weak` everywhere by default; reason about ownership.
- Do not treat mobile client code as a trusted security boundary.
- Do not call a native iOS app production-ready without real-device QA, privacy/security checks, tests, observability, signing/release plan, and App Store/TestFlight readiness.

## Quality Bar

- Prefer Swift value types for value-like domain state and classes only when identity/reference semantics are needed.
- Keep SwiftUI views declarative and keep business logic out of view bodies.
- Make async/cancellation/main-actor boundaries explicit.
- Tie performance advice to measurement, release builds, real devices, and Instruments-style evidence.
- Keep recommendations scoped to target iOS versions, Apple framework availability, team constraints, and release target.
