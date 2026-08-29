# Measurement And Diagnosis

## Workload Classes

Segment measurements by the behavior users experience: interactive short prompts,
long-context analysis, long generation, structured output/tool use, batch jobs,
priority tenants, and cancellation-heavy traffic. Record input, context, and output
token distributions, concurrency, arrival pattern, streaming, cacheability, and
completion criteria. A single average request hides the capacity contract.

## Trace The Critical Path

Measure admission/queue delay, tokenization or preprocessing, prefill and time to
first token (TTFT), decode/inter-token rate, streaming/network, validation, and
downstream work. Report P50/P95/P99 and error/cancel rates by workload class. A useful
approximation for a streaming response is `end-to-end ~= TTFT + completion_tokens /
decode_rate`, but telemetry is needed to locate the actual delay.

## Causal Diagnosis

Classify the first binding stage: queue/admission, compute-bound prefill,
memory/KV-bound decode, batch composition/fairness, serialization/network, or a
non-model dependency. Capture GPU/accelerator compute and memory-bandwidth signals,
allocated/reserved memory, KV occupancy/evictions, active sequences, rejected/OOM
requests, scheduler events, and token counts.

Change one relevant mechanism at a time and retain a baseline. A low utilization
number alone does not prove spare capacity; it may coexist with queueing, a serialized
dependency, memory pressure, or a scheduler constraint.
