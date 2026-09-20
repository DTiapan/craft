# Craft — Agent Instructions

This repository **is** a skills library and **reference-only router** for upstream packs.

## Working in this repo

1. Read [README.md](README.md) and [docs/lifecycle-map.md](docs/lifecycle-map.md).
2. Each skill: `skills/<name>/SKILL.md` with YAML frontmatter (`name`, `description`).
3. **Never copy** upstream Addy/Superpowers SKILL.md bodies into craft — update router tables instead.
4. New Craft-native skills: follow [skills/using-craft/SKILL.md](skills/using-craft/SKILL.md) quality bar.

## Craft-native skills (v0.1)

| Skill | Role |
|-------|------|
| `using-craft` | Phase router → upstream skill names |
| `engineering-ledger` | Project ledger read/write loops |
| `craft-adopt` | Bootstrap target projects |
| `craft-promote` | Universal LL → new skill |

## Upstream (referenced, not vendored)

See [craft.manifest.yaml](craft.manifest.yaml). Install: `npx skills add addyosmani/agent-skills`.

When adding or refining skills, read `using-craft` first.


## Craft (Orchestration, Skills & Ledger)

- **Read Ledger First**: Non-trivial work must read `docs/engineering-ledger/INDEX.md` and active phase in `phases.md` before taking action.
- **Mandatory Skill-First Routing**: Every discussion, architecture design, development, and debugging task **must flow through the corresponding skill** in `.agents/skills/`. Before executing any phase, cross-check installed skills and load the best domain skill:
  - *Ideation & Discovery*: Load `idea-refine` or `interview-me` to sharpen ambiguous requirements.
  - *System Architecture & Design*: Load `system-design` (stress-test failure modes, trade-offs, scaling, data models) along with building blocks (`api-design`, `architecture-diagram`, `caching`, `resilience-failure`, `data-storage`, `messaging-streaming`).
  - *Specification & Decisions*: Load `spec-driven-development`. For irreversible forks, create an ADR in `docs/decisions/` per `documentation-and-adrs`.
  - *Implementation & TDD*: Load `incremental-implementation` for thin slices and `test-driven-development` (Red-Green-Refactor).
  - *Debugging & Errors*: Load `debugging-and-error-recovery` (systematic root cause analysis, never guess).
  - *Verification & Quality*: Load `constraint-driven-development` and `code-review-and-quality` before completing features.
  - *UI / Frontend*: Load `ui-ux-pro-max` and `frontend-ui-engineering`.
- **Anti-Drift**: Use the single best skill for the active phase (via `using-craft`). Never bypass skills or invent ad-hoc processes when an established skill exists.
- **Phase Transition Thresholds**: Never jump phases without satisfying the previous phase's exit gate evidence in `phases.md`. Anti-drift thresholds must be verified before proceeding to prevent premature implementation.
- **Market Validation Gate**: In `docs/northstar.md`, evaluate the Market Validation Score (0–10). A score of >= 7/10 is required to enter `Build`. If < 7, stop or pivot.
- **Durable Ledger Updates**: Append tactical decisions (`DR-###`) and lessons (`LL-###`) to `docs/engineering-ledger/`, and update `INDEX.md` before ending substantive sessions.
