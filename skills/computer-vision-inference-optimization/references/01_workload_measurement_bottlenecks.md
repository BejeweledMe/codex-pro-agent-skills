# Workload, Measurement, And Bottlenecks

Use this reference before selecting an optimization.

## Freeze Workload Classes

For each class record media format, resolution, channels/bit depth, codec, image/page/
frame/clip count, nominal and timestamp-derived rate, arrival pattern, batchability,
concurrency, device/runtime, required outputs, model route, and quality constraints.
Separate interactive, batch, stream, edge, cold-start, and burst workloads when their
contracts differ.

## Trace The Complete Path

Measure distributions and tails for:

`read/capture -> decode -> orient/colorspace -> resize/crop/tile -> host/device transfer
-> queue/batch -> model -> NMS/mask/OCR/tracker/index -> serialize/store/network`

Include warm-up, steady state, synchronization, memory peaks, allocation/copies, errors,
cancellation, drops, queue age, and cost. Asynchronous accelerator work must be
synchronized correctly for timing; end-to-end and stage timings should reconcile.

## Form A Causal Hypothesis

Name the first saturated or delayed stage and the resource it consumes. Useful evidence
includes CPU/GPU utilization, memory bandwidth/capacity, transfer time, queueing,
operator traces, batch occupancy, decoder throughput, postprocess scaling, index recall/
latency, and downstream backpressure.

Change one lever tied to that evidence. Examples include capture policy, faster decode,
copy/layout removal, resolution/tiling, batching, smaller route, graph/runtime export,
precision, postprocess, index parameters, or placement. Measure on the same workload and
quality contract; otherwise label the comparison as non-equivalent.

## Benchmark Record

Save hardware and power mode, software/runtime/driver versions, artifact hashes,
precision, transforms, thread/stream settings, warm-up, repetitions, concurrency,
input distribution, stage and end-to-end percentiles, throughput, memory, cost, quality
results, and raw trace location.
