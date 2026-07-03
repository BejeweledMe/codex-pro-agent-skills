# SwiftData, Networking, And Persistence

Use when: designing or reviewing native persistence, SwiftData, URLSession/API clients, cache/offline, repositories or source of truth.

## Core Ideas

- UI should not know whether data came from URLSession, SwiftData, Core Data, files, Keychain or memory cache.
- Repository/data owner should define source-of-truth, refresh, cache, retry, stale data and error mapping.
- SwiftData is Apple's persistence framework for declarative model code, managed persistence and efficient model fetching.
- Apple docs describe SwiftData as combining Core Data persistence technology with Swift concurrency features and modern Swift language features.
- Do not claim SwiftData replaces Core Data for every app, solves all migrations or works on every target without checking current Apple docs.

## SwiftData Notes

- `@Model` makes a model class persistable.
- `@Attribute` and `@Relationship` customize property and relationship behavior.
- `ModelContext` fetches, inserts, deletes and saves model changes.
- `ModelContainer` provides storage/container configuration and can be set in SwiftUI environment.
- `@Query` can fetch models for SwiftUI views and update views when fetched models change.

## Agent Checklist

- What is source of truth: server, local store, user device or generated state?
- What must work offline?
- What migration/versioning plan exists?
- What data belongs in Keychain rather than normal persistence?
- Are SwiftData availability and migration assumptions checked against target OS?

## Source / Provenance

- [Apple SwiftData](https://developer.apple.com/documentation/swiftdata)
- The Swift Programming Language (Swift 6.3): concurrency and language model background.
