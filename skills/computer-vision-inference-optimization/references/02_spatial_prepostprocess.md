# Spatial Preprocessing And Postprocessing

Use this reference when pixels, resolution, geometry, or downstream stages dominate the
path.

## Preserve The Input Contract

Make orientation, color order/space, alpha handling, bit depth, resize interpolation,
aspect policy, normalization, crop coordinates, padding, and tensor layout identical to
the verified training/evaluation route. Record differences introduced by camera SDKs,
mobile codecs, PDF renderers, or runtime libraries.

Avoid repeated decode, color conversion, layout conversion, allocation, host/device
copy, or per-item synchronization. Optimize these only after tracing shows material
cost and retain correctness fixtures for representative media.

## Resolution And Tiling

Compare native input, downscale, crop/ROI, coarse-to-fine scan, and tiles with declared
overlap and stitching. Measure lost context, small-detail recall, seam duplicates,
boundary/mask errors, number of model calls, memory, and tail latency. Dynamic shapes may
reduce padding or preserve detail but can affect compilation, batching, and operator
support.

## Postprocessing And Multi-Stage Paths

Profile NMS/matching, mask resize/stitch/morphology, coordinate conversion, OCR region
sorting/recognition, retrieval index search/reranking, and tracker association/state.
Large candidate counts can move the bottleneck out of the model. Bound outputs and
define empty, excessive, invalid, and timeout behavior.

Batch only compatible shapes/routes or use a documented padding/bucketing policy. State
how batching changes deadlines, ordering, memory, and per-request fairness. Cache only
stable and correctly keyed artifacts; include model/transform/index versions in keys.

After any pre/postprocess change, rerun task metrics, visual errors, calibration or
threshold evidence, and end-to-end compatibility through `$computer-vision-evaluation`.
