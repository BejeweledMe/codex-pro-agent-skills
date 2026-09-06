# Packaging And Tests

## Select Evidence For The Changed Boundary

Use the existing runner and fixtures. General risk-to-layer strategy belongs to qa-testing; this reference owns Python execution and isolation mechanics.

| Changed behavior | Useful local evidence | What it does not prove |
| --- | --- | --- |
| Business rule | Focused domain or use-case examples. | ORM mapping, engine concurrency, or framework wiring. |
| Service orchestration | A narrow fake repository/UoW, if that boundary exists. | Real flush, commit, rollback, or constraint behavior. |
| Persistence adapter | Controlled real-engine mapping/query and transaction checks. | Full request or broker behavior. |
| Framework adapter | Actual parsing/serialization, dependency resolution, lifespan entry/exit, and cleanup. | Deployment or network behavior bypassed by the test client. |
| Durable job effect | Commit ordering, duplicate delivery, and the relevant failure window. | Broker behavior when execution is only eager or in-process. |
| Package configuration | Build and install the artifact in isolation, then import and exercise it. | Correctness of unrelated application behavior. |

Choose checks proportional to the change. Do not create every layer for a routine edit or build a generic harness to test one boundary.

## Fixture Ownership

For every stateful fixture, identify creation scope, concurrent users, cleanup, and the state that must be absent afterward. App-wide override maps, database transactions, event-loop-bound clients, and task lists deserve particular attention.

For FastAPI async tests:

1. Use the project's supported AnyIO setup and HTTPX async client/ASGI transport.
2. Enter application lifespan explicitly when startup or shutdown resources matter.
3. Create loop-bound resources inside the active async context.
4. Scope callable-keyed dependency overrides and restore prior state even after test failure.
5. Close the client and exit lifespan; verify resource closure or restored dependencies where those are the bug.

`ASGITransport` does not start lifespan. A passing response alone can conceal missing initialization if a fake bypasses the resource. Avoid concurrent mutation of one shared application's override mapping.

For Django commit callbacks, determine whether the fixture actually commits. A rollback-wrapped test may never run `on_commit()` callbacks. Explicit callback capture/execution can prove registration and callback behavior; a transaction-committing test is needed when actual commit ordering is the claim. An immediate task backend cannot reproduce a separate worker connection racing the transaction.

## SQLAlchemy Test Transactions

The documented synchronous isolation recipe opens a Connection and outer transaction, then binds a Session with `join_transaction_mode="create_savepoint"`. Session-level commits and rollbacks operate within SAVEPOINTs; teardown ends Session ownership and rolls back the outer transaction.

Use that pattern only with compatible engine/driver SAVEPOINT behavior and explicit fixture ownership. Confirm rows do not escape between tests. Do not copy it unchanged into async framework dependencies and assume the same lifecycle.

This pattern is useful for isolation, but the outer transaction never commits. It cannot by itself prove production commit visibility to another connection or durable effects after a real commit. For those claims, use a controlled test that actually commits and cleans up its data separately.

When fakes pass but production fails, inspect generated SQL, mappings, constraint behavior, flush timing, rollback state, and object expiration. Use the production engine family for behavior that depends on its semantics; a different in-memory engine is not interchangeable evidence.

For a concurrency defect, coordinate competing operations around the disputed read/write boundary and inspect final state. Repeated timing sleeps and a larger retry count do not explain the invariant.

## Test The Installed Artifact When Packaging Changes

Inspect `pyproject.toml` and the repository's existing environment/build tools.

- `[build-system]` requirements enable building; application runtime dependencies belong in project metadata.
- Project `name` is static. `version` must be supplied or declared dynamic.
- `requires-python` gates installation; classifiers describe support without enforcing it.
- Keep the existing layout unless a demonstrated import or packaging issue warrants change. For a new package, `src/` layout helps separate source-tree imports from installed-package behavior.
- Editable installation supports development but does not prove wheel contents or clean-environment imports.

For a packaging change, build the relevant sdist/wheel through the project's backend, install the candidate in an isolated environment, and run the relevant imports/tests against that installation. Use existing tox configuration or an equivalent installed-artifact workflow; introducing tox is not mandatory.

If tests pass locally but imports fail after installation, compare the imported module path, built file contents, package discovery, runtime dependencies, and Python version gate. Fix the missing artifact or metadata rather than adding source-directory paths to production.

For new pytest projects, consider `importlib` import mode to avoid test-import path manipulation; preserve established mode unless changing it solves a real problem. Avoid deprecated `setup.py test`/pytest-runner workflows. If adopting pytest's broad strict mode, pin and review the pytest version because the enabled strict checks can grow.

## Report The Evidence Boundary

State the interpreter, relevant dependency and engine versions, tested entrypoint, and whether execution used fakes, a real adapter, a real commit, or an installed artifact. For an isolated fix, this can be a short validation note.

Framework/plugin loop scope, async driver integration, pytest strict settings, and build-backend metadata support are version-sensitive. PEP 639 license metadata in particular depends on the build backend's supported version. Binary-extension packaging and complete broker/worker operations require additional targeted documentation and environment evidence.
