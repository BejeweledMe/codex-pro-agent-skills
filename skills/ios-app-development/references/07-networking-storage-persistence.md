# Networking, Storage, And Persistence

Use when: проектируешь API clients, cache/offline behavior, local database, SwiftData, repository contracts or sync.

## Core Ideas

- UI should not know whether data came from network, file, SQLite, SwiftData, memory cache or platform API.
- Repository is the source of truth for application data in the Flutter architecture guide. It owns caching, retry, error handling, refresh and data transformation policies.
- Services wrap concrete data sources and expose async results.
- Persistence choice depends on data shape, sync needs, query complexity, privacy, migration risk and offline requirements.
- Cache is not automatically source of truth. Document invalidation, freshness, conflict handling and migration.

## Flutter Notes

- Key-value storage is for preferences and small settings, not domain databases.
- Files are useful for documents, media and cache blobs.
- SQLite/Drift/sqflite-style stores fit relational offline data and query-heavy use cases.
- Keep data stores behind repositories/services; avoid persistence calls in widgets.
- Treat plugin-specific persistence packages as infrastructure, not domain model.

## SwiftData Notes

- SwiftData is Apple's persistence framework for declarative model code, managed persistence and efficient model fetching.
- Apple docs describe SwiftData as combining Core Data persistence technology with Swift concurrency features and modern Swift language features.
- `@Model` makes a model class persistable.
- `@Attribute` and `@Relationship` customize model property and relationship behavior.
- `ModelContext` is used to fetch, insert, delete and save model changes.
- `ModelContainer` provides the storage/container configuration and can be set in SwiftUI environment.
- `@Query` can fetch models for SwiftUI views and update the view when fetched models change.
- Do not claim SwiftData replaces Core Data for every app, solves all migrations or works on every target without checking availability.

## Agent Checklist

- What is source of truth: server, local store, user device, generated state?
- What must work offline?
- How are retries, errors, stale data and conflicts represented?
- What data needs encryption or Keychain rather than normal storage?
- What migration/versioning plan exists?
- Can repository tests run without real network or device storage?

## Anti-Patterns

- Persistence code inside Flutter widgets or SwiftUI views.
- Treating local cache as authoritative without sync policy.
- Storing secrets in normal preferences or app files.
- Building repository APIs around raw JSON or database rows.
- Choosing SwiftData only because it is new, without checking target OS and migration needs.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): repository/service responsibilities.
- [Apple SwiftData](https://developer.apple.com/documentation/swiftdata): persistence framework overview and APIs.
- Apple SwiftData documentation was checked during research on 2026-07-03. Recheck official Apple docs for target-specific availability, migration and sync decisions.
- The Swift Programming Language (Swift 6.3): Swift concurrency and language model background.

## Cross-Links

- [02-flutter-ios-architecture.md](02-flutter-ios-architecture.md)
- [08-concurrency-lifecycle.md](08-concurrency-lifecycle.md)
- [09-permissions-privacy-security.md](09-permissions-privacy-security.md)
