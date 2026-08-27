---
name: technical-analysis-report
description: Structure technical evaluations, benchmarks, experiments, and engineering analyses so conclusions can be checked against methods and results.
---

# Technical Analysis Report

Use this artifact for evaluations, benchmarks, experiments, architecture assessments, and engineering research reports. It should support both a fast conclusion-first read and technical review of the evidence.

## Default structure

Adapt the sections to the task:

1. Summary: conclusion, key evidence, and recommendation.
2. Problem: what is being evaluated and why.
3. Scope and criteria: environment, constraints, targets, and assumptions.
4. Method: data, setup, baselines, protocol, and measurement definitions.
5. Results: measurements and observations.
6. Analysis: interpretation, causes, and implications.
7. Risks and limitations: uncertainty, gaps, and failure modes.
8. Recommendation and next validation or implementation step.

## Evidence discipline

Keep results distinct from interpretation whenever a reader could confuse them. Include the conditions that make a metric meaningful, such as dataset and split, system version, hardware, load, threshold, configuration, or time window. Use tables for comparable measurements and plots when trends or distributions matter more than exact values.

Do not turn the report into a lab notebook. Include failed experiments only when they explain a conclusion, rule out a realistic option, or expose a material risk.
