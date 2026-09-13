---
name: craft-adopt
description: >-
  Bootstrap Craft into a target project: scaffold engineering ledger, wire AGENTS.md,
  verify upstream skills are installed locally. Use when starting a new project,
  onboarding Craft, or user says "adopt craft" / "set up the ledger".
---

# Craft Adopt

One workflow to make a project Craft-ready. **Does not copy upstream skills** — only scaffolds project artifacts and verifies local installs.

---

## When to use

- New greenfield or brownfield project adopting Craft
- User says: "adopt craft", "set up engineering ledger", "bootstrap craft"
- After cloning Craft on a new machine (verify deps)

## When NOT to use

- Questions about what Craft is (read README)
- Adding a new skill to craft repo (use `craft-promote` or manual skill authoring)

---

## Workflow

### 1. Verify machine dependencies

From craft repo root (or path to clone):

```bash
bash skills/craft-adopt/scripts/verify-deps.sh
```

If fail → instruct user:

```bash
npx skills add addyosmani/agent-skills
```

Optional: symlink Craft skills if not present:

```bash
git clone git@github.com:DTiapan/craft.git ~/.cursor/skills/craft
ln -sf ~/.cursor/skills/craft/skills/* ~/.cursor/skills/
```

### 2. Scaffold ledger in target project

```bash
TARGET=/path/to/project
CRAFT=~/.cursor/skills/craft   # or local clone path

mkdir -p "$TARGET/docs/engineering-ledger"
mkdir -p "$TARGET/docs/decisions"

cp "$CRAFT/skills/engineering-ledger/templates/"* "$TARGET/docs/engineering-ledger/"
```

Initialize `INDEX.md` with project name, date, phase `Shape`, and link to AGENTS.md.

### 3. Wire AGENTS.md

Append (do not replace existing content):

```markdown
## Craft (orchestration + ledger)

- Non-trivial work: read `docs/engineering-ledger/INDEX.md` first.
- Route phases via `using-craft` skill (reference-only — do not copy Addy skills into this repo).
- Append DR/LL/INDEX before ending substantive sessions.
- Irreversible forks: ADR in `docs/decisions/` per `documentation-and-adrs`.
```

### 4. Optional project manifest pointer

Create `$TARGET/craft.project.yaml`:

```yaml
craft_version: "0.1.0"
ledger_path: docs/engineering-ledger
adr_path: docs/decisions
manifest_ref: DTiapan/craft craft.manifest.yaml
```

### 5. Initialize phases.md

Set first phase row to `in_progress` for current work (usually Shape or Build for brownfield).

---

## Verification gate

Before claiming adopt complete:

- [ ] `docs/engineering-ledger/` has INDEX, phases, attack-plans, decisions, lessons
- [ ] `docs/decisions/` exists (may be empty)
- [ ] AGENTS.md mentions Craft + ledger path
- [ ] `verify-deps.sh` passes (or user acknowledged install step)
- [ ] No upstream SKILL.md files copied into project

---

## Anti-patterns

| Don't | Do instead |
|-------|------------|
| Vendor Addy skills into `.agents/skills/` in git | `npx skills add` on each machine |
| Replace entire AGENTS.md | Append Craft section |
| Skip ledger on brownfield | Backfill INDEX with current phase + recent decisions |

---

## Artifacts

| File | Location |
|------|----------|
| Ledger scaffold | `docs/engineering-ledger/*` |
| ADR directory | `docs/decisions/` |
| Project pointer | `craft.project.yaml` (optional) |
| AGENTS.md section | Target project root |

See also [docs/adoption.md](../../docs/adoption.md).
