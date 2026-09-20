# Project Phases & Anti-Drift Gates

> **RULE:** An agent or team is **BLOCKED** from advancing to the next phase until the current phase's **Exit Gate Threshold** is satisfied and documented in the table below.

---

## Lifecycle Phase Status

| Phase | Status | Exit Gate Threshold (Evidence Required) | Gate Cleared? | Notes / Links |
|---|---|---|---|---|
| **0. Shape** | planned | `northstar.md` Market Validation Score $\ge 7/10$ + Attack Plan `AP-###` logged in ledger | [ ] | |
| **1. Spec / PRD** | planned | `docs/PRD.md` or `SPEC.md` with testable acceptance criteria + schema definitions + ADRs for irreversible forks | [ ] | |
| **2. Architecture** | planned | Component diagram + failure modes analyzed + storage/caching decisions logged as `DR-###` | [ ] | |
| **3. Plan** | planned | Work partitioned into thin slices (1-2 files per task) with explicit "Done When" verification tests | [ ] | |
| **4. Build / TDD** | planned | Red-Green-Refactor loop followed + 100% passing tests locally + zero placeholder stubs | [ ] | |
| **5. Verify** | planned | Automated test suite passes + numeric benchmarks/constraints meet defined thresholds | [ ] | |
| **6. Review** | planned | Multi-axis code review complete + security audit passed + tactical `DR-###` / lessons `LL-###` logged | [ ] | |
| **7. Ship** | planned | Production build succeeds cleanly + rollback strategy documented in `INDEX.md` | [ ] | |

---

## Phase Transition Threshold Matrix

### Phase 0: Shape $\rightarrow$ Spec Gate
- [ ] `docs/northstar.md` initialized with problem statement and ICP.
- [ ] Market Validation Scorecard evaluated with score $\ge 7/10$ (STOP if $< 7$).
- [ ] At least 2 hard non-goals / anti-scope items recorded.
- [ ] `AP-###` created in `docs/engineering-ledger/attack-plans.md`.

### Phase 1: Spec $\rightarrow$ Architecture / Plan Gate
- [ ] Functional requirements numbered and testable (e.g. FR-01, FR-02).
- [ ] Acceptance criteria specified in Given-When-Then format.
- [ ] Data contracts & schemas defined (Pydantic / TypeScript types).
- [ ] Irreversible architectural decisions authored as formal ADRs in `docs/decisions/`.

### Phase 2: Architecture $\rightarrow$ Plan Gate
- [ ] System topology diagram (SVG / Mermaid / ASCII) showing data flows.
- [ ] Failure modes and resilience strategies analyzed (circuit breakers, timeouts, retries).
- [ ] Datastore, caching, and state management choices justified.

### Phase 3: Plan $\rightarrow$ Build Gate
- [ ] Tasks ordered by dependency into thin, independently testable slices.
- [ ] Every task has an explicit, automated verification command or check.

### Phase 4: Build $\rightarrow$ Verify Gate
- [ ] Unit & integration tests written for all new functionality.
- [ ] Local test runner passes with zero failures.
- [ ] No placeholder stubs, mock data, or TODOs left in production code paths.

### Phase 5: Verify $\rightarrow$ Review Gate
- [ ] Full regression and constraint test suite executes cleanly.
- [ ] Benchmark metrics (latency, throughput, memory, accuracy) meet North Star thresholds.

### Phase 6: Review $\rightarrow$ Ship Gate
- [ ] Multi-axis code review passed (logic, style, edge cases, error handling).
- [ ] Security checks passed (OWASP Top 10, input sanitization, no leaked secrets).
- [ ] Reversible tactical decisions appended to `decisions.md` (DR-###).
- [ ] Lessons learned appended to `lessons.md` (LL-###).

---

## Phase Transition Log
<!-- Record phase transition dates and gate evidence below -->
<!-- Example:
- **2026-09-20**: Phase 0 (Shape) -> Phase 1 (Spec) | Cleared by: Market validation score 8/10, AP-001 created
-->
