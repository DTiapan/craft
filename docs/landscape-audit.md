# Landscape audit — Craft v0.1

**Date:** 2026-09-13  
**Purpose:** Map existing skill packs, identify gaps Craft must own, lock reference-only dependency strategy.

---

## Executive summary

Craft should **not** duplicate implementation workflows. It owns:

1. **Router** (`using-craft`) — phase → one external skill name
2. **Memory** (`engineering-ledger`) — running narrative, DR/AP/LL
3. **Adopt** (`craft-adopt`) — bootstrap projects
4. **Promote** (`craft-promote`) — universal lessons → Craft-native skills

Everything else references upstream packs installed locally via `npx skills add`.

---

## Installed inventory (this machine)

### addyosmani/agent-skills (+ extensions)

**Path:** `~/.agents/skills/` (45 skill directories)

Core lifecycle skills (router targets):

| Skill | Role |
|-------|------|
| `interview-me` | Extract intent when underspecified |
| `idea-refine` | Diverge/converge on vague concepts |
| `spec-driven-development` | SPEC before code |
| `documentation-and-adrs` | Formal ADRs |
| `domain-modeling` | Ubiquitous language, CONTEXT.md |
| `codebase-design` | Module seams |
| `planning-and-task-breakdown` | Atomic tasks |
| `incremental-implementation` | Thin slices |
| `test-driven-development` | Red-green-refactor |
| `implement` | Build from spec/tickets |
| `debugging-and-error-recovery` | Systematic debug |
| `diagnose` | Hard bug / regression |
| `code-review-and-quality` | Pre-merge review |
| `constraint-driven-development` | Quality bar contract |
| `security-and-hardening` | Auth, input, secrets |
| `frontend-ui-engineering` | UI-only work |
| `ci-cd-and-automation` | Pipeline gates |
| `shipping-and-launch` | Production launch |
| `git-workflow-and-versioning` | Commits, branches |
| `context-engineering` | Project rules file |

Also present: `code-simplification`, `performance-optimization`, `observability-and-instrumentation`, `api-and-interface-design`, Matt skills (`grill-me`, `ask-matt`, …), `using-agent-skills` meta-skill.

**Overlap note:** `implement` vs `incremental-implementation` — router uses **incremental-implementation** for build slices; `implement` when executing a pre-written plan ticket.

### Superpowers (Cursor plugin)

**Path:** `~/.cursor/plugins/cache/cursor-public/superpowers/.../skills/`

Craft references **only** these (avoid duplicating Addy):

| Skill | When router delegates here |
|-------|---------------------------|
| `brainstorming` | Creative greenfield before Shape completes |
| `systematic-debugging` | Bug with no clear layer (Addy `diagnose` is alternative) |
| `verification-before-completion` | Before claiming "done" / Ship gate |
| `writing-plans` | Optional; Addy `planning-and-task-breakdown` is primary |

**Explicitly excluded from default routing:** `using-superpowers` "1% chance read every skill" — token waste; conflicts with Craft anti-drift.

### Craft (this repo) — v0.1 target

| Skill | Owner |
|-------|-------|
| `using-craft` | Craft |
| `engineering-ledger` | Craft |
| `craft-adopt` | Craft |
| `craft-promote` | Craft |

---

## Gap matrix

| Lifecycle need | Upstream skill (reference) | Craft adds |
|----------------|---------------------------|------------|
| Shape | `interview-me` / `idea-refine` | Ledger AP + INDEX framing |
| Spec | `spec-driven-development` | DR for tactical forks |
| ADR fork | `documentation-and-adrs` | `adr-vs-ledger.md` bridge |
| Plan | `planning-and-task-breakdown` | AP ↔ plan links |
| Build | `incremental-implementation` + `test-driven-development` | Phase gate in `phases.md` |
| Debug | `debugging-and-error-recovery` | Mandatory LL after root cause |
| Review | `code-review-and-quality` | INDEX session note |
| Verify | `constraint-driven-development` | Benchmark/CI evidence in ledger |
| Ship | `shipping-and-launch` | Rollback note in INDEX |
| Session memory | — | **engineering-ledger** |
| Universal → skill | Superpowers `writing-skills` (format ref) | **craft-promote** |
| Onboarding | Addy adoption guide | **craft-adopt** |
| Routing / anti-drift | Addy `using-agent-skills` (too aggressive) | **using-craft** (one skill per phase) |

**Gap count:** 4 Craft-native skills — within v0.1 budget (≤5).

---

## Reference-only dependency decision

| Verdict | Approach |
|---------|----------|
| **Yes** | Router stores skill **names** + manifest pins; bodies live in `~/.agents/skills/` |
| **No** | Copy SKILL.md into Craft or project repos |

**Rationale:** Upstream workflow fixes propagate via `npx skills update`; Craft diffs stay small (router rows only).

See [lifecycle-map.md](lifecycle-map.md) and root [craft.manifest.yaml](../craft.manifest.yaml).

---

## Strong sources (not reinvented)

| Source | Craft uses it for |
|--------|-------------------|
| [Addy agent-skills adoption guide](https://github.com/addyosmani/agent-skills/blob/main/docs/adoption-guide.md) | Greenfield vs brownfield rollout, slash commands |
| Michael Nygard — ADR template | Irreversible forks → `docs/decisions/` |
| Google eng practices — design docs | Spec before implementation gate |
| Forsgren et al. — *Accelerate* (DORA) | Verify/Ship evidence: CI, lead time, change fail rate |
| Ousterhout — *A Philosophy of Software Design* | Deep modules; aligns with Addy `code-simplification` |
| Recall [AGENTS.md](https://github.com/DTiapan/Recall/blob/main/AGENTS.md) | Real project: phase delivery, ADR-first, TDD mandate |

---

## Recall dogfood context

Recall already enforces Addy skills in AGENTS.md. Craft adds:

- `docs/engineering-ledger/` for narrative between ADRs
- Router pointer in AGENTS.md (Craft layer on top, not replacement)

---

## Exit gate

- [x] Inventory complete
- [x] Gap list ≤ 5 Craft skills
- [x] Reference-only strategy documented
- [x] Bibliography cited

**Approved for v0.1 implementation.**
