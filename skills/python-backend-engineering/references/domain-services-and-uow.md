# Domain Services And Unit Of Work

Use these patterns when an existing pain justifies them. *Architecture Patterns with Python* presents an evolution path, not the required shape of every Python service.

## Add The Smallest Useful Boundary

| Observed pressure | Useful move | Stop condition or counterexample |
| --- | --- | --- |
| A handler mixes repeated orchestration with transport parsing. | Extract a named use-case function that loads state, checks preconditions, invokes behavior, and owns persistence outcome. | A short CRUD handler may already be clear. |
| Business decisions are scattered across ORM callbacks and endpoints. | Move those decisions into domain functions, entities, or value objects. | Do not build a rich object model merely to mirror table columns. |
| Persistence details make core behavior difficult to change or test. | Add a narrow application-shaped repository port and real adapter. | A repository that exports Sessions, query builders, and arbitrary ORM operations adds little separation. |
| Commit and rollback are scattered across helpers. | Establish one transaction owner; add a UoW wrapper if it provides a useful narrow interface. | SQLAlchemy's Session/context or Django's transaction scope may already suffice. |
| Several objects must obey one invariant under concurrent writes. | Evaluate an aggregate root around the smallest required consistency boundary. | A cluster of related tables is not automatically an aggregate. |
| Read queries fight the write model's shape. | Add a simpler read path. | CQRS does not require another store, service, or event bus. |
| Wiring and import patching dominate tests. | Use explicit composition and dependency injection. | Do not adopt a DI framework for a handful of dependencies. |

## Keep Business Meaning In The Right Place

Use value objects for value-defined concepts and entities when identity persists across change. A domain service can be a plain function when a business operation has no natural entity home.

Separate domain services from application services. The application loads current state and handles existence or use-case preconditions; the domain decides whether the business transition is valid. A missing item and insufficient stock need different evidence even when both eventually become an error response.

Accept primitives or simple request data at a use-case boundary so callers need not construct an internal object graph. Keep stateful I/O out of interesting decisions where that separation pays off. Mapping compromises can be reasonable; purity is not the objective.

## Repository And UoW Have Different Jobs

A repository provides the persistence operations required by the application. Keep it narrow enough to explain and fake. Its usefulness comes from hiding irrelevant persistence details, not from a universal `add/get/list/delete` interface.

A UoW owns atomic lifetime, repository access, and outcome. If adopting the book's wrapper style, default to rollback and require explicit commit after successful use-case work. A deliberate framework transaction context that commits on successful exit is also valid; choose one visible convention rather than stacking conflicting owners.

A fake is feedback on the port and orchestration. Real adapters still need evidence for mapping, queries, commit, rollback, and the relevant engine behavior. See [packaging and tests](packaging-and-tests.md).

## Treat Concurrency As A Boundary Test

An aggregate is a revisable hypothesis about which mutations must remain consistent together. Inspect contention, loaded state, and paths bypassing the root:

- Unrelated work serializing may indicate a boundary that is too broad.
- One invariant updated through independent roots may indicate a boundary that is too small.
- Large query-only navigation may belong on the read side.

For an optimistic conflict, discard stale in-memory state, start a fresh UoW, reload, and rerun the complete operation. Retrying only `commit()` or reusing the old aggregate preserves stale decisions.

The retry can legitimately produce a different business result, such as insufficient stock. Bound the retry policy and account for external effects before repeating the operation. Optimistic versioning, pessimistic locking, and stronger isolation are alternatives whose engine costs and guarantees belong to database-engineering; the teaching example does not select production settings.

## Internal Events Do Not Establish Delivery

An internal domain event records that a business fact happened. Appending it to an aggregate's event list is not publishing it to a broker or scheduling durable work.

An in-process bus can separate reactions when side effects have become difficult to place. If using event collection from a UoW, ensure real and fake repositories track the aggregates whose events must be collected. Missing tracking can silently drop events before delivery is even attempted.

Treat commands as intent with one responsible handler by convention, and events as facts with zero or more reactions. Do not copy “log and continue” into a required effect without detection and recovery: a failed notification or stale read model still has a consequence.

When work crosses the first commit boundary, define what detects incomplete follow-on work and how it is retried or repaired. The book's synchronous bus and Redis Pub/Sub example do not provide crash durability, replay, or exactly-once effects. Use [persistence and durable effects](sqlalchemy-and-durable-side-effects.md) for local implementation obligations and system-design for the cross-system guarantee.

Select, translate, and validate internal events into public messages at the integration boundary. Internal model refactoring should not automatically change externally consumed payloads. HTTP compatibility belongs to api-contract-engineering; cross-service event contracts belong to system-design. Keep the actual Python adapters and their observed payload checks here.

## Start CQRS With A Read Path

Use the lowest sufficient step:

1. Existing repository/domain reads.
2. A purpose-shaped ORM query.
3. Direct SQL for the read shape.
4. A denormalized table in the same database.
5. A separately maintained read store.

Move upward for demonstrated query shape, workload, or freshness needs. An ORM-to-SQL change may solve the problem without a projection.

The write path remains authoritative and revalidates business constraints. For a projection, establish acceptable staleness and how authoritative data can rebuild it. Maintained replay/backfill and temporal publication mechanics belong to data-engineering; physical plans and index choices belong to database-engineering.

## Evolve One Use Case At A Time

Start with one painful operation, preserve its observable behavior, and give it a clear transaction boundary. Extract decisions from I/O only where useful. Use identifiers at boundaries when passing live objects would couple lifetimes.

Compose real dependencies explicitly at application bootstrap, with test substitution at the same seam. Closures, `functools.partial`, callable objects, or an explicit handler map can be enough. Avoid hiding resource acquisition in import-time defaults. Introduce events or new adapters at selected seams and prove the working path before expanding.

Verify the extracted use case and its real adapter, then remove the superseded path when migration permits. Stop adding layers when their maintenance cost exceeds the coupling they remove.

The source supports these conditional design moves, not production retry constants, broker configuration, a preferred DI library, or a universal modernization sequence.
