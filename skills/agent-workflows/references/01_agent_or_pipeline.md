# Agent Or Pipeline

## Selection Gate

Start with the least autonomous option that satisfies the contract:

- deterministic pipeline when transitions and inputs are known;
- RAG when the main uncertainty is evidence retrieval;
- single agent when the route or tool choice needs bounded judgment;
- multi-agent only for measured specialization, parallel work, or independent review;
- `$llm-council` only for multi-model deliberation with independent answers and peer review.

Compare latency, reliability, cost, quality ceiling, debuggability, state complexity, and security surface. State why the simpler alternative is insufficient; a framework choice is not evidence.

## Multi-Agent Gate

Run a paired evaluation against a single-agent or pipeline baseline. Account for handoffs, duplicated context, state loss, inconsistent policy, rate limits, and tail latency. If the improvement is not material for the user contract, keep the simpler system.

## Human Control

Use a human decision point where the action is irreversible, high impact, ambiguous, outside policy, or cannot be validated deterministically. A human approval must show the relevant evidence and proposed effect rather than requiring blind confirmation.
