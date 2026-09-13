# Adopting Craft in a Project

Prefer the **craft-adopt** skill for a guided workflow. Manual steps below match the same outcome.

## Prerequisites (machine-level)

```bash
npx skills add addyosmani/agent-skills
git clone git@github.com:DTiapan/craft.git ~/.cursor/skills/craft
ln -sf ~/.cursor/skills/craft/skills/* ~/.cursor/skills/
bash ~/.cursor/skills/craft/skills/craft-adopt/scripts/verify-deps.sh
```

Craft **does not** copy Addy skills into your project repo.

## 1. Scaffold the ledger

```bash
CRAFT=~/.cursor/skills/craft
TARGET=/path/to/your/project

mkdir -p "$TARGET/docs/engineering-ledger" "$TARGET/docs/decisions"
cp "$CRAFT/skills/engineering-ledger/templates/"* "$TARGET/docs/engineering-ledger/"
```

## 2. Wire AGENTS.md

Append to project `AGENTS.md`:

```markdown
## Craft (orchestration + ledger)

- Non-trivial work: read `docs/engineering-ledger/INDEX.md` first.
- Route phases via `using-craft` (reference-only — do not copy Addy skills into this repo).
- Append DR/LL/INDEX before ending substantive sessions.
- Irreversible forks: ADR in `docs/decisions/` per `documentation-and-adrs`.
```

## 3. Optional project pointer

```yaml
# craft.project.yaml
craft_version: "0.1.0"
ledger_path: docs/engineering-ledger
adr_path: docs/decisions
manifest_ref: DTiapan/craft craft.manifest.yaml
```

## Artifact separation

| Artifact | When |
|----------|------|
| `docs/decisions/00xx-*.md` (ADR) | Irreversible architecture fork |
| `docs/engineering-ledger/decisions.md` (DR-###) | Tactical, reversible choices |
| `docs/engineering-ledger/lessons.md` (LL-###) | Lessons; tag `Scope: project \| universal` |

Promote DR → ADR when reversal cost is high. Promote universal LL → Craft skill via **craft-promote**.

## Session ritual

**Start:** Read INDEX → active AP → route via `using-craft` → read one upstream skill.  
**End:** Append DR/LL → update phases if gate cleared → update INDEX.

## Refresh upstream skills

```bash
npx skills update addyosmani/agent-skills
bash ~/.cursor/skills/craft/skills/craft-adopt/scripts/verify-deps.sh
```
