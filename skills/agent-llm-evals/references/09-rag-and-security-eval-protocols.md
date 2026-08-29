# RAG And Security Evaluation Protocols

## RAG Evaluation Boundary

Do not reduce RAG quality to a final-answer judge. Obtain from `$rag-engineering` the answer contract, corpus/index version, query slices, expected evidence, and stage trace fields. Measure extraction/index health, candidate retrieval, reranking/context, citation/grounding, abstention, access correctness, final task result, tail latency, and cost at the level justified by the task.

Use deterministic evidence and access checks where possible. A final answer can be acceptable through several valid paths, but a permission, provenance, or required citation contract may require path-level grading.

## Authorized Security Evaluation Boundary

Before running adversarial cases, obtain an approved controlled-system scope, isolation, permitted test accounts/data, caps, stop path, and policy slices from `$genai-security-testing`. If these are missing, produce `not run` with a plan rather than executing the test.

Run paired slices on the same versioned bundle: approved adversarial cases, benign cases, allowed-sensitive cases where relevant, and policy-disallowed cases. Capture access result, policy verdict, tool/state effect, trace, latency, cost, and human-review evidence. The security skill owns what is safe and authorized to test; this skill owns reproducibility, graders, calibration, regression, and release placement.

## Release Evidence

For a change to model, prompt, index, policy, tool schema, workflow, or runtime, distinguish capability from regression results and disaggregate them by critical slice. Calibrate LLM judges against human labels before a blocking use. Connect every threshold to an owner-defined risk and a rollback action.
