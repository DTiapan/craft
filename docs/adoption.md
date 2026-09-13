# Adopting Craft in a Project

## 1. Copy the ledger scaffold

From `skills/engineering-ledger/templates/` into your project:

```bash
mkdir -p docs/engineering-ledger
cp craft/skills/engineering-ledger/templates/* docs/engineering-ledger/
```

## 2. Install the skill

Symlink or copy `skills/engineering-ledger/` into:

- `~/.cursor/skills/engineering-ledger` (personal, all projects), or
- `.agents/skills/engineering-ledger/` (project-scoped)

## 3. Wire your project AGENTS.md

Add one line:

```markdown
For non-trivial work, read `docs/engineering-ledger/INDEX.md` and follow the `engineering-ledger` skill.
```

## 4. Keep ADRs separate

| Artifact | When |
|----------|------|
| `docs/decisions/00xx-*.md` (ADR) | Irreversible architecture fork |
| `docs/engineering-ledger/decisions.md` (DR-###) | Tactical, reversible choices |
| `docs/engineering-ledger/lessons.md` (LL-###) | What we learned after the fact |

Promote a ledger decision to an ADR when reversal cost crosses team threshold.

## 5. Session ritual

**Start:** Read INDEX + active phase + open attack plan.  
**End:** Append DR/LL entries; update INDEX one-liner; note next gate.
