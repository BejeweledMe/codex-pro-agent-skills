# Streams, Backpressure, and Cancellation

## Choose the Boundary

Use streaming for large, unknown, or continuous input, or when early output matters. A whole-value operation is simpler for a demonstrably small bounded payload. Wrapping an already materialized array in a stream does not recover its memory.

Declare byte versus object mode, encoding/framing, ordering, maximum record size, and ownership of source and destination. Duplex sides can have different modes and buffering.

## Preserve Backpressure End to End

- When `writable.write(chunk)` returns `false`, stop writing until `drain`, while also handling error, close, and cancellation.
- When a custom readable's `push(chunk)` returns `false`, stop producing until the stream requests more through its readable lifecycle. Readables do not use writable `drain` as their resume signal.
- Complete each transform callback exactly once. Do not acknowledge input and launch unlimited detached async work behind it.
- Use `pipeline()` for an operation whose stages should share terminal error/completion handling. A chain of `pipe()` calls alone does not own all failure cleanup.
- With async iteration, preserve lazy pulling and implement early-stop cleanup. Parallel processing requires a separate bounded policy.

`highWaterMark` is a coordination threshold, not a hard memory limit. Its units depend on mode; object counts do not bound object byte size.

Inspect the whole working set: source prefetch, each readable/writable side, parser tails, executing tasks, ordered-result buffers, branch queues, retained output, and external buffers. Increasing a threshold before locating the growing queue can worsen the failure.

## Decode and Frame Across Arbitrary Chunks

Never assume one chunk equals one UTF-8 character, line, JSON value, or protocol frame. Per-chunk `toString()` can corrupt a split multibyte character.

A writable’s `defaultEncoding` does not decode Buffer input into text. Use a stateful decoder and a framer that retain only the unfinished tail. Enforce the maximum frame/record size while accumulating, before parsing an arbitrarily large value. On finalization, flush the decoder and explicitly accept or reject an incomplete final record according to the format.

For multiplexed input, validate channel identity, length, and framing before dispatch. Track per-channel flow and shutdown; freely interleaving binary chunks is not a valid protocol.

Verify with artificial splits within multibyte characters, delimiters, headers, and length fields. Include malformed/truncated input and oversized records. Correct output on a single large chunk does not exercise framing.

## Choose Topology Deliberately

| Topology | Constraint | Diagnostic and correction |
| --- | --- | --- |
| Sequential transforms | Each stage controls progress to the next | A hang suggests missing callback/end, stalled I/O, or unhandled cancellation; inspect stage state. |
| Unordered concurrent work | Output order may differ | Bound active tasks and result retention; verify consumers permit reordering. |
| Ordered concurrent work | Slow early work blocks later output | Measure reorder bytes and oldest pending item; bound the reorder window or reduce concurrency. |
| Fork | Required branches propagate the slowest consumer's pressure | Inspect each branch; any lossy/disconnected branch needs an explicit contract. Shared mutable chunks can corrupt siblings. |
| Merge | One coordinator owns final destination end | Prevent individual producers ending the shared sink; verify failure and completion of every input. |

Do not use higher concurrency to conceal a slow sink. Moving CPU transforms to workers still requires bounded submission and return buffers.

## Own Failure and Partial Output

The Promise form of `pipeline()` exposes a Promise outcome; the callback form reports through its callback. Preserve one completion model. `compose()` supplies a composed Duplex interface; its creation is not proof of terminal completion. `finished()` can observe a stream when restructuring into a pipeline is unsuitable. Check the target version for these APIs, signal support, adapters, helper methods, and cleanup details.

Cancellation must reach source acquisition, custom stages, and downstream work. A signal passed to the outer pipeline cannot automatically cancel a dependency that ignores it. Close cursors, files, sockets, and iterator resources on early exit.

Pipeline failure may destroy participating streams, including an HTTP connection. Decide before streaming whether an error can still become a normal response. Once output is committed, do not append a second JSON error response; use the established transport termination policy and retain server-side evidence.

Distinguish:

- `end`: readable data has been consumed to its end.
- `finish`: the writable has completed its writable processing.
- `close`: an underlying resource has closed; inspect whether completion or error preceded it.
- Durable effect: the relevant storage or domain acknowledgment has occurred.

None of these stream events alone proves `fsync`, transaction commit, successful publication, or remote receipt. If failure leaves partial output, identify its owner and the agreed cleanup/publication boundary. Use the database or data owner where durable completion needs additional proof.

## Focused Evidence

For a stream change, choose checks that exercise its risk:

- Slow sink: queue counts/bytes and memory stabilize within the declared workload envelope.
- Split input: decoded records match the format, including tail handling.
- Stage error or client abort: all participating resources settle and close.
- Ordered concurrency: the earliest stalled item cannot create unbounded retained output.
- Partial completion: downstream state matches the documented failure policy.

Record stage latency, buffered bytes or object counts, outstanding tasks, largest tail, cancellation, and terminal state. Keep payloads out of routine diagnostic logs.

Sources: *Node.js Design Patterns*, fourth edition, chapter 6; Node.js Streams documentation.
