# Documents, OCR, And Multimodal Vision

Use this reference when images contain text, layout, tables, fields, or cross-modal
reasoning.

## Define The Document Output

Separate text detection, recognition, reading order, key-value extraction, relations,
table/layout reconstruction, document parsing, and question answering. They require
different labels and metrics; a plausible transcript can still be structurally wrong.

## Compare Routes

- Deterministic geometry/template route: useful for stable layouts, orientation,
  perspective correction, known fields, and constrained validation.
- Staged OCR pipeline: detect regions, recognize text, reconstruct layout/structure,
  then apply deterministic or NLP extraction. It offers inspectable stages and often
  bounded outputs.
- Encoder-decoder or specialized document model: useful when recognition and structure
  need learned context.
- VLM/generative route: useful when flexible reasoning or varied layouts close a
  measured gap, but it adds resolution/token limits, hallucination, output-validation,
  latency, cost, and language-model evaluation concerns.

Test clean/noisy scans, mobile photos, orientation, glare, blur, small text, scripts and
languages, templates, tables, handwriting, multi-page context, absent fields, and
strict-format cases that matter to production.

## Ownership Boundary

This skill owns the vision encoder/pipeline, document image preparation, visual
adaptation, and task-specific training. Use `$nlp-modeling-and-adaptation` for tokenizer
or text-model changes, `$llm-system-design` for prompt/RAG/agent/provider composition,
and `$agent-llm-evals` for generative answer graders. Use CV evaluation for CER/WER,
field exactness, structure, slice, and end-to-end release evidence.

Never assume OCR text is trustworthy input to downstream rules or an LLM. Preserve
source coordinates/confidence where useful, validate required schemas and values, and
define abstention or review for illegible and unsupported documents.
