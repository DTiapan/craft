# Craft

Personal **Agent Skills** library for DTiapan — workflows that capture *how* software gets built, not just *what* was shipped.

Code is cheap. **Problem framing, component strategy, trade-offs, and lessons learned** are the durable artifacts. Craft skills encode that discipline for Cursor, Claude Code, Codex, and any [Agent Skills](https://agentskills.io)-compatible host.

## Install

### Cursor (project-scoped)

```bash
git clone git@github.com:DTiapan/craft.git ~/.cursor/skills/craft
# or symlink individual skills:
ln -s ~/path/to/craft/skills/engineering-ledger ~/.cursor/skills/engineering-ledger
```

### Cursor (this repo as skills root)

Copy or submodule into a project's `.agents/skills/` or `.cursor/skills/` directory.

## Skills

| Skill | Purpose |
|-------|---------|
| [engineering-ledger](skills/engineering-ledger/SKILL.md) | Progressive thought-process ledger: phases, attack plans, decisions, lessons |
| [using-craft](skills/using-craft/SKILL.md) | Meta-skill: when to load which Craft skill |

## Repository layout

```
craft/
├── README.md
├── AGENTS.md                 # Agent routing for this repo
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md          # Required contract
│       ├── references/       # Progressive disclosure
│       └── templates/        # Scaffold files for target projects
└── docs/
    └── adoption.md           # How to adopt in a new project
```

## Philosophy

1. **Read before build** — consult the ledger before non-trivial work.
2. **Append, don't rewrite** — history is evidence; supersede with links.
3. **ADRs for forks, ledger for narrative** — irreversible architecture → ADR; tactical reasoning → ledger.
4. **Phases have gates** — no downstream work until upstream is verified green.

## License

MIT — see [LICENSE](LICENSE).
