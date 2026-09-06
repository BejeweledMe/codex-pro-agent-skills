# Testing and Packaging

## Match Evidence to the Node Boundary

Use the project's established runner and commands unless changing them is part of the task. `node:test` with `node:assert/strict` provides a built-in option; this reference does not require migrating another runner.

| Changed behavior | Smallest useful evidence |
| --- | --- |
| Pure domain rule | Direct input/output or state assertions. |
| Async lifetime | Controlled success/rejection/cancellation plus observed terminal state and cleanup. |
| Stream parser or flow control | Artificial chunk splits, slow sink, early stop, and stage error. |
| Worker protocol | Queue expiry, crash/exit, late result, and awaited shutdown. |
| Framework adapter | Actual parser, hooks, validator, serializer, and error path. |
| Transport lifecycle | Listening server and real client exercising disconnect/stream/drain. |
| Engine transaction or locking behavior | Relevant production engine; an in-memory substitute cannot prove it. |
| Package/module change | Load and run the actual artifact through supported public entrypoints. |

General test strategy belongs to `qa-testing`; source/candidate lifecycle and release evidence belong to `software-engineering`. Choose only the cases material to the requested change.

## Own `node:test` Lifetime

Import the runner using `node:test`. Match the installed Node version's discovery, concurrency, and feature support.

- A test may complete synchronously, return a Promise, or use callback completion. Do not mix a returned Promise with callback completion.
- Await subtests explicitly and await async assertions. Keep asynchronous work within its owning test lifetime.
- Default file isolation uses child processes; tests inside a file still share one application thread and may share module/global state.
- File process isolation does not isolate a shared external database, filesystem location, port, or service.
- Configure finite time budgets for relevant async work; do not assume the runner supplies a safe finite default.
- An in-process timeout cannot reliably interrupt CPU-blocked JavaScript. A blocking-runtime test needs an outer process boundary if interruption itself matters.

Do not treat reporter text as a stable parsing interface. Use documented events/diagnostics where automation consumes results.

Check actual discovery and executed test counts when changing runner commands. Surface skips/TODOs; a green process with no meaningful assertions does not verify the change.

## Fixtures and Mocks

Prefer per-test injected dependencies for owned application code. Use a narrow fake or stub for a forced failure and a real adapter where its behavior is the subject.

Context-owned mocks provide scoped restoration, but restoring a global after each test does not isolate overlapping mutations. Two concurrent tests that replace `fetch`, a dispatcher, a module export, or environment state can still observe each other's replacement. Inject the dependency or serialize that shared-state suite.

Timer mocks do not necessarily intercept destructured timer imports. Verify what clock/timer dependency the code actually uses before concluding that a test controls time.

Have each fixture own creation and closure of its app, listener, client/dispatcher, database connection, worker, temporary files, and timers. Register cleanup as resources are acquired so partial setup failure also cleans up. Use isolated data namespaces where external resources are shared.

Use explicit readiness signals and controlled promises/events instead of arbitrary sleeps. Tests for cancellation should show both caller settlement and actual work/resource disposition.

When a fake stands in for an important adapter, check its supported contract against the real implementation. Fastify injection does not prove socket behavior, and in-memory SQLite does not prove another engine's dialect, locking, or transaction semantics.

If the runner hangs, inspect retained servers, timers, sockets, workers, subscriptions, and pending setup/teardown. Forcing process exit conceals the lifecycle defect.

## Verify Packaging as Execution

Inspect the existing package contract before changing configuration:

1. Identify the package manager and lockfile, build/check/test scripts, supported Node runtime, and production start command.
2. Trace source to emitted JavaScript and public package entrypoints. Check `type`, extensions, `exports`, and declaration entrypoints where published.
3. Confirm runtime dependencies and required assets exist in the candidate package. Development tooling resolving an import is insufficient.
4. Verify supported consumers load the same intended interface. Test both ESM and CommonJS only when both are promised.
5. Inspect intended package contents for source-only assumptions, missing artifacts, or unintended files. Keep contents allowlisted where appropriate.

Use the repository's lockfile-driven install workflow; for an npm project, `npm ci` is the reproducible-install mechanism to inspect/use when installation is in scope. Do not rewrite lockfiles or switch package managers to resolve an unrelated runtime defect.

Type checking, declaration generation, transpilation, and runtime validation establish different things. Native type stripping does not replace type checking or runtime schemas. Do not copy a general `tsconfig` recipe to solve one loader error; verify the exact compiler/runtime behavior needed.

For an ESM/CommonJS migration, localize translation, preserve promised exports, and exercise public consumers against the built package. Account for initialization timing and duplicate module instances, especially when stateful singletons are involved.

Dependency policy and vulnerability-control design belong to AppSec; source/candidate lifecycle belongs to software-engineering, and platform enforces build/deployment identity. This skill owns whether the Node artifact contains and loads the code and runtime dependencies it promises.

## Version-Sensitive Runner Limits

Verify individual mock, timer, coverage, reporter, tracing, and subtest facilities on the target Node line. A stable `node:test` module does not imply every documented helper is stable or available.

The v24.20.0 documentation material has unresolved coverage include/exclude wording and a forward-version inconsistency around `TestContext.attempt`. Do not derive exact precedence or availability from that snapshot. If those features matter, inspect target-version documentation and a focused execution result.

## Report Evidence Honestly

State which behavior was exercised, with which runtime/artifact and fixture fidelity, and what remains untested. After the relevant checks pass, broaden testing only for unresolved risks or new failures.

Sources: *Node.js Design Patterns*, fourth edition, chapters 2 and 10–11; Node.js Test Runner and Security Best Practices documentation; Express dependency guidance.
