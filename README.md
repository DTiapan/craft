# Craft

**Pluggable orchestration + persistent memory layer for AI-assisted development** — by [DTiapan](https://github.com/DTiapan).

[![Version](https://img.shields.io/badge/version-0.2.3-blue.svg)](craft.manifest.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Profiles](https://img.shields.io/badge/profiles-8%20available-purple.svg)](craft.manifest.yaml)

Craft gives AI agents and developers a clean **lifecycle router** and **engineering ledger** without copying or vendoring upstream skills. It routes agents to the **best upstream skills** ([Addy Osmani agent-skills](https://github.com/addyosmani/agent-skills), [Proyecto26 system-design-skills](https://github.com/proyecto26/system-design-skills), [UI/UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)) and provides durable running memory for problem framing, trade-offs, and lessons learned.

> Code is cheap and ephemeral. **Problem framing, architectural trade-offs, and lessons learned** are the durable assets.

---

## What is Craft? (Mental Model)

Craft is **NOT** a code library or a vendored skill dump. Think of Craft the way you think of `git`: **it initializes directly inside your project repository**. All skills reside self-contained in `.agents/skills/`, and running project memory lives in `docs/engineering-ledger/`.

Craft is IDE- and platform-agnostic: it works seamlessly with **Google Antigravity**, Cursor, Claude Code, Windsurf, or terminal CLI agents without hardcoding IDE paths.

```
┌─────────────────────────────────────────────────────────────┐
│                       AI CODING AGENT                       │
│       (Google Antigravity / Cursor / Claude Code / CLI)      │
└──────────────────────────────┬──────────────────────────────┘
                               │
            ┌──────────────────┴──────────────────┐
            │                                     │
            ▼                                     ▼
┌───────────────────────┐             ┌───────────────────────┐
│     ROUTER LAYER      │             │     MEMORY LAYER      │
│     (using-craft)     │             │ (engineering-ledger)  │
├───────────────────────┤             ├───────────────────────┤
│ • Phase Identification│             │ • docs/engineering-  │
│ • Single-skill route  │             │   ledger/INDEX.md     │
│ • Anti-drift rules    │             │ • Tactical DR-###     │
│ • No skill hoarding   │             │ • Universal LL-###    │
└───────────┬───────────┘             └───────────────────────┘
            │
            ▼  (dispatches to exactly one project-local skill)
┌─────────────────────────────────────────────────────────────┐
│                    PROJECT-LOCAL SKILLS                     │
│                  (<project>/.agents/skills/)                │
│                                                             │
│ • using-craft & ledger      (Craft-native orchestration)    │
│ • addyosmani/agent-skills   (TDD, Spec, Debug, Refactor)    │
│ • proyecto26/system-design  (Distributed systems, Caching) │
│ • nextlevelbuilder/ui-ux    (Design systems, Accessibility) │
└─────────────────────────────────────────────────────────────┘
```

| Layer | Responsibility | Components |
|---|---|---|
| **Router** | Maps project phase to exactly *one* best-in-class workflow | `using-craft` skill |
| **Memory** | Preserves context, decisions, and lessons across sessions | `engineering-ledger` (`docs/engineering-ledger/`) |
| **Implementation** | Executes the actual engineering task | Project-local skills in `.agents/skills/` (from `craft.manifest.yaml`) |
| **Lifecycle** | Onboards target projects & promotes universal lessons | `craft-adopt`, `craft-promote` |

---

## ⚡ Quick Start: 1-Click Project Initializer

Just like `git init`, you initialize Craft directly in your target repository. All skills reside inside `.agents/skills/` in that repository—nothing is copied to global or IDE-specific directories.

### 1. Initialize Craft in Your Project

```bash
# Clone Craft (once on your machine)
git clone git@github.com:DTiapan/craft.git ~/craft

# Initialize in your current project with ALL skills across all profiles:
bash ~/craft/scripts/craft-install.sh --profile all

# Or target a specific project directory:
bash ~/craft/scripts/craft-install.sh --profile all --project-dir /path/to/your/project

# Or install a specific domain profile (e.g., engineering, saas, product, uiux):
bash ~/craft/scripts/craft-install.sh --profile engineering --project-dir /path/to/your/project
```

Running `craft-install.sh`:
- Installs the chosen skill profile directly into `<project>/.agents/skills/`
- Installs Craft-native skills (`using-craft`, `engineering-ledger`, `craft-adopt`, `craft-promote`) into `<project>/.agents/skills/`
- Scaffolds `docs/engineering-ledger/` and `docs/decisions/` with templates
- Creates `craft.project.yaml` and appends instructions to `AGENTS.md`
- Verifies installation dependencies

### 2. Verify Installation

```bash
bash ~/craft/scripts/smoke-test.sh
```

---

## 🤖 AI Agent & LLM Operating Guide

> **MANDATORY PROTOCOL FOR AI AGENTS (Antigravity, Cursor, Claude Code, Copilot, Codex, etc.)**  
> When operating in any repository where Craft is configured (indicated by `craft.project.yaml`, `docs/engineering-ledger/`, or Craft instructions in `AGENTS.md`), **you must follow this exact sequence:**

### 1. Session Initialization (Read Before Acting)
- **Do not jump straight into modifying code for non-trivial tasks.**
- Read `docs/engineering-ledger/INDEX.md` first.
- Check `phases.md` to identify the current lifecycle phase (e.g., `Shape`, `Spec`, `Plan`, `Build`, `Debug`, `Verify`, `Review`, `Ship`).
- Scan `decisions.md` and `lessons.md` to understand existing architectural constraints and avoid repeating known pitfalls.

### 2. Phase Routing (The "One-Skill" Rule)
- Consult the `using-craft` skill (or `.agents/skills/using-craft/SKILL.md`).
- Match the current task to **exactly ONE primary skill** from the lifecycle table:
  - **Shape**: `interview-me` (if underspecified) or `idea-refine`
  - **Spec**: `spec-driven-development`
  - **Architecture / Fork**: `documentation-and-adrs`
  - **Plan**: `planning-and-task-breakdown`
  - **Build**: `incremental-implementation` (and `test-driven-development`)
  - **System Architecture**: `system-design`, `api-design`, `architecture-diagram`
  - **Debug**: `debugging-and-error-recovery`
  - **Verify**: `constraint-driven-development`
  - **Review**: `code-review-and-quality`
  - **Ship**: `shipping-and-launch`
- **Strict Anti-Drift Rule**: Never stack or hoard multiple process skills (e.g., do *not* load `interview-me` + `spec-driven-development` + `incremental-implementation` simultaneously). Load the single skill for the current phase, complete that phase's gate, and transition.

### 3. Missing Skills Recovery
- If a skill called for by `using-craft` is not found in `.agents/skills/`:
  ```bash
  # Run the Craft installer with --profile all to restore all missing skills
  bash /path/to/craft/scripts/craft-install.sh --profile all
  ```
  **Never guess, improvise, or hallucinate process workflows.** Run the installer to fetch the authentic upstream skill.

### 4. Session Finalization (Durable Ledger Append)
Before finishing any substantive work session:
- **Record Tactical Decisions**: If you made a reversible design choice, append it as a `DR-###` in `docs/engineering-ledger/decisions.md`.
- **Capture Lessons Learned**: If you encountered and resolved a tricky bug, unexpected behavior, or API quirk, append it as an `LL-###` in `docs/engineering-ledger/lessons.md`. Tag it with `Scope: project` (local) or `Scope: universal` (reusable).
- **Update Phase Progress**: Mark completed phase gates in `docs/engineering-ledger/phases.md`.
- **Update Ledger INDEX**: Append a session row to `docs/engineering-ledger/INDEX.md`.
- **Irreversible Forks (ADR)**: If a decision is an irreversible, high-impact architectural fork (e.g., database choice, framework rewrite, breaking API contract), create a formal ADR in `docs/decisions/` per `documentation-and-adrs`.

---

## 📦 Domain Skill Profiles Matrix (v0.2.3)

Craft curates upstream skills into targeted domain profiles configured in [craft.manifest.yaml](craft.manifest.yaml):

| Profile | Focus Area | Included Sources & Key Skills |
|---|---|---|
| **`all`** | **Complete Suite** | Installs **all** skills across Addy, System Design wiki, and UI/UX Pro Max. Recommended for full-stack environments. |
| **`engineering`** | Core Architecture & Backend | `proyecto26/system-design-skills` (System Design wiki, Caching, Consistency, Data Storage, Messaging, Distributed Search/Logging, Observability, Scaling) + `addyosmani/agent-skills` (TDD, Security, CI/CD, Git). |
| **`saas`** | Commercial SaaS & Monetization | API Design, Multi-Tenancy, Auth Security, Frontend UI, Billing, Entitlements, UI/UX Pro Max, Shipping & Launch. |
| **`product`** | 0-to-1 Discovery & PRDs | Idea Refine, Interview Me, Spec-Driven Development, Task Breakdown, ADRs. |
| **`uiux`** | Design Systems & Modern Frontend | UI/UX Pro Max, Frontend UI Engineering, Browser DevTools Testing, Modern Web Guidance. |
| **`marketing`** | Growth & Launch Messaging | Shipping & Launch, Idea Refine, User Interviewing, Spec-Driven Dev. |
| **`seo`** | Technical SEO & Performance | Performance Optimization, Modern Web Guidance, Browser Testing with DevTools. |
| **`global`** | Minimal Baseline Engineering | TDD, Systematic Debugging, Code Review & Quality, Constraint-Driven Dev, Git Workflow, Documentation & ADRs, Context Engineering. |

### CLI Installer Reference

```
bash scripts/craft-install.sh [options]

Options:
  --profile, -p <name>    Profile to install (all, engineering, saas, product, uiux, marketing, seo, global) [default: all]
  --project-dir, -d <dir> Target project directory [default: current working dir]
  --fetch, -f <query>     Dynamically fetch an online skill package if missing
  --help, -h              Show help and usage examples
```

---

## 🛠️ How to Adopt Craft in Any Target Repository

### Option A: Automated 1-Click Setup (Recommended)

From your target project root:
```bash
# Initializes all skills, ledger templates, craft.project.yaml, and AGENTS.md
bash /path/to/craft/scripts/craft-install.sh --profile all --project-dir .
```

### Option B: Manual Step-by-Step Setup

1. **Install skills into `.agents/skills`:**
   ```bash
   mkdir -p .agents/skills
   npx skills add addyosmani/agent-skills
   cp -R /path/to/craft/skills/* .agents/skills/
   ```

2. **Scaffold the ledger directories:**
   ```bash
   mkdir -p docs/engineering-ledger docs/decisions
   cp /path/to/craft/skills/engineering-ledger/templates/* docs/engineering-ledger/
   ```

3. **Wire your project's `AGENTS.md` (append to existing file):**
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
- **Durable Ledger Updates**: Append tactical decisions (`DR-###`) and lessons (`LL-###`) to `docs/engineering-ledger/`, and update `INDEX.md` before ending substantive sessions.
   ```

4. **Add `craft.project.yaml` in project root:**
   ```yaml
   craft_version: "0.2.3"
   profiles:
     - engineering
     - saas
   ledger_path: docs/engineering-ledger
   adr_path: docs/decisions
   manifest_ref: DTiapan/craft craft.manifest.yaml
   ```

---

## 🧭 Craft-Native Core Skills

Craft ships with 4 specialized native skills located in `skills/` (and copied into `.agents/skills/` on init):

| Skill | Role & Trigger |
|---|---|
| **[using-craft](skills/using-craft/SKILL.md)** | **The Router.** Maps current lifecycle phase to exactly one upstream skill. Enforces anti-drift rules. |
| **[engineering-ledger](skills/engineering-ledger/SKILL.md)** | **The Memory.** Manages running project memory: Attack Plans (AP), Decision Records (DR), and Lessons Learned (LL). |
| **[craft-adopt](skills/craft-adopt/SKILL.md)** | **The Bootstrapper.** 1-click adoption of Craft into any greenfield or brownfield repository. |
| **[craft-promote](skills/craft-promote/SKILL.md)** | **The Skill Forge.** Promotes high-value, universal lessons learned (`Scope: universal`) into reusable Craft-native skills. |

---

## 🏛️ Dependency Strategy: Reference, Don't Copy

Craft enforces a strict **"Reference, Don't Copy"** philosophy:
- Upstream skill bodies are **never vendored** into Craft or target git repositories.
- Upstream packages are pinned in [craft.manifest.yaml](craft.manifest.yaml).
- Router tables in `using-craft` refer to upstream skills by name.
- When upstream skills are updated by their maintainers, simply run:
  ```bash
  npx skills update addyosmani/agent-skills
  npx skills update proyecto26/system-design-skills
  ```

---

## 📚 Documentation Index

| Document | Purpose |
|---|---|
| [lifecycle-map.md](docs/lifecycle-map.md) | Comprehensive end-to-end lifecycle phases, phase gates, and anti-drift contracts |
| [landscape-audit.md](docs/landscape-audit.md) | Exhaustive map of upstream capabilities vs. what Craft uniquely owns |
| [adoption.md](docs/adoption.md) | Detailed walkthrough for onboarding brownfield and greenfield repositories |
| [case-study-recall.md](docs/case-study-recall.md) | Real-world dogfooding case study on Recall (Enterprise RAG engine) |

---

## 🌐 Part of the Three-Repo Stack

Craft is the **workflow and memory layer** within a specialized AI engineering ecosystem:

| Project | Role | Description |
|---|---|---|
| **[Recall](https://github.com/DTiapan/Recall)** | **Anchor Product** | Production Enterprise RAG engine with BEIR benchmarked retrieval. |
| **Craft** (this repo) | **Workflow & Router** | Lifecycle phase router and engineering ledger; orchestrates upstream skills without copying. |
| **[Battery](https://github.com/DTiapan/battery)** | **MCP Memory** | Local Model Context Protocol (MCP) server for cross-session persistent memory across agent sessions. |

---

## Author

**Ajas Bakran** — AI Systems Engineer focused on Agent Evaluation, Context Engineering, and Production Reliability.

- **GitHub**: [@DTiapan](https://github.com/DTiapan)
- **LinkedIn**: [linkedin.com/in/ajasbakran](https://linkedin.com/in/ajasbakran)
- **Substack**: [growithai.substack.com](https://growithai.substack.com/)
- **Contact**: [bakran.ajas@gmail.com](mailto:bakran.ajas@gmail.com)

---

## License

MIT © [Ajas Bakran](LICENSE)
