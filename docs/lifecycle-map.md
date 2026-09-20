# Lifecycle Map — Craft End-to-End Flow & Anti-Drift Gates

Single source of truth for phase gates, transition thresholds, skill routing, and ledger touchpoints.

---

## Phase Flow

```
Shape → Spec/PRD → Architecture → Plan → Build → Verify → Review → Ship
  ↑________________________ledger read/write every session________________________|
```

| Phase | Entry Condition | Exit Gate Threshold (Evidence) | Primary Skill | Ledger Action |
|---|---|---|---|---|
| **0. Shape** | Idea or feature ask | `northstar.md` Market Validation Score $\ge 7/10$; `AP-###` logged | `product-management` / `interview-me` / `idea-refine` | Create AP-### in `attack-plans.md` |
| **1. Spec / PRD** | Shape gate cleared | `docs/PRD.md` with Gherkin acceptance criteria + schema definitions | `product-management` / `spec-driven-development` | Log tactical choices as DR-### |
| **2. Architecture** | Spec gate cleared | Component topology diagram + failure modes + datastore decisions | `system-design` / `api-design` / `architecture-diagram` | Author ADR in `docs/decisions/` if irreversible |
| **3. Plan** | Spec/Arch cleared | Ordered thin-slice task list with automated "Done When" conditions | `planning-and-task-breakdown` | Link AP-### to task list |
| **4. Build (TDD)** | Plan gate cleared | Red-Green-Refactor loop; 100% tests green; zero placeholder stubs | `incremental-implementation` + `test-driven-development` | Update AP-### progress |
| **5. Debug** | Unexpected error | Root cause isolated and fixed with regression test | `debugging-and-error-recovery` | **Mandatory** LL-### logged |
| **6. Verify** | Build gate cleared | Automated test suite passes; numeric benchmark constraints satisfied | `constraint-driven-development` | Mark gate in `phases.md` |
| **7. Review** | Verify gate cleared | Multi-axis code review passed; security audit clean; zero linter warnings | `code-review-and-quality` + `security-and-hardening` | Update session in `INDEX.md` |
| **8. Ship** | Review gate cleared | Clean production build; rollback strategy recorded in `INDEX.md` | `shipping-and-launch` | Mark phase completed |

---

## Phase Transition Threshold Matrix (Anti-Drift Gates)

An agent or developer is **BLOCKED** from transitioning to the next phase unless the current phase threshold is satisfied:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ 0. SHAPE THRESHOLD: Market Validation Score >= 7/10                         │
│    docs/northstar.md filled. If score < 7, DO NOT BUILD. Pivot or abandon.  │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 1. SPEC THRESHOLD: Testable Functional Requirements & Schemas               │
│    docs/PRD.md with Given-When-Then acceptance criteria & data types.       │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 2. ARCHITECTURE THRESHOLD: Failure Modes & Data Flow Mapped                 │
│    Component diagram + resilience strategies. Irreversible forks -> ADR.    │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 3. PLAN THRESHOLD: Thin Slices with Automated "Done When" Conditions        │
│    1-2 files per slice. Explicit verification commands per task.            │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 4. BUILD THRESHOLD: 100% Passing Tests & Zero Placeholders                  │
│    Test-driven execution. No stubbed mock data in production paths.         │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 5. VERIFY THRESHOLD: Numeric Constraints & Quality Bar Met                  │
│    Benchmark latency, throughput, coverage, and error thresholds verified.  │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │ (Cleared)
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 6. REVIEW & SHIP: Security Audit, Clean Build & Rollback Plan               │
│    OWASP passed, DR/LL logged, production bundle ready to deploy.           │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Domain Skill Overlays

Use these specialized domain skills when executing tasks within their area:

| Work Area | Skill |
|---|---|
| Product & PRD Authoring | `product-management` |
| UI & Modern Layout | `ui-ux-pro-max` + `frontend-ui-engineering` |
| Security & Secrets | `security-and-hardening` |
| API Contracts & Interface | `api-design` + `api-and-interface-design` |
| Distributed Architecture | `system-design`, `caching`, `resilience-failure`, `data-storage` |
| Performance Profiling | `performance-optimization` |
| CI/CD Pipeline | `ci-cd-and-automation` |

---

## Anti-Drift Operating Rules

1. **Verify Phase Thresholds Before Moving**: Never mark a phase done or load the next phase skill without meeting the exit gate criteria in `phases.md`.
2. **One Process Skill Per Phase**: Never stack multiple workflow skills simultaneously (e.g. do not load `interview-me` + `spec-driven-development` + `incremental-implementation`).
3. **Read Ledger First**: Check `docs/engineering-ledger/INDEX.md` and active phase in `phases.md` before taking non-trivial action.
4. **Write Ledger Last**: Append decisions (`DR-###`), lessons (`LL-###`), and session summary to `INDEX.md` before finishing.
5. **No Placeholders in Build**: Build phase is incomplete if stubs or fake placeholders exist.
