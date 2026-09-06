# Reference Index

Choose the reference for the failing boundary; read across boundaries when work changes owner.

| Need | Reference |
| --- | --- |
| Module loading, event-loop fairness, async completion, startup, drain | [Runtime and async contracts](runtime-modules-and-async-contracts.md) |
| Bounded streaming, decoding/framing, slow sinks, partial output | [Streams](streams-backpressure-and-cancellation.md) |
| CPU execution, pool admission, cross-thread data, correlation | [Workers and capacity](workers-and-bounded-capacity.md) |
| Request hooks, middleware, runtime schemas, response serialization | [HTTP lifecycle](fastify-express-http-lifecycle.md) |
| Node test lifetime, fixtures, package artifacts and loader evidence | [Testing and packaging](testing-and-packaging.md) |

## Sources and Scope

The mechanisms draw on:

- Mario Casciaro and Luciano Mammino, *Node.js Design Patterns*, fourth edition: chapters 1–5 for execution/modules/async control flow; chapter 6 for streams; chapters 7–9 for creation, adapters, and lifecycle patterns; chapters 10–11 for testing and advanced runtime; chapters 12–13 for scaling and messaging boundaries.
- Node.js documentation: “Don't Block the Event Loop (or the Worker Pool),” Streams, Asynchronous Context Tracking, Worker Threads, Test Runner, and Security Best Practices.
- Fastify documentation: Validation and Serialization, Encapsulation, Type Providers, and Lifecycle.
- Express documentation: Production Best Practices for Security and Performance and Reliability.

These references provide engineering mechanisms, not a release support matrix or exhaustive framework manual. Inspect the project's actual runtime, dependency versions, and scripts before selecting exact APIs. Use the corresponding official versioned documentation when a change depends on availability, defaults, or detailed semantics.

The Node async-context, worker, and test material includes a v24.20.0 documentation snapshot. It does not establish today's supported release lines or the availability of every API described on floating documentation pages.

Keep refreshes narrow:

- Loader interop, native TypeScript execution, import attributes, conditional exports, and compiler/project configuration: verify the exact runtime/build path.
- Fastify providers/compilers, Express async error forwarding, HTTP shutdown/timeouts, and proxy/cookie settings: verify installed versions and deployment behavior.
- Node test discovery, mocks, coverage, and newer context/worker helpers: verify the individual facility, not just its containing module's stability.
- NestJS and deep TypeScript compiler work require additional task-specific documentation. Their absence here does not exclude ordinary Node/TypeScript backend requests.

Book examples and historical benchmarks are not production pool implementations, reliable transport proofs, security recipes, or portable sizing rules.
