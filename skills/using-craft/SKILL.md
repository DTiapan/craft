---
name: using-craft
description: >-
  Meta-skill for the Craft skills library. Use when adding a new skill to craft,
  choosing which Craft skill applies, or onboarding Craft into a project.
---

# Using Craft

Router for the [DTiapan/craft](https://github.com/DTiapan/craft) skills library.

## Skill catalog

| Skill | Invoke when |
|-------|-------------|
| **engineering-ledger** | Capturing thought process, phases, attack plans, DR/LL entries |
| **using-craft** | Adding skills, repo structure questions |

## Adding a new skill to craft

1. Create `skills/<kebab-name>/SKILL.md` with frontmatter `name` + `description`.
2. Add `references/` for progressive disclosure (keep SKILL.md under ~400 lines).
3. Add `templates/` if the skill scaffolds files in target projects.
4. Update root [README.md](../../README.md) skills table.
5. Commit message: `feat(skills): add <name> — <one line why>`

## Skill quality bar

Every Craft skill must define:

- **Triggers** — when to load (and when not to)
- **Workflow** — numbered steps with gates
- **Artifacts** — files produced and where they live
- **Verification** — how to know the skill was followed
- **Anti-patterns** — common agent shortcuts to reject

Optional: `scripts/` for deterministic helpers (id assignment, validation).

## Install paths

| Scope | Path |
|-------|------|
| Personal (Cursor) | `~/.cursor/skills/<skill-name>/` |
| Project | `.agents/skills/<skill-name>/` or `.cursor/skills/<skill-name>/` |

Symlink from a clone of this repo is preferred over copy-paste (stays updatable).

## Relationship to other packs

| Pack | Craft complements it by… |
|------|---------------------------|
| addyosmani/agent-skills | Adding running ledger between spec and ADR |
| documentation-and-adrs | Tactical DR layer below formal ADRs |
| agent-decision-log | Project-scoped multi-file ledger + phases |

Do not fork upstream skills into craft unless customizing permanently.
