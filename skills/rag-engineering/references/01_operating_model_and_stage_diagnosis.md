# Operating Model And Stage Diagnosis

## Start With The Contract

Record what constitutes a supported answer, a required citation, an acceptable abstention, corpus freshness, caller access, and a usable latency/cost envelope. Split representative queries into exact terms/numbers, paraphrases, multi-step questions, no-answer cases, and access-sensitive cases.

## Stage Map

Trace every request through:

`source -> parse/extract -> normalized document -> chunk/metadata -> candidate retrieval -> rerank -> context -> answer/citation`.

Attach source IDs, document and index versions, access-filter verdicts, candidate IDs/scores, selected context IDs, model/prompt version, latency, and cost to the trace. Redact protected text before durable logging.

## Diagnosis Order

1. Confirm the expected source exists, is current, and is visible to this caller.
2. Inspect extraction and normalized text around the expected evidence.
3. Inspect chunk boundaries and metadata/filter behavior.
4. Measure whether the correct chunk enters the candidate pool.
5. If it does, inspect rerank position, context trimming, and citation selection.
6. Only then inspect answer instructions or generation behavior.

The report should name the last stage where evidence was correct and the first transition where it disappeared. Do not infer a cause from final-answer quality alone.

## Baseline And Change Discipline

Keep a simple inspectable retrieval baseline. Compare a proposed component against it on the same cases, configuration, corpus snapshot, and workload class. Change one causal layer at a time; otherwise quality, latency, and cost regressions cannot be attributed.

## Advanced Route Gate

Use GraphRAG only where entity relationships, multi-hop reasoning, or corpus-wide aggregation change the answer contract. Use agentic retrieval only where routing, query decomposition, or evidence verification cannot be fixed in advance. Keep a basic retrieval fallback branch.
