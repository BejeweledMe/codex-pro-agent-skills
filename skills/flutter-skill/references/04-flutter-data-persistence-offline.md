# Flutter Data, Persistence, And Offline

Use when: designing or reviewing Flutter API clients, repositories, cache, local storage, offline behavior, sync or source of truth.

## Core Ideas

- UI should not know whether data came from network, file, SQLite, memory cache or platform plugin.
- Repository owns source-of-truth behavior: refresh, cache, retry, error mapping, stale data and domain transformation.
- Services wrap concrete external data sources and expose async results.
- Persistence choice depends on data shape, query complexity, privacy, offline needs, migration risk and sync behavior.
- Cache is not automatically authoritative. Document freshness, invalidation and conflict behavior.

## Storage Guidance

- Key-value storage fits small settings and preferences, not rich domain databases.
- Files fit documents, media and cache blobs.
- SQLite/Drift/sqflite-style stores fit relational offline data and query-heavy use cases.
- Secure credentials belong in secure storage/Keychain-equivalent wrappers, not normal preferences.
- Repository APIs should expose domain data, not storage-specific rows.

## Agent Checklist

- What is source of truth: server, local store, user device or generated state?
- What must work offline?
- How are stale data, errors, retries and conflicts represented?
- What migration/versioning plan exists?
- Can repository tests run without real network/device storage?

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): repository/service responsibilities.
