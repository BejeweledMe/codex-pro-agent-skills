---
name: "node-typescript-backend-engineering"
description: "Build, review, and debug Node.js/TypeScript backend services, including async lifecycle, streams, workers, Fastify/Express adapters, and runtime validation. Browser rendering belongs to web-frontend-engineering; HTTP/OpenAPI artifacts to api-contract-engineering; engine proof to database-engineering."
---

# Node and TypeScript Backend Engineering

Make accepted work bounded, observable, and owned through completion or failure. Preserve the application's framework and module choices unless changing them solves the requested problem.

## Working Loop

For a small fix, inspect the affected path and use the relevant reference. For broader implementation or review, trace:

1. **Runtime and module boundary.** Identify the deployed Node version, package manager, actual start command, module format, emitted artifact, and dependency initialization owner.
2. **One terminal outcome.** Trace input through the handler or task to its result, error, timeout, or cancellation. Separate caller completion from the actual domain effect; an abandoned response does not prove a write failed.
3. **Admission and cancellation.** Locate the constrained resource and its queue owner. Bound waiting and running work, include queue time in deadlines, propagate cancellation, and assign cleanup and late-result handling.
4. **Stream or worker handoff.** Preserve backpressure, framing, data ownership, task identity, and terminal cleanup. Ordinary `async` code does not offload CPU work.
5. **Validation and serialization.** Verify the actual parser, validator, handler input, response serializer, and framework scope. Type inference is a separate assurance.
6. **Drain and evidence.** Stop admission, settle or reconcile accepted work within a deadline, release resources, and verify the affected failure path as well as success.

Do not expand a routine endpoint change into a new architecture, pool, framework, or test harness without a demonstrated need.

## Reference Routing

Read only the material needed:

- [Runtime, modules, and async contracts](references/runtime-modules-and-async-contracts.md): loader failures, event-loop stalls, async races, readiness, terminal ownership, messaging adapters, and graceful drain.
- [Streams, backpressure, and cancellation](references/streams-backpressure-and-cancellation.md): large inputs, framing, slow consumers, stream topology, and partial completion.
- [Workers and bounded capacity](references/workers-and-bounded-capacity.md): CPU offload, task queues, clone/transfer/share semantics, correlation context, and worker failure.
- [Fastify and Express HTTP lifecycle](references/fastify-express-http-lifecycle.md): hook and middleware placement, terminal response ownership, schemas, type providers, serialization, and transport boundaries.
- [Testing and packaging](references/testing-and-packaging.md): `node:test`, fixture ownership, mock isolation, actual package loading, and focused verification.
- [Reference index and source scope](references/00_README.md): provenance and version-sensitive refresh guidance.

## Ownership and Handoffs

This skill implements Node runtime adapters, request/task lifecycle, transaction use, and actual domain effects.

| Unresolved decision | Primary owner and handoff |
| --- | --- |
| Observable HTTP/OAS/media/error or consumer compatibility | `api-contract-engineering`; pass operation identity, versions, expected contract, and actual request/response evidence. Implement the agreed adapter behavior here. |
| Distributed authority, delivery, durable idempotency, queue/log guarantees | `system-design`; pass effect boundary, task/message identity, timeout uncertainty, and failure window. |
| Event-time processing, pipeline publication, replay/backfill | `data-engineering`; pass source position, output/effect boundary, and observed completion state. |
| Engine constraints, isolation, locks, plans, or restore proof | `database-engineering`; retain connection/session and transaction cleanup here. |
| Browser state, React/Next rendering, server-client UI boundary | `web-frontend-engineering`. |
| General verification strategy or change lifecycle | `qa-testing` or `software-engineering`; retain Node runner, fixture, and package mechanics here. |
| Threat model and control design, or independent security verdict | `application-security-engineering` or `security-review`; implement the selected runtime controls here. |
| Deployment substrate or operated reliability | `platform-devops-engineering` or `sre-reliability-engineering`; pass startup/drain contract, resource limits, candidate identity, and runtime observations. |

Handoffs are needed only when that decision is open. They do not require loading every neighboring skill.

## Completion

Report the changed behavior, the violated or protected invariant, relevant verification, and material limits. For a review, lead with findings tied to a concrete path, consequence, correction, and evidence. Never equate a resolved Promise, successful stream finish, local socket write, or returned HTTP response with durable external completion.
