# Collection, Lineage, And Coverage

Use this reference to design capture and dataset acceptance.

## Dataset Contract

Define the observation and correlation units. An observation may be an image, crop,
page, frame, clip, or track; correlated examples may share a subject, physical object,
scene, event, camera, site, source, template, session, or time window.

Record source, capture time, device/camera, site, scene, geometry, resolution, codec,
lighting/weather, quality, privacy/rights status, preprocessing history, label source,
and dataset version when they affect sampling, splitting, or diagnosis. Collect only
metadata the system can lawfully and safely retain; assign policy decisions to an owner.

## Coverage Matrix

Design coverage against deployed variation, such as:

- class and negative/unknown cases;
- source, site, device, camera, viewpoint, distance, scale, and image position;
- lighting, season, weather, background, blur, compression, occlusion, and damage;
- document template, language, handwriting/print, page count, orientation, glare, and
  layout complexity;
- video motion, frame rate, clip length, camera motion, crowding, and identity duration.

Do not convert this into a universal checklist. Select dimensions that plausibly change
the signal or error cost, then inspect sparse and missing intersections.

## Lineage And Acceptance

Create a dataset manifest with source and rights owner, collection query or trigger,
deduplication method, filters, annotation-spec version, transform history, split
assignment, checksums or stable IDs, known exclusions, and acceptance results.

Before labeling at scale, verify media readability, schema consistency, near-duplicate
rate, target/negative presence, metadata completeness, and a visual sample from every
important source. Preserve raw and derived identifiers so production failures can be
traced back without silently mutating the dataset.
