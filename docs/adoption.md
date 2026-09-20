# Adopting Craft in a Project

Like `git init`, Craft initializes all skills and ledger artifacts directly inside your project repository. All skills reside self-contained in `.agents/skills/` without requiring global folders or IDE-specific directories.

## Quick Start (Automated 1-Click Init)

Run the installer directly pointing to your target project:

```bash
# Initialize Craft in target project with all skills
bash /path/to/craft/scripts/craft-install.sh --profile all --project-dir /path/to/your/project

# Or from inside the project root:
bash /path/to/craft/scripts/craft-install.sh --profile all
```

This single command:
1. Installs upstream skills for the selected profile into `$TARGET/.agents/skills/`
2. Installs Craft-native skills (`using-craft`, `engineering-ledger`, `craft-adopt`, `craft-promote`) into `$TARGET/.agents/skills/`
3. Scaffolds `docs/engineering-ledger/` and `docs/decisions/` with templates
4. Generates `craft.project.yaml` configured for the project
5. Configures or appends Craft instructions to `AGENTS.md`
6. Runs dependency verification

---

## Manual Step-by-Step Setup

If you prefer to configure manually:

### 1. Install Skills into Project
```bash
cd /path/to/your/project
mkdir -p .agents/skills
npx skills add addyosmani/agent-skills
cp -R /path/to/craft/skills/* .agents/skills/
```

### 2. Scaffold the Ledger
```bash
CRAFT=/path/to/craft
TARGET=/path/to/your/project

mkdir -p "$TARGET/docs/engineering-ledger" "$TARGET/docs/decisions"
cp "$CRAFT/skills/engineering-ledger/templates/"* "$TARGET/docs/engineering-ledger/"
```

### 3. Wire AGENTS.md
Append to project `AGENTS.md`:

```markdown
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
```

### 4. Add Project Pointer (`craft.project.yaml`)
```yaml
craft_version: "0.2.3"
profiles:
  - all
ledger_path: docs/engineering-ledger
adr_path: docs/decisions
manifest_ref: DTiapan/craft craft.manifest.yaml
```

---

## Artifact Separation

| Artifact | When |
|----------|------|
| `docs/decisions/00xx-*.md` (ADR) | Irreversible architecture fork |
| `docs/engineering-ledger/decisions.md` (DR-###) | Tactical, reversible choices |
| `docs/engineering-ledger/lessons.md` (LL-###) | Lessons; tag `Scope: project | universal` |

Promote DR → ADR when reversal cost is high. Promote universal LL → Craft skill via **craft-promote**.

## Session Ritual

**Start:** Read INDEX → active AP → route via `using-craft` → read one upstream skill.  
**End:** Append DR/LL → update phases if gate cleared → update INDEX.

## Refresh Upstream Skills

```bash
cd /path/to/your/project
npx skills update addyosmani/agent-skills
bash /path/to/craft/skills/craft-adopt/scripts/verify-deps.sh .
```
