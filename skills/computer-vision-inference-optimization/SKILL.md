---
name: computer-vision-inference-optimization
description: Use when profiling, deploying, or optimizing computer-vision inference pipelines for latency, throughput, memory, cost, FPS, or device constraints. Trigger for decode/preprocess/model/postprocess/index stages, tiling, batching, export and runtime compatibility, precision and quantization, streaming video, frame timing, and capacity planning. Not for model training or generic service and SRE ownership.
---

# Computer Vision Inference Optimization

Optimize a measured image, document, retrieval, or video execution path. Freeze the
workload and quality contract, then locate the first bottleneck before changing input
resolution, precision, model, runtime, batching, or topology.

## Core Rules

- Define workload classes by media type, resolution, codec, frame or clip length,
  arrival pattern, concurrency, device, and required output.
- Measure capture/read, decode, color conversion, preprocessing, transfer, model,
  postprocessing, tracking/indexing, serialization, queueing, and end-to-end tails.
- Change the smallest lever tied to the measured bottleneck; lower precision or a
  smaller model does not guarantee lower tail latency or cost.
- Treat transforms, exported graph, runtime, precision, postprocessing, thresholds,
  index/tracker state, hardware, and scheduler as one serving bundle.
- Validate numerical compatibility and task-specific hard slices after every serving
  change, retaining a verified rollback bundle.

## Boundaries And Handoffs

This skill owns CV execution profiling, resolution/tiling, runtime/export compatibility,
runtime precision and quantization, batching, device placement, pipeline capacity, and
serving rollback. Architecture retraining, QAT, pruning-aware training, or distillation
belongs to `$computer-vision-modeling-and-training`; quality acceptance belongs to
`$computer-vision-evaluation`.

Use `$system-design` for APIs, queues, storage, tenancy, and distributed topology;
`$sre-reliability-engineering` for SLOs, incidents, alerts, and on-call. If a VLM trace
localizes the bottleneck to token generation, KV cache, prefill, or decode, use
`$llm-inference-optimization` for that stage.

## Reference Routing

- Read [workload, measurement, and bottlenecks](references/01_workload_measurement_bottlenecks.md)
  for every performance or capacity investigation.
- Read [spatial preprocessing and postprocessing](references/02_spatial_prepostprocess.md)
  for resolution, tiling, batching, geometry, masks, OCR, and retrieval stages.
- Read [runtime, compression, and compatibility](references/03_runtime_compression_compatibility.md)
  for export, precision, quantization, operator support, and validation.
- Read [video, capacity, and release](references/04_video_capacity_release.md) for
  codecs, FPS/PTS, sampling, stateful tracking, overload, rollout, and operations.

## Workflow

1. Freeze representative workload classes and quality/latency/throughput/cost targets.
2. Trace the complete path and name the first saturated or delayed stage.
3. Estimate the resource model and choose one causal optimization hypothesis.
4. Benchmark warm-up, steady state, tails, overload, and task-specific quality on the
   target device and concurrency.
5. Validate compatibility, fallback, telemetry, and rollback before expanding traffic.
6. Hand generic service topology and operational ownership to their primary skills.

## Output

Include workload and quality contract; stage trace; bottleneck evidence; capacity and
memory model; candidate levers and rejected alternatives; benchmark protocol and
results; compatibility and task regression checks; serving bundle; admission,
backpressure, telemetry, rollout, rollback, owner, risks, and next experiment.

## Quality Bar

- Do not diagnose from average model-forward time or a workstation-only benchmark.
- Do not compare runtimes with different preprocessing, outputs, warm-up, batch,
  concurrency, or quality settings without stating the difference.
- Do not claim a quantized or exported model is equivalent without task evidence.
- Do not increase buffering or batching without deadlines, ordering, cancellation,
  overload behavior, and memory limits.
