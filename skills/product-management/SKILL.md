---
name: product-management
description: >-
  End-to-end product management workflow: author structured PRDs, define ICP & Jobs-To-Be-Done,
  prioritize features via RICE/MoSCoW, define North Star and telemetry metrics, and establish
  phase readiness gates. Use when defining product requirements, roadmaps, feature specifications,
  or aligning engineering with product strategy.
---

# Product Management

Turn ambiguous problems into high-clarity, prioritized, and measurable product roadmaps and PRDs.

---

## When to use

- User or team asks to "write a PRD", "define product requirements", "create a roadmap", or "prioritize features".
- Preparing to build a new 0-to-1 product or major feature slice.
- Synthesizing user feedback into concrete capabilities.
- Establishing product success metrics (North Star, inputs/outputs, guardrails).
- Deciding what belongs in MVP vs. fast-follow releases.

## When NOT to use

- System architecture, database schemas, or infrastructure design (use `system-design`).
- Detailed API endpoint shapes and contracts (use `api-design`).
- Code implementation or unit tests (use `incremental-implementation` + `test-driven-development`).
- High-level speculative brainstorming without intent to spec (use `idea-refine` first).

---

## The 6-Step PM Workflow

### 1. Problem Framing & Opportunity
Define the core problem with zero ambiguity:
- **The Pain**: What is broken, slow, expensive, or painful today?
- **The User/ICP**: Who suffers most from this pain? (Role, company size, workflow context).
- **Current Alternatives**: How do they solve it right now? (Spreadsheets, manual labor, competitor X).
- **The "Why Now"**: What market, technological, or regulatory shift makes this urgent?

### 2. Jobs-To-Be-Done (JTBD) & Personas
Formulate target outcomes using the JTBD framework:
> *"When [situation/trigger], I want to [motivation/action], so I can [expected outcome/value]."*

Document at least one primary persona and their constraints (budget, technical fluency, permissions).

### 3. Author the PRD (`docs/PRD.md` or `docs/prds/PRD-###.md`)
Structure the requirements document using the standard schema:

```markdown
# PRD: [Feature / Product Name]

**Status:** Draft | In Review | Approved | Deprecated  
**Target Release:** MVP | v1.0 | Q4  
**Author / PM:** [Name / Agent]  
**Lead Engineer:** [Name / Agent]  

---

## 1. Executive Summary & Problem Statement
[2-3 sentences explaining the what, why, and impact]

## 2. Goals & Success Metrics
- **North Star Metric**: [Primary metric, e.g. Weekly Active Document Extractions]
- **Input Metrics**:
  - [e.g. Processing latency < 2.0s for 95th percentile]
  - [e.g. Extraction field accuracy >= 95%]
- **Guardrail Metrics**:
  - [e.g. Cost per document processed <= $0.02]
  - [e.g. Zero data leakage across customer tenants]

## 3. Non-Goals (Out of Scope)
Explicitly list what we are NOT building in this version:
- [Non-goal 1]
- [Non-goal 2]

## 4. User Journeys & Stories
### Story 1: [User Action]
- **As a:** [Persona]
- **I want to:** [Action]
- **So that:** [Value]
- **Acceptance Criteria (Gherkin format):**
  - **Given:** [Precondition]
  - **When:** [Trigger]
  - **Then:** [Expected Result]

## 5. Functional Requirements (P0 / P1 / P2)
- **[P0 - Must Have for MVP]**:
  - FR-01: [Requirement description with unambiguous testable criteria]
- **[P1 - Fast Follow]**:
  - FR-02: [Requirement description]
- **[P2 - Future Consideration]**:
  - FR-03: [Requirement description]

## 6. Telemetry & Analytics
Events to emit:
- `event_name`, properties, trigger condition.

## 7. Open Questions & Risks
| Risk / Question | Impact | Owner / Mitigation |
|---|---|---|
| [Risk 1] | High | [Mitigation] |
```

### 4. Feature Prioritization Framework (RICE)
When evaluating competing features, calculate the RICE score:

$$\text{RICE Score} = \frac{\text{Reach} \times \text{Impact} \times \text{Confidence}}{\text{Effort}}$$

- **Reach**: Number of users impacted per quarter.
- **Impact**: 3 (Massive), 2 (High), 1 (Medium), 0.5 (Low), 0.25 (Minimal).
- **Confidence**: 100% (High data backing), 80% (Medium), 50% (Low / hunch).
- **Effort**: Person-weeks or story points.

Classify features into **P0** (Must have for release), **P1** (Strong value add, schedule permitting), and **P2** (Nice to have, defer to backlog).

### 5. Roadmap Slicing & Release Strategy
- **Alpha / Slice 1 (Walking Skeleton)**: End-to-end thin slice demonstrating value.
- **Beta / MVP**: Core P0 functional requirements satisfying the primary JTBD.
- **GA (General Availability)**: Hardened, observable, documented, and benchmarked.

### 6. Phase Exit Gate ("Ready for Engineering")
Before handing off to System Design or Architecture:
- [ ] Problem statement validated with concrete user evidence.
- [ ] At least 2 non-goals explicitly listed to prevent scope creep.
- [ ] P0 requirements have Given/When/Then acceptance criteria.
- [ ] Success metrics and telemetry events defined.
- [ ] Attack Plan `AP-###` logged in `docs/engineering-ledger/attack-plans.md`.

---

## Anti-Patterns

| Anti-Pattern | Why it fails | Do this instead |
|---|---|---|
| **Feature Factory** | Building laundry lists of features without validating user pain | Anchor every requirement to a JTBD and success metric |
| **Vague Metrics** | "Make it faster", "improve UX" | Set numeric thresholds: "p95 latency < 500ms" |
| **No Non-Goals** | Scope expands endlessly during engineering | Define at least 3 things we explicitly will NOT build |
| **Hand-wavy Acceptance** | "The table looks good" | Use Given-When-Then criteria with edge cases |
| **All P0s** | Everything marked urgent leads to missed deadlines | Force rank: maximum 3-5 P0 capabilities for an MVP |
