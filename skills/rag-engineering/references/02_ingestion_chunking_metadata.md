# Ingestion, Chunking, And Metadata

## Source Inventory

For each source record owner, authority, format, update/delete semantics, effective dates, access class, and whether content is trusted as data but not as instructions. Preserve the original source and its parsing version so an index can be rebuilt and an answer can be audited.

## Extraction Before Chunking

Validate representative hard cases: reading order, headings, tables, lists, footnotes, OCR confidence, numbers, units, negation, and language. Keep page, section, and positional anchors. A clean JSON schema does not prove that the recovered text preserves meaning.

## Chunk Hypotheses

Choose a chunking hypothesis from document structure and answer needs, then evaluate it. Useful alternatives include section-aware, sentence-aware, parent/child, and fixed windows. A chunk should preserve enough local context to be useful while remaining distinguishable and affordable to retrieve.

Measure answer-bearing coverage, duplicate rate, chunk length distribution, context cost, and retrieval metrics by query slice. Do not assume overlap repairs broken source structure.

## Required Metadata

Keep at least stable chunk ID, parent/document ID, source version, title/section/page or offset, timestamps, access attributes, content type, extraction/chunking version, and provenance link. Index and query filters must use the same access vocabulary.

## Updates And Deletion

Build new indexes off-path, validate them against a fixed corpus snapshot, and swap an immutable alias only after verification. A deletion must remove or tombstone all derived chunks, embeddings, cached contexts, and graph edges according to the retention contract. Retain a last-known-good index for rollback.
