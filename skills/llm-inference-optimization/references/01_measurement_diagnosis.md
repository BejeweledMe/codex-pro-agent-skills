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
downstream work. Report P50/P95/P99 and error/cancel rates by workload class, replica,
and cold/warm state where relevant. Correlate client and server traces; separate
load-generator waiting, gateway waiting, engine admission, and scheduler waiting.
TTFT includes more than prefill.

For a completed response with `N >= 2` output tokens, define client-side mean TPOT as
`(last_token_time - first_token_time) / (N - 1)`. Then, at the same client boundary,
`end-to-end = TTFT + (N - 1) * TPOT + completion_tail`, where the tail includes work
between the last token and the declared completion event. Use observed spans for
zero/one-token responses. Streaming chunks may contain multiple tokens; do not label
chunk-arrival gaps as per-token ITL without explaining the measurement method.
Do not add stage percentiles to derive an end-to-end percentile.

## Metric Contract And Denominators

Record the metric's start/end events, population, unit, aggregation, and exclusions.
Pin tool/runtime versions when mapping their metric names to these definitions.

| Metric | Interpretation and required distinction |
|---|---|
| Queue depth/age | Name the queue; report waiting requests, predicted work, and oldest or age-distribution evidence by class. Completion-only latency misses requests still waiting. |
| Prefill time/rate | Measure prompt processing separately from queueing. State whether token counts include cached prompt tokens or only newly computed tokens. |
| Decode time/rate | Separate per-request generation rate from aggregate generated tokens per wall-clock second. Record active sequences and batch composition. |
| TTFT | Declare the request-start boundary and first content-token event. Requests with no token remain visible in outcome counts. |
| ITL/TPOT | ITL describes token-gap behavior; mean TPOT summarizes a response. State whether percentiles weight token gaps, requests, or duration. |
| End-to-end latency | End at the declared usable completion, including required validation/downstream work. Also report failed, cancelled, and incomplete requests. |
| Active/effective throughput | Declare the timing window. An active-phase rate excludes idle periods; a whole-window effective rate includes them. Neither is automatically a user's token rate. |
| Errors/rejects/cancellations | Report counts and denominators at the relevant boundary, with class and reason. A failure-only latency distribution describes failures, not the entire request population. |

For benchmark accounting, distinguish logical requests from execution attempts.
Record offered, admitted, completed, rejected, failed, cancelled, and still-in-flight
work. For an arrival cohort, account for every request through a terminal outcome or
an explicit unfinished state. For interval counters, retain the beginning/end
in-flight counts rather than assuming arrivals equal completions.

Report admission rejection fraction against offered attempts and admitted execution
failure fraction against admitted attempts, with deadlines and cancellation reasons
separate. Deduplicate retries when reporting user outcomes; retain attempt counts
when estimating consumed capacity. Keep semantic failures visible even when transport
and execution succeeded.

In endpoint load tests, compare scheduled issue time with actual submission time.
A concurrency-limited client can reduce offered demand as the server slows, hiding
queueing through coordinated omission. Include client waiting in the corresponding
effective latency and report the achieved arrival process. AI Perf's Active,
Effective, and error-only metrics require their documented version-specific
definitions; similarly named metrics from another tool may use different boundaries.

## Class-Specific Serving Goodput

For workload class `k`, define:

`G_k = completed logical requests satisfying latency, quality, and policy / elapsed time`.

Use a fixed measurement window and the class's explicit completion contract. A
streaming class may require TTFT, token-gap, and completion-deadline bounds together.
Batch work can have a different deadline. A refusal qualifies only when it is a
correct outcome under that request's contract.

Keep offered load, admission rate, raw requests/s, input/output tokens/s, and unmet
demand alongside goodput. Higher aggregate token throughput can conceal starvation
of interactive or priority traffic. Rejecting difficult requests does not establish
capacity for the offered mix.

Use the behavior gate supplied by the evaluation owner. If quality or policy is
sampled or delayed, label goodput as estimated or pending, report coverage and
uncertainty by slice, and retain the unresolved outcomes. Multiplying throughput by
an unrelated aggregate accuracy score does not measure joint success.

For cost or energy per valid completion, divide the stated measurement-boundary
total by valid completions from the corresponding workload/window. Include idle,
failed, retried, and fallback work within that boundary; report an undefined ratio
when there are no valid completions.

## Causal Diagnosis

Classify the first binding stage: queue/admission, compute-bound prefill,
memory/KV-bound decode, batch composition/fairness, serialization/network, or a
non-model dependency. Capture GPU/accelerator compute and memory-bandwidth signals,
allocated/reserved memory, KV occupancy/evictions, active sequences, rejected/OOM
requests, scheduler events, and token counts.

Change one relevant mechanism at a time and retain a baseline. A low utilization
number alone does not prove spare capacity; it may coexist with queueing, a serialized
dependency, memory pressure, or a scheduler constraint.

| Observed symptom | Evidence that distinguishes causes | Action and verification |
|---|---|---|
| Tokens/s rises while interactive P99 worsens | Queue age by class, token budgets, prefill interference, preemptions, and class goodput | Reduce the binding wait/work budget or adjust fairness; verify short-request recovery without unbounded starvation elsewhere. |
| Low compute and slow decode | Weight/KV bandwidth, host/tokenizer gaps, active sequences, and kernel timeline | Address measured state movement, host starvation, or dispatch; confirm decode and whole-path gains. |
| Weights fit but long concurrent work OOMs | Per-rank allocated/reserved/peak memory, KV growth, fragmentation, workspace peaks | Apply measured state admission and capacity changes; verify long-context bursts and cancellation release. |
| Full queue with idle devices | Engine wait reason, viable replica shape, per-rank readiness, and platform placement evidence | Distinguish a stalled engine from unavailable compatible placement; pass the latter to AI platform and verify a ready replica accepts work. |
| Smaller artifact has no serving gain | Executed precision/sparsity, fallback/conversion, transfer time, and phase share | Repair the supported execution path or retain the baseline; compare class goodput at equal quality. |
| More replicas do not restore tails | Offered work/retries, scale timeline, queue ages, low-load service floor, downstream spans | Bound overload and locate the remaining cause before requesting further scaling. |

## First-Order Models And Phase Evidence

Use these models to choose the next measurement:

| Model | Mechanism and applicability |
|---|---|
| Sequential decomposition | `T ~= D/BW + O/R + L_serial` for non-overlapping movement, compute, and residual serial work. `D` is actual bytes moved; `O` is operations; `R` is achieved compute rate (or a precision/path-specific peak times explicitly estimated efficiency). Avoid counting the same stalls in multiple terms. |
| Overlapped pipeline | A steady-state stage time can approach `max(T_move, T_compute, T_transfer) + L_serial` only for work whose overlap is supported by timelines. Dependencies, fill/drain, shared resources, and request tails can prevent that bound from being reached. |
| Roofline | `R_attainable <= min(R_peak, I * BW)`, with `I = O/D`, bounds a phase/kernel using matching precision, dense/sparse convention, operation convention, and memory level. It excludes queueing and unrelated host/network work. |
| Amdahl | `speedup = 1 / ((1-p) + p/G)` for an otherwise unchanged sequential path whose original fraction `p` is sped up by `G`. Queued, batched, or overlapping service needs remeasurement rather than a direct tail/goodput prediction. |

Distinguish sustained bandwidth from advertised peaks and GB/s from Gb/s. Include
dispatch, launch, format/metadata decoding, copies, and exposed communication.
Long-prompt prefill is often compute-heavy; low-batch decode is often weight/KV
bandwidth or dispatch sensitive. Architecture, shape, context, and batch can change
the regime. Batching may amortize weight reads across sequences while per-sequence
KV traffic persists; measure actual traffic at the relevant memory level.

Under model parallelism, trace each rank's memory, compute, communication, and waiting
time alongside the replica critical path. A slow rank or exposed collective can
dominate a request while aggregate utilization looks healthy. Nominal asynchronous
APIs do not establish useful overlap. Reprofile composed optimizations; do not
multiply isolated speedups.

For a capacity claim, sweep representative offered load and length mix on the exact
bundle/topology. Record class goodput, tails, queues, KV state, failures, and recovery
after overload. Keep cold-start and sustained warm results distinct. A fixed-
concurrency or offline maximum-throughput result alone does not establish capacity
under bursty independent arrivals. Report duration, sample counts, repeated-run
variation, and exclusions sufficient to assess the claim.

Match the scenario to the claim: SingleStream establishes sequential-request latency;
MultiStream covers synchronized streams with joint deadlines and jitter; Server
exercises independent arrivals and throughput under tail constraints; Offline
measures sustained processing with inputs already available. Interactive streaming
adds TTFT, token-gap, completion, and state constraints. Neither offline nor
single-stream results establish concurrent interactive capacity. Use representative
burst evidence when the deployment claim includes bursts.

A useful claim names the metric, artifact and quality floor, target stack, scenario,
length/arrival/batch regime, timing boundary, warmup/duration, and uncertainty. Include
background contention and sustained thermal/power conditions for hardware claims.
One capacity calculation must use the same measured service curve and batching
regime throughout; do not combine single-request latency with batch-N throughput.
The shared benchmark worksheet in `$ml-system-design` can help cross-system
comparisons; this local procedure is sufficient for a bounded runtime experiment.
