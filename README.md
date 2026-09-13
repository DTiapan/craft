# Craft

**Pluggable orchestration + memory layer** for AI-assisted development — by [DTiapan](https://github.com/DTiapan).

Craft routes agents to **best upstream skills** (Addy agent-skills, optional Superpowers) without copying them. It adds a running **engineering ledger**, adoption workflow, and a path to promote universal lessons into Craft-native skills.

Code is cheap. **Problem framing, trade-offs, and lessons learned** are the durable artifacts.

## Quick install

```bash
# 1. Implementation engine (once per machine — reference only, not vendored)
npx skills add addyosmani/agent-skills

# 2. Craft orchestration + memory
git clone git@github.com:DTiapan/craft.git ~/.cursor/skills/craft
ln -sf ~/.cursor/skills/craft/skills/* ~/.cursor/skills/

# 3. Verify dependencies
bash ~/.cursor/skills/craft/skills/craft-adopt/scripts/verify-deps.sh

# 4. Per project — run craft-adopt skill or see docs/adoption.md
```

**Update upstream:** `npx skills update addyosmani/agent-skills`

**Smoke test (after install):**

```bash
bash ~/.cursor/skills/craft/scripts/smoke-test.sh
```

## Skills (v0.1)

| Skill | Purpose |
|-------|---------|
| [using-craft](skills/using-craft/SKILL.md) | **Router** — phase → one upstream skill (reference-only) |
| [engineering-ledger](skills/engineering-ledger/SKILL.md) | Running memory: phases, AP, DR, LL |
| [craft-adopt](skills/craft-adopt/SKILL.md) | Bootstrap ledger + AGENTS.md in a project |
| [craft-promote](skills/craft-promote/SKILL.md) | Universal LL → new Craft-native skill |

## Docs

| Doc | Purpose |
|-----|---------|
| [lifecycle-map.md](docs/lifecycle-map.md) | End-to-end phases, gates, anti-drift |
| [landscape-audit.md](docs/landscape-audit.md) | What exists upstream; what Craft owns |
| [adoption.md](docs/adoption.md) | Project onboarding |
| [case-study-recall.md](docs/case-study-recall.md) | Dogfood validation on Recall |

## Dependency strategy

**Reference, don't copy.** [craft.manifest.yaml](craft.manifest.yaml) pins pack ids and expected skill names — not skill file bodies. When Addy updates a workflow, you run `npx skills update`; Craft router tables change only on renames/splits.

## Philosophy

1. **Compose best wheels** — Addy implements; Craft orchestrates + remembers.
2. **Read before build** — ledger INDEX before non-trivial work.
3. **Append, don't rewrite** — history is evidence.
4. **ADRs for forks, ledger for narrative** — irreversible → ADR; tactical → DR.
5. **Two-tier lessons** — `Scope: project` stays local; `Scope: universal` → `craft-promote`.

## Repository layout

```
craft/
├── craft.manifest.yaml       # Upstream dependency pins (no vendored skills)
├── README.md
├── AGENTS.md
├── skills/
│   ├── using-craft/
│   ├── engineering-ledger/
│   ├── craft-adopt/
│   └── craft-promote/
└── docs/
```

---

## Part of a three-repo stack

Craft is the **workflow layer** for builders shipping real GenAI systems:

| Project | Role |
|---------|------|
| [Recall](https://github.com/DTiapan/Recall) | Enterprise RAG kit with real BEIR benchmarks (anchor product) |
| **Craft** (this repo) | Phase router + engineering ledger; references [Addy agent-skills](https://github.com/addyosmani/agent-skills), never copies them |
| [Battery](https://github.com/DTiapan/battery) | Local MCP memory for rules and decisions across Cursor / Claude sessions |

Dogfood: [case study on Recall](docs/case-study-recall.md).

---

## Author

**Ajas Bakran** — AI systems engineer focused on agent evaluation, context engineering, and production reliability.

- GitHub: [github.com/DTiapan](https://github.com/DTiapan)
- LinkedIn: [linkedin.com/in/ajasbakran](https://linkedin.com/in/ajasbakran)
- Newsletter: [growithai.substack.com](https://growithai.substack.com/)

Advisory and consulting on AI agent reliability, memory architectures, MCP integrations, and production RAG — [get in touch](mailto:bakran.ajas@gmail.com).

---

## License

MIT — see [LICENSE](LICENSE).
