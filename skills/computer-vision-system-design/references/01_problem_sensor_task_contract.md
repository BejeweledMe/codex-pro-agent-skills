# Problem, Sensor, And Task Contract

Use this reference before selecting a CV formulation or architecture.

## Frame The Real Decision

Record:

- user or operational decision and the action that follows a prediction;
- allowed inputs, required output, abstention/manual-review behavior, and error cost;
- scene variability, target frequency, occlusion, scale, motion, lighting, weather,
  document quality, and other conditions that can change the visible signal;
- capture ownership: camera/source, optics, placement, orientation, exposure, frame
  rate or scan resolution, compression, trigger, timestamp, and metadata;
- deployment constraints: device, connectivity, concurrency, latency, throughput,
  retention, privacy boundary, maintenance access, and fallback.

If the capture process can be changed, compare improving the signal with increasing
model complexity. A better viewpoint, stable lighting, a fiducial, constrained document
placement, or a second sensor can remove ambiguity that no model reliably resolves.

## Choose The Output Contract

| Needed decision | Candidate output | Important qualifier |
|---|---|---|
| Is a condition present? | classification or anomaly score | closed versus open set |
| How much or where on a known object? | regression, geometry, or keypoints | coordinate system and tolerance |
| Which objects and where? | detection | class, box convention, overlap, small objects |
| Which pixels belong together? | semantic, instance, or panoptic mask | boundaries, holes, disconnected regions |
| Which item is this similar to? | embedding and ranking | gallery updates, open set, exact baseline |
| What text or structure is present? | OCR, fields, relations, or document structure | order, layout, language, exactness |
| What persists or happens over time? | tracks, state, event, or action | sampling, identity, temporal window |

Prefer the least expensive output that supports the downstream action. A mask is not
better than a box when the consumer needs only coarse localization; a generative VLM is
not better than a staged OCR pipeline when the contract is fixed extraction.

## Evidence Before Design Commitment

Require representative examples and counterexamples, a simple measurable baseline,
an explicit split unit, target metrics and performance budgets, and an owner for data,
hardware, model, review, and production operation. When these are missing, state
assumptions and propose a cheap capture or feasibility experiment rather than inventing
precision.
