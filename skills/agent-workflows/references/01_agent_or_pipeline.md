# Agent Or Pipeline

## Selection Gate

Product-level prompt/RAG/agent/adaptation composition belongs to `$llm-system-design`. Use this gate to keep the chosen execution workflow no more autonomous than its task requires; RAG and councils are alternatives for particular needs, not mandatory rungs to traverse.

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

Use a human decision point when the action requires authority not already granted, or when its impact, uncertainty, or reversibility calls for review under the task policy. Present the concrete proposed effect and relevant evidence. Lack of a deterministic verifier calls for appropriate semantic evidence or review, not automatic approval for routine work.

Preserve already granted authority within its scope. Reading, searching, proposing, durable writing, disclosure, deletion, and production promotion are distinct effects: check which are covered before crossing their boundaries. Evidence that an action can succeed does not grant permission to execute it.
