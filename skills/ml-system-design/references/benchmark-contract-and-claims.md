# Benchmark Contract and Claims

Related: [metrics](05_metrics_losses.md), [validation](07_validation_leakage_splits.md),
[serving](14_serving_inference_optimization.md),
[device placement](deployment-placement-and-device-envelope.md)

Use this reference to define or assess a performance comparison, vendor claim,
optimization result or target-device benchmark. The contract below is optional
reusable context; a bounded benchmark does not require the complete ML design
workflow.

## Define the Decision and Comparable Conditions

State what the measurement can decide: whether a candidate meets a deadline,
delivers more valid work at an acceptable cost, reaches a quality target sooner,
or fits a deployment envelope. Distinguish:

- model evaluation on a specified population;
- system acceptance, including runtime, integration and recovery;
- a benchmark claim under controlled, declared conditions.

A fast component cannot establish the other two. Preserve a baseline and change
one intended factor where attribution matters. If several factors change,
compare the complete configurations without assigning the gain to one factor.

Use this compact worksheet when fields would otherwise be ambiguous:

| Contract field | Evidence to record |
| --- | --- |
| Decision and workload | Task, population, arrival pattern, shapes, batch/concurrency, input sizes and duration |
| Quality equivalence | Common task/data/split, metric implementation, quality floor, critical slices, calibration and coverage requirements |
| Executable candidate | Model and fitted transforms, thresholds/postprocessing, export, actual precision/sparsity and fallback paths |
| Target | Exact device/SKU or deployment class, topology when relevant, runtime/compiler/driver versions and resource limits |
| Boundary | Start/end events; included queue, feature access, preprocessing, transfers, execution, postprocessing and downstream work |
| Run conditions | Cold/warm state, residency/cache assumptions, warmup, repetition/order, background load, power/thermal state and sustained duration |
| Results | Units, distributions/tails, throughput at declared constraints, failures/rejects, sample counts, variation/uncertainty and exclusions |

A common accuracy floor is necessary for many speed comparisons but does not
establish equivalent task semantics, dataset coverage, preprocessing or input
residency. Report quality differences rather than hiding them behind a pass flag.

## Match the Scenario to the Claim

These scenario names identify useful workload distinctions. Formal benchmark
conformance additionally requires the applicable suite/version rules.

| Scenario | Workload shape | Evidence and limit |
| --- | --- | --- |
| SingleStream | Sequential queries, with one outstanding query at a time | Per-query latency, cold/warm behavior and energy; does not establish concurrent serving capacity |
| MultiStream | Multiple samples/streams issued together per query | Joint completion latency, deadline misses and jitter; mean QPS hides coordinated deadline failures |
| Server | Independent arrivals with a declared stochastic/load process | Sustainable throughput at tail constraints, queue growth, rejects and overload behavior; also check representative bursts |
| Offline | Inputs available before execution | Sustained throughput for the declared batch/data path; does not establish interactive response latency |

Use modality-specific execution owners for streaming LLM or CV measurement.
Training benchmarks compare time-to-quality under fixed data, preprocessing
and acceptance semantics, including convergence variability and relevant
recovery overhead. Unconstrained samples/second can reward faster progress
toward a worse model.

## Measure from the Product Boundary Inward

1. Reproduce the relevant end-to-end symptom or baseline on representative inputs.
2. Use stage and component measurements to locate the binding mechanism.
3. Verify that the actual exported representation and operators execute as assumed.
4. Change the candidate, then remeasure the whole boundary and quality gates.

For asynchronous execution, time completed work at the declared boundary;
submission latency alone can omit device execution. State warmup and cache
residency rather than comparing a warm candidate to a cold baseline.

Report offered load, accepted work, useful completions, errors, rejects,
cancellations and fallback outcomes separately. When correctness is only
available through delayed labels, distinguish measured deadline completions
from quality estimates and later outcome evidence.

Repeat enough to characterize decision-relevant variation. Record request and
independent-run counts, order/seeds when relevant, uncertainty method and outlier
rules. Tail estimates from small samples are weak evidence; correlated samples
must not be presented as independent repetitions. Do not select only the best run.

## Units and Quantitative Hygiene

- Separate operations from operations/second. Declare MAC, scalar FLOP and FMA
  counting conventions.
- Declare precision, dense versus sparse execution, and actual supported dispatch.
  Compare hardware peaks only under matched conventions; peak is not sustained
  application performance.
- Distinguish GB from GiB, bytes/s from bits/s, and per-link from aggregate or
  bidirectional bandwidth.
- Do not multiply local speedups. Serial work, interacting optimizations and a
  moved bottleneck require an end-to-end measurement.
- Do not derive replica counts or tail latency directly from Little's Law.
  Its consistent-boundary, stable-average relationship is not a capacity model.
- Normalize cost and energy to a declared functional unit and quality envelope.
  Include retries, idle/reserve capacity and other costs inside the chosen
  boundary; distinguish an efficiency gain from realized savings.

For energy, report watts and joules per completed functional unit where useful.
State whether measurement covers chip, device/SoC, host/node or facility and
whether transfer, memory, idle, wakeup and retries are included. TDP does not
measure workload energy.

## Physical Models as Conditional Hypotheses

Use simple models only when they clarify a measured bottleneck:

- With operations `O`, bytes actually moved `D`, effective bandwidth `BW`
  at the relevant memory level and precision/dispatch-matched peak `R_peak`,
  arithmetic intensity is `I = O / D`. Roofline estimates the ceiling
  `R <= min(R_peak, I × BW)` for that region; it excludes queue, host, network
  and other work outside the boundary.
- For a fixed serial path with fraction `p` accelerated by `G` and all other
  work unchanged, Amdahl gives `speedup = 1 / ((1 - p) + p / G)`.
  With changed shapes, overlap, batching or contention, remeasure instead of
  multiplying stage gains.
- Movement, compute and serial overhead add when sequential; a max-term
  approximation requires real sustained overlap. An asynchronous API alone
  does not demonstrate overlap.

These are assumption-bound models, not portable accelerator constants or
simulators of a whole service. Pass detailed training traces to the training
owner, target execution to inference, and physical capacity/topology to AI
platform. Verify the resulting end-to-end claim and relevant quality.

## Sustained Device Evidence

For edge/mobile or thermally constrained deployment, measure representative
device tiers under cold start and sustained operation. Record ambient/thermal
conditions, battery/power mode, concurrent foreground work, duty cycle, peak
memory and runtime/delegate behavior.

Compare early burst performance with behavior after temperature, memory and
background contention stabilize. Include the task's realistic duration and
recovery after interruption. A short cool-device run cannot support a sustained
latency, battery-life or deadline claim.

## Failure-to-Action Guide

| Observation | Next evidence | Decision |
| --- | --- | --- |
| Smaller/quantized artifact is not faster | Executed operators, conversion/metadata overhead, shape and whole-path trace | Retain only if the intended storage/memory/performance benefit is measured and quality passes |
| Offline throughput is good but server tails fail | Arrival mix, queue, cache misses, cold paths and overload | Rework the serving configuration or placement; repeat the appropriate scenario |
| Device is fast initially and slows during use | Thermal, battery/power, foreground contention and sustained state | Revise device tier, duty cycle, candidate or fallback; verify sustained behavior |
| Two claims disagree | Quality, operation convention, precision, boundary, residency and units | Reconcile conditions or report them as incomparable; do not average incompatible claims |
| Gain appears only on one run or selected slice | Repetitions, selection process and affected population | Narrow the claim or collect sufficient representative evidence |

ML owns benchmark validity and quality interpretation. Training and inference
owners execute their phase-specific protocols; AI platform owns fleet capacity
and infrastructure comparisons; business owners decide whether measured
improvements yield realizable value.

Source basis: *Machine Learning Systems, Volume I* on benchmarking, deployment
and quantitative hygiene; *Volume II* on workload contracts, performance and
fleet measurement. These sources do not establish current hardware peaks,
prices, runtime support, formal benchmark rules or carbon totals. Conflicting
hardware tables must not be normalized by choosing a convenient value; refresh
the specific primary evidence needed for a current claim.
