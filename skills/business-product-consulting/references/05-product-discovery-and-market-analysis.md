# Product Discovery And Market Analysis

Related: [business thinking](01-business-thinking.md), [MECE issue trees](04-mece-issue-trees.md), [risk](09-risk-and-second-order-effects.md), [product design reference](../../product-design/references/00-index.md)

## Purpose

Product and market analysis asks whether a solution is worth building, for whom, why now and under what constraints. It prevents teams from treating a market, user segment or product bet as a generic feature request.

## Direct Source

The source set provides a communication and problem-structuring layer: SCR/SCQA for framing, Pyramid Principle for synthesis, MECE for segmentation, SPACE/DORA for productivity impact and Team Topologies for organizational feasibility. Cagan's *Вдохновленные* adds practitioner guidance on market sequencing, product marketing, customer partners, business constraints and evidence. Neither the combination nor the book supplies a complete market-analysis methodology; preserve the limits in the [reference index](00_README.md#direct-sources-vs-extensions).

## Extension For Product Development

Use this file as a bridge between consulting structure and product discovery. For deeper UI/UX and discovery methods, use the [product-design reference](../../product-design/references/00-index.md).

## Vision, Strategy, And Product Principles

When direction is the decision, distinguish the artifacts by their purpose. Vision describes a desirable future; strategy chooses a sequence of markets, users, geographies or enabling capabilities; product principles explain recurring tradeoffs; team objectives focus the current result while leaving room to choose a solution. A narrative, storyboard or conceptual prototype can clarify vision, including through code, without establishing demand or production readiness.

Make changing and relatively stable assumptions visible. Distinguish adapting the means from reconsidering the direction; this framework supplies no automatic rule for persistence or abandonment. State what the present focus defers. Principles should explain a specific business/user relationship, not impose a universal priority such as buyers always outranking sellers. Use only the artifacts relevant to the decision.

## Product Discovery Questions

- Who is the user, buyer, operator and blocker?
- What job, pain or desired progress is involved?
- What is the current workaround?
- Why does the current solution fail?
- What triggers urgency?
- What would count as first value?
- What alternatives compete with this solution?
- What adoption friction exists?
- What business model or operational constraint matters?
- Which acquisition, monetization, service or offline fulfillment dependencies are necessary for the proposed value?
- What risk would make the solution unacceptable?

### Business Constraints In The Proposed Experience

When the proposal materially changes a business constraint, connect it to an affected owner and concrete behavior or economics. Relevant checks include channel margins and seller skills, customer-success capacity and service model, cost/revenue assumptions, contracts, brand and applicable legal/security requirements. Review the screens, rules, wording, technical evidence or financial model that expose the concern. Use an existing brief to retain owner, concern, proposed response and unresolved decision; do not form an all-functions approval committee for every change.

Check a potentially decisive constraint early: user enthusiasm cannot make an unsustainable service model viable. A prototype can clarify experience while leaving a contract interpretation or technical property unresolved. Evidence, support and authorization differ; see [validation](../../product-design/references/05-validation-and-assumption-tests.md#не-путать-evidence-и-permission).

### Company Stage And Current Product Bet

For strategy, portfolio or operating-model advice, distinguish searching for fit, scaling a working core and renewing an established product. These can coexist in different areas of one company; use evidence about the bet rather than headcount. Check runway or investment constraints, transfer of distribution capability, infrastructure strain and decision bottlenecks before prescribing delivery capacity or a separate innovation group. A bounded implementation does not require stage diagnosis. For ownership and dependencies, use [team flow](08-team-topologies-fast-flow.md).

## Market Analysis Questions

- Which segment has the strongest pain and ability to adopt?
- What category or substitute does the buyer compare us against?
- Is the market pull strong enough to overcome switching cost?
- What external timing matters: regulation, platform shift, competitor launch, budget cycle, AI capability change?
- What distribution or sales channel is realistic?
- How do opportunity size, access through that channel and rough time to serve the segment compare across entry sequences?
- What evidence of value, adoption and repeat use applies to this segment, and what remains untested before expansion?
- What proof would make the opportunity more credible?
- What would show that the market is not ready?

A smaller reachable market may be a useful first step before a larger market requiring new distribution or capabilities. Compare these factors together without fixed weights or assuming coupled marketplace participants can be served one at a time. Market size and reference logos do not establish product/market fit.

## Product Marketing Partnership

When positioning, channel or launch choices can change the product, involve whoever understands those constraints early enough to influence discovery. Establish how customer and market feedback returns to product decisions. Check whether sales/partner requests or sales-enablement work consume capacity expected to develop the next product; in a consumer business, check whether marketing contributes customer and distribution understanding beyond advertising and brand. A separate product-marketing title is not required.

## Customer Partners And References

For a substantial new product, market or change, a continuing partner group can provide access to relevant users and repeated learning toward a shared solution. Select a coherent target need, confirm time and access to actual users, and distinguish the shared product from paid custom requests. Keep research participation separate from broad early access.

A candidate, a research participant and a satisfied reference customer represent different evidence. In a paid B2B context, a reference should reflect use of the finished product, payment and a voluntary willingness to recommend based on benefit. Establish permission separately before publishing a name or endorsement. For APIs, examine useful applications built; for internal tools, meaningful adoption and support; for B2C, continuing use alongside checks with fresh participants. Adapt evidence to the product rather than forcing a B2B payment rule onto every context.

Define commitments honestly, including conditional purchase and public-reference expectations. Recruitment difficulty warrants examining need, reach, trust and participation cost; it does not by itself prove no demand. Selected partners may be unusually motivated, so success does not automatically transfer to the next segment. Program size follows the learning question and capacity, not a fixed customer count or percentage threshold for fit. Session methods belong to [product research](../../product-design/references/04-user-research-and-interviewing.md).

## A Lightweight Market/Product Memo

```text
Recommendation:
Target segment:
Situation:
Complication:
User pain:
Business value:
Alternatives and competitors:
Adoption friction:
Risks:
Evidence we have:
Evidence we need:
Next decision:
```

For a consequential transition, add only stakeholder impacts needed for the decision: whose economics, channel work, service responsibilities or user expectations change, what supports the response and what remains unresolved. A demonstration can make a proposed whole understandable; aligned executives and a persuasive story do not establish demand, usability or financial safety. Aggregate business benefit can coexist with a loss for users whose preferred way of working disappears.

## Choose Evidence For The Claim

Select a method by the claim, target context and decision it can inform, proportionate to unresolved risk. Stage of implementation is not a ranking of evidential strength.

| Claim or uncertainty | Useful evidence | Limit to retain |
|---|---|---|
| People understand or show interest in the offer | Relevant interviews, an offer or honest demand test | Interest does not establish use, purchase or switching |
| People can complete the task | Observed user tasks with sufficient prototype realism | Assistance, simulation and participant context limit the claim |
| Benefit overcomes switching costs | Current-workflow research and meaningful, authorized commitments | Intention differs from completed migration or purchase |
| People use the product or their outcome changes | Instrumented use, suitable cohort observation or experiment | Selection, exposure and comparison determine transfer and causal inference |
| The approach is technically feasible | Engineering assessment, spike or relevant measurements | A tested property does not prove production readiness |
| The experience fits business constraints | Concrete domain review, operating evidence and economic analysis | Agreement on slides cannot certify untested rules or properties |

Internal views and support/sales signals can reveal questions and constraints; retain their context. Qualitative and quantitative evidence can both generate learning or test a claim. A full release permits observation but does not itself establish causality or product/market fit. Use [assumption-test selection](../../product-design/references/05-validation-and-assumption-tests.md#как-выбирать-assumption-test) for prototypes, exploratory/confirmatory distinctions and exposure safeguards. This mapping is applied synthesis, not a universal method ladder from the book.

## UI/UX Review Through Business Lens

When reviewing UI/UX, do not only check visual quality. Ask:

- Does the interface make the user's decision easier?
- Does it expose the business-critical action clearly?
- Does it reduce cognitive load or push complexity to the user?
- Are error states tied to recovery, not only messages?
- Are metrics instrumented for task success and failure?
- Does the UX create support burden or compliance risk?
- Does it align with the product outcome, not just the design system?

## Red Flags

- "Users" means everyone.
- The solution is described before the problem.
- Market size is used as proof of demand.
- Competitors are ignored because "our UX is better".
- The memo has no adoption friction.
- No one names the buyer or budget owner.
- UI review stops at layout and misses task success.

## Example Prompts

- "Write a product/market memo using SCR and MECE segments."
- "Identify the current workaround and adoption friction for this feature."
- "Review this UI through user value, business value and support burden."
- "What evidence would make this product bet worth building?"
