# Runtime, Compression, And Compatibility

Use this reference after profiling identifies model execution, memory, or artifact
placement as a bottleneck.

## Export And Runtime Choice

Capture source framework/model, exported graph, opset or conversion settings, dynamic
shape policy, custom operators/plugins, preprocessing placement, postprocessing, runtime
version, device, drivers, and precision. Test conversion on a fixture set before
benchmarking; successful export does not prove numerical or behavioral compatibility.

Choose a runtime from target-device support, operator coverage, shape behavior,
debuggability, packaging, upgrade path, and measured workload results. Treat named
runtimes as candidates, not universally current recommendations.

## Compression Levers

- Lower runtime precision or post-training quantization: validate calibration data,
  unsupported/fallback operators, output drift, memory, and actual latency.
- Quantization-aware training, pruning-aware training, or distillation: hand the training
  design to `$computer-vision-modeling-and-training`, then evaluate the resulting bundle.
- Smaller input/model/route: check the target failure slices, not just average score.
- Embedding dimension or index quantization: compare exact/uncompressed quality and
  search cost before attributing a gain.

Do not prescribe a universal bit width, calibration size, sparsity, or expected speedup.
Hardware kernels, memory traffic, operator fallback, batching, and postprocessing can
erase a theoretical gain.

Inspect the representation and dispatch actually used: dense versus supported
structured/sparse layout, packed precision, scale/index metadata, dequantization,
conversion, transfer and fallback operators. A tensor with many zeros may still
run the same dense kernel; sparse metadata can exceed saved value bytes; unsupported
shapes may silently choose a slower path. Verify the emitted graph and operator
trace before attributing a speedup to nominal sparsity or bit width.

Training-time transformation and recoverable execution use
`$computer-vision-modeling-and-training` and, where needed,
`$neural-training-systems`; this owner accepts the exported target runtime path.

## Compatibility Gate

Compare source and candidate outputs on normal, hard, empty, boundary, high-cardinality,
and numerically sensitive cases. Run task metrics and visual review, threshold/calibration
checks where relevant, deterministic schema/shape tests, target-device performance,
overload behavior, and rollback. Version the runtime artifact with transforms and
postprocessing rather than releasing it as an isolated file.
