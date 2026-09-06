# Fastify and Express HTTP Lifecycle

## Trace the Actual Adapter

Start from the route and follow parser → validation → async checks → domain operation → serialization → send → completion/cleanup. Identify the selected media parser, framework version, plugin/router scope, and error handler.

The Node adapter owns executing the agreed contract. `api-contract-engineering` owns observable HTTP/OAS/media/error and consumer compatibility decisions. Pass exact request/response evidence when those differ; do not change status or error shape merely to conceal a runtime defect.

The response and the domain effect have separate states. Choose when an effect is considered successful and which observation proves it. A response timeout or disconnect can coexist with a committed effect.

## Fastify: Keep the Runtime Layers Separate

| Layer | Inspect | Failure and correction |
| --- | --- | --- |
| Parsing | Content type, selected parser, bounded body | A custom parser can produce a body without establishing schema validation; configure and test the intended media path. |
| Request validation | Runtime schema and actual validator/compiler | Inferred types cannot reject malformed traffic; test real invalid inputs and resulting handler input. |
| Response serialization | Response schema and serializer/compiler | A correct internal object can produce wrong wire output; inspect field inclusion, additional-property policy, and custom serialization, then assert actual output and errors. |
| Type inference | Provider applied to the intended scope | Compile-time agreement alone says nothing about installed runtime compilers. |
| Encapsulation/lifecycle | Registration graph, inherited schemas/decorators/hooks | A route moved between plugins can lose required setup; correct the ownership scope and verify affected siblings/children. |

The standard Fastify path uses Ajv for validation and `fast-json-stringify` for serialization. Schema compilation generates code: compile trusted application schemas, not user-supplied schemas.

Keep initial schema validation free of database or external I/O. Put asynchronous checks in the appropriate later hook, commonly `preHandler`. Custom validator functions should follow the configured `{ value }`/`{ error }` result contract rather than throw across async validation hooks.

Place work where its inputs exist:

- `onRequest` and `preParsing` precede body parsing.
- `preValidation` sees parsed input before validation.
- `preHandler` follows validation and can perform required async checks.
- The handler executes the operation.
- `preSerialization` and `onSend` concern response preparation; payload-specific exceptions require the installed-version contract.
- `onResponse` observes completed response handling; it is too late to change the response.

Use one hook completion style: callback or Promise. Do not call a completion callback and also return an async completion path.

`register()` normally creates a child context. Descendants inherit ancestor setup; child schemas, hooks, and decorations do not automatically become available to parents or siblings. `fastify-plugin` changes encapsulation and can affect registration options; treat it as an ownership change.

With a custom validator instance, explicitly supply the schemas it needs. Do not assume Fastify's shared schema registry also configured that external instance.

Type providers adapt inference. Apply the provider where the routes are declared and wire the matching runtime validator/serializer compilers when required, including Zod integrations. A literal-preserving schema declaration can improve inference without changing runtime behavior. Verify package names, imports, provider compatibility, and compiler setup against installed versions.

## Express: Own Continuation and Errors

Order middleware so parsing and required checks precede the handler that uses them. Separate transport concerns from a narrow domain function when that makes lifetime and testing clearer.

Each branch must deliberately continue, send, or forward an error. Return after sending or delegating so later code cannot send again. Keep error middleware in the correct chain and preserve the framework's required error-handler signature.

Inspect the Express major version before relying on rejected route/middleware Promises reaching the error handler automatically. Where explicit forwarding is needed, ensure rejection reaches `next(error)` once. Errors in detached callbacks, timers, or streams still need their own owner.

Before response commitment, map a known failure through the agreed error adapter. After headers/output are committed, follow the framework/transport termination path; a `headersSent` check is a last guard, not a substitute for single response ownership.

Handle recoverable failures near their source. Do not use `uncaughtException` to keep a potentially corrupted application serving ordinary requests.

## Cancellation, Streaming, and Raw Responses

Map request abandonment and deadlines into the operation's cancellation policy using the installed framework/Node event semantics. Do not assume every `close` event means a client cancelled. Remove registered listeners after terminal completion.

If work cannot be cancelled, retain its effect-status owner after the HTTP response lifetime ends. Suppress duplicate response sends while continuing required reconciliation.

Streaming or raw-response/hijack paths transfer lifecycle responsibilities. Identify who sends/ends/destroys, which hooks still execute, who owns backpressure, and what happens on a source error. Verify exact framework behavior before bypassing automatic reply handling.

A configured handler/socket timeout does not prove downstream work stopped. Coordinate admission, operation deadline, dependency timeouts, and drain.

## Trust and Deployment Boundary

Implement selected controls at their actual boundary: bounded input and decompression, validation, safe redirect destinations, session storage, and error/log redaction. Use AppSec for control design and policy.

Cookie-backed sessions are client-visible and fit only suitable small non-secret state. Server-side sessions still require an appropriate production store; process-local memory does not become shared by adding replicas.

Proxy-provided identity, scheme, and address information requires the deployed trust boundary. Do not blindly enable proxy trust or infer cookie/TLS behavior from middleware alone. Platform owns proxy and deployment configuration.

Inspect the actual header/request/socket/keep-alive timeout relationships instead of copying numeric defaults. Avoid permissive parsing as a workaround for ambiguous traffic. Inspector exposure and signal-triggered activation belong in the runtime/deployment control review when relevant.

## Evidence for a Change

Select the relevant cases: malformed body, unsupported media path, schema/type mismatch, serializer failure, async dependency rejection, duplicate completion, disconnect, or drain. Assert observable status/headers/body and actual domain effects separately.

After a plugin/provider change, verify routes in the intended scopes and inspect runtime validation as well as type checking. Fastify injection can test routing/hooks/serialization without a listening socket; use a real transport when connection behavior is the defect.

Sources: Fastify Validation and Serialization, Encapsulation, Type Providers, and Lifecycle documentation; Express Production Best Practices; *Node.js Design Patterns*, fourth edition, chapters 9–11.
