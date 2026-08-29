# Model Selection

## Start With A Text Task Contract

Define the input and output, language and script coverage, label/evidence source,
cost of false positives and negatives, required explanations or citations, latency and
placement constraints, update cadence, and evaluation slices. Classification, ranking,
sequence labeling, extraction, semantic matching, summarization, and open generation
have different model contracts.

## Model Family Ladder

Use the smallest family that can express the required behavior:

| Need | Candidate baseline | Escalate when |
|---|---|---|
| Fixed patterns, compliance rules, canonical identifiers | Rules, dictionaries, regular expressions | Language variation or ambiguity dominates errors |
| Short text classification with enough labeled features | TF-IDF/count features plus linear model; fastText-style baseline where appropriate | Semantics, context, or multilingual transfer drives errors |
| Exact lexical retrieval or matching | TF-IDF/BM25-style sparse scoring | Paraphrase and semantic similarity are material; for corpus RAG implementation, use `$rag-engineering` |
| Semantic classification, NER, embedding, bi-encoder retrieval | Encoder/BERT-style model | Cross-item interaction, long generation, or reasoning is essential |
| Precise relevance ordering of a bounded candidate set | Cross-encoder or reranker | Candidate generation itself is weak, or pair cost breaks the budget |
| Controlled transformation/generation | Seq2seq or decoder model | Output needs fresh/private facts, tools, or a different product composition |
| Open-ended instruction following or tool-aware generation | Decoder LLM with constrained output and evaluation | The model does not reliably learn the stable domain behavior after simpler paths |

The table narrows candidates; it does not replace an experiment. A sparse method may
outperform a dense one on identifiers, numerals, names, negation, and rare terms.
An encoder is often preferable to a decoder for a discriminative task with a bounded
output space. A cross-encoder can improve ranking only after candidate recall is
adequate.

## Prompt, RAG, Or Weights

Use `$llm-system-design` for the architecture decision. As modeling evidence:

- Prompting/structured validation is the first candidate when the base model already
  has the capability and the behavior is local to the request.
- Retrieval addresses fresh, private, auditable, or access-controlled knowledge; it
  does not reliably teach a stable format or skill.
- Adaptation is a candidate for recurring behavior, domain terminology, format, or
  capability gaps with quality examples and regression tests.
- Training from scratch or changing architecture is exceptional: require a clear
  incompatibility with available models/tokenizers, sufficient data and compute,
  and evidence that adaptation cannot meet the contract.

## Architecture Changes

Before altering attention, layers, vocabulary, heads, modalities, or context
mechanisms, compare an existing model and preprocessing change. State the expected
failure mechanism, compatibility impact, initialization/training plan, conversion or
serving consequence, and an ablation that isolates the change. A custom architecture
without a maintained training/evaluation/runtime path is not a production option.
