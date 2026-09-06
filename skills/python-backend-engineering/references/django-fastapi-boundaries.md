# Framework And Validation Boundaries

## Place Each Check Where Its Evidence Exists

| Question | Implementation home | Evidence |
| --- | --- | --- |
| Is this message structurally acceptable, and which conversions are allowed? | Input adapter and validation model | Raw representation, entrypoint, parsed value, strictness, and extra-field policy. |
| Does the referenced object exist in the relevant current state? | Handler or application service using its transaction | Loaded state and the application precondition. |
| Is this business transition allowed? | Domain function or model, where complexity warrants it | Business examples and invariants, including competing writes where relevant. |
| Is the caller allowed to perform it? | Actual application enforcement boundary | Identity, resource context, and the control supplied by application-security-engineering. Shape validation is insufficient. |
| Does the outbound representation match the public contract? | Serialization/integration adapter | Actual emitted payload, field selection, conversions, and error mapping. API compatibility belongs to api-contract-engineering. |

For CRUD, these can be a few explicit checks in an existing handler. Separate responsibilities without manufacturing classes for every row of the table.

## Pydantic: Inspect Both Sides Of Conversion

Pydantic validation promises a resulting model that satisfies its rules. It does not prove the original representation was unchanged, semantically correct, or authorized.

When an identifier, amount, date, or flag changes meaning:

1. Compare the raw input with the resulting model field. Identify whether validation used Python objects or JSON input.
2. Inspect coercion, validators, defaults, extra-field handling, and strictness at call, field, and model levels.
3. Decide which distinctions the application must preserve. Choose coercion deliberately; do not enable global strictness merely because one field needs it.
4. Exercise accepted and rejected representations through the real adapter, then inspect outbound serialization. Enabling strictness or forbidding previously ignored fields can change compatibility.

Strict JSON and strict Python validation can accept different representations; strict JSON may still accept forms needed to represent types such as dates. In Pydantic v2, extra fields default to being ignored unless configured otherwise. Check the actual model rather than inferring its behavior from annotations.

`model_construct()` bypasses validation and nested-model conversion. It is inappropriate for untrusted input and is not a universal performance shortcut. Even a configuration that forbids extras during normal validation does not turn construction into validation.

Prepare explicit response or event data while required state is available. If serialization triggers ORM access after the Session closes, identify the missing load or conversion boundary; keeping every Session alive indefinitely obscures ownership.

## Django: Keep Transactional Work Inside Its Supported Boundary

The captured Django 6.1-era documentation does not support transactions directly in async mode; verify that limitation for the target version. For a transactional operation called by async code, put the complete transactional ORM unit in a synchronous helper and enter it through Django's supported sync/async adapter. Avoid one crossing per row, and do not pass live connections or cursors across threads.

For `SynchronousOnlyOperation`, inspect the actual execution context and called ORM path. Move the operation to its supported boundary. Disabling async safety is not a repair.

Check server and middleware behavior before claiming an async benefit. WSGI adaptation and synchronous middleware can change execution and resource costs. For the documented async mode, disable persistent Django connections and use supported backend pooling where needed; verify the target version and driver.

With per-request transactions, the view body is covered. Middleware, template-response rendering, and streaming content generation are outside that transaction. Finish business writes before streaming begins. If a stream itself drives effects, define a separate effect and recovery boundary; a response already being sent cannot provide ordinary request rollback behavior.

When a job depends on writes, register its enqueue through `transaction.on_commit()`. The callback runs after successful commit, is discarded on rollback, and runs immediately when no transaction is open. Failure in the callback cannot undo the committed transaction. See [persistence and durable effects](sqlalchemy-and-durable-side-effects.md) for the remaining publication gap.

Pass task identifiers and primitives that survive the configured serialization round trip. Do not hand a worker live ORM objects or assume a value retains Python-specific type identity through JSON.

The Django Tasks framework, new in 6.0, defines and enqueues work; the framework described in the captured documentation does not supply a production worker. Immediate and dummy backends support development/testing and do not prove queue durability, worker execution, or result-backend behavior.

Apply selected security controls at their real boundary: preserve parameterized queries, use Django's validated host accessors, and inspect escaping or CSRF bypasses when changing those paths. Framework defaults do not establish upload content safety, authentication throttling, or complete security coverage. Route control design to application-security-engineering.

## FastAPI: Own Lifespan And Test Substitution Explicitly

Use `FastAPI(lifespan=...)` for application-lifetime shared resources. Acquire resources before serving and release them after use. Verify cleanup for setup failure as well as normal exit.

Supplying lifespan replaces the older startup/shutdown event-handler path; do not split resource initialization between both mechanisms. Main-application lifespan does not automatically initialize mounted sub-applications. Establish their ownership separately.

`app.dependency_overrides` is mutable application state keyed by the original dependency callable. The replacement also substitutes for its sub-dependencies. An override may declare a different signature; its own parameters can still be resolved from the request.

For an override leak:

1. Find the original callable used as the key and all fixtures that mutate the mapping.
2. Scope the override to the test and restore the prior mapping in cleanup, including on assertion failure.
3. Avoid overlapping tests that independently mutate the same application instance; an isolated app is often simpler.
4. Verify the original dependency is used again after teardown.

For async endpoint tests, the documented combination is AnyIO with HTTPX `AsyncClient` and `ASGITransport`. The transport does not trigger lifespan. Enter lifespan explicitly when startup resources matter, and construct loop-bound clients inside the active async context. Check teardown, not just the HTTP result.

## Version And Integration Limits

The FastAPI basis is a bounded snapshot of the official repository documentation (reported version 0.141.1) covering lifespan, overrides, and async tests. It does not verify release behavior or live-site parity, or establish a complete routing, authentication, yield-dependency, streaming, or SQLAlchemy integration recipe. Resolve those details from the project's version and relevant official documentation before prescribing exact wiring.

Django async transaction support, Tasks, middleware behavior, and pooling configuration are version-sensitive. Pydantic guidance is v2-oriented. Changes to validation or serialization need adapter evidence and, when observable behavior changes, API compatibility assessment.
