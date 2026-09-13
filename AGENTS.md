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
