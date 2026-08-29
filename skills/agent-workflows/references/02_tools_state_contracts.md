# Tools And State Contracts

## Tool Contract

For every tool define input schema; argument source and provenance; caller identity and permissions; side effect; success and error schemas; timeout; retryability; idempotency key; rate/cost limit; and compensation or manual recovery path. Keep schema and dispatcher versions compatible.

Validate structured payloads twice: first schema/type validity, then domain rules, ranges, ownership, and current state. A syntactically valid request can still target the wrong recipient, amount, record, or environment.

## State

Name a durable owner for task state. Store correlation IDs, step status, input/output references, artifact and policy versions, retry count, and terminal reason. Define checkpoint boundaries and replay semantics before execution.

Useful terminal states include `success`, `failed`, `needs_human_review`, `timeout`, and `cancelled`; add domain states only when they change recovery behavior.

## Retry And Compensation

Retry only errors that are known transient and only inside deadline/budget limits. Never repeat a non-idempotent side effect without confirmation that it did not already succeed. If atomic rollback is impossible, specify the compensating operation and the owner who can perform it.
