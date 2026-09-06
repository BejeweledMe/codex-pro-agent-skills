# Templates

## Workflow Design

Record: user outcome; selected pattern and rejected simpler option; state machine; role and permission boundaries; tool table; limits; trace fields; evaluation evidence; fallback; rollback; owner; unresolved risks.

## Tool Row

Record: name and version; caller; input/output/error schema; argument provenance; side effect; idempotency; timeout; retry rule; rate/cost cap; policy check; compensation/manual recovery.

## Handoff Row

Record: sender/recipient; task and parent IDs; schema version; minimum payload/evidence; status; deadline; permissions; retry/deduplication behavior; terminal/failure route.

Also record: child postcondition and parent acceptance link; verified facts versus hypotheses; canonical state/checkpoint version; pending effects; remaining budget; next-transition owner; integration rule.

## State Transition Row

Record: task/run/action identity; precondition; authority source and scope; proposed effect; observation reference; evidence and conflicts; invariant/semantic verdict; resulting state; remaining budget; terminal or recovery route.

## Memory Candidate Row

Record: candidate type and exact claim; subject/scope; source locator/version/time; extraction versus inference; evidence status; sensitivity; authorized operation and destination; conflicts and resolution owner; expected current version; proposed commit; superseded record; expiry/revalidation rule; commit outcome.

Use [durable memory and context lifecycle](durable-memory-and-context-lifecycle.md) for the lifecycle. A completed row is a proposal, not permission to persist it.

## Revision Or Branch Row

Record: baseline/candidate identity; localized hypothesis; allowed mutation; preserved invariants; isolated state/session; branch budget; comparison evidence; join or selection rule; restoration procedure and observed restoration result.

## Release Decision Row

Record: attributable bundle; selected candidate and known-good fallback; independent acceptance evidence and uncovered criteria; protected control versions; state compatibility; existing authorization or required decision owner; promotion effect; observed result; rollback conditions.

These are optional formats for existing artifacts, not instructions to create new infrastructure or require every field for every task.
