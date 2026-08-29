# LLM System Design Template

## Design Frame

- User task and decision/error contract:
- Data, authorization, and retention boundary:
- Workload classes and product latency/cost/token budget:
- Baseline and capability alternatives considered:
- Selected composition and primary owner for every component:
- Model/provider portfolio and routing rules:
- Prompt/context/output contract:
- Fallback and user-visible degradation:
- Release bundle, evaluation, security, operations, and rollback:
- Open assumptions and next discriminating experiment:

## Review Questions

- Does each LLM component solve a measured gap?
- Is one skill/component the unambiguous owner of each detailed decision?
- Can an operator explain what data and version produced a response?
- Does every failure route preserve authorization and policy?
- Is the product budget enforceable before cost or latency becomes uncontrolled?
