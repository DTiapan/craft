# Case study — Craft dogfood on Recall

**Date:** 2026-09-13  
**Project:** [DTiapan/Recall](https://github.com/DTiapan/Recall)  
**Craft version:** 0.1.0

---

## Objective

Validate the Craft loop: router → upstream skill → ledger read/write, without vendoring Addy skills.

## Slice chosen

Backfill `docs/engineering-ledger/` for recent Recall eval work (benchmarks, BEIR doc_id fix, batched ingest) — narrative that ADRs alone don't capture.

## Loop walkthrough

| Step | Action | Result |
|------|--------|--------|
| 1 | `craft-adopt` scaffold | `docs/engineering-ledger/` + `craft.project.yaml` in Recall |
| 2 | `engineering-ledger` read | INDEX + AP-001 reviewed before doc work |
| 3 | `using-craft` route → Build/Verify | `incremental-implementation` + ledger evidence |
| 4 | Write loop | DR-001, DR-002, LL-001 (universal), LL-002 (project); INDEX updated |
| 5 | `verify-deps.sh` | All Addy skills present locally |

## Exit gate checklist

- [x] One process skill per phase (no stacking)
- [x] INDEX updated with session summary
- [x] LL entries include Scope (`project` / `universal`)
- [x] Phase evidence linked (commits, README benchmark table)
- [x] No Addy SKILL.md copied into Craft or Recall

## Friction points

| Issue | Mitigation |
|-------|------------|
| Recall AGENTS.md already mandates Addy skills | Craft section **appends** — ledger + router, not replacement |
| Superpowers not npx-installable | Manifest marks optional; router lists as delegate only |
| Brownfield backfill | AP-001 marked done with historical commits cited |

## Universal lesson candidate

**LL-001** — Benchmark eval labels must match indexed doc_id metadata (BEIR SciFact 0% → 85.7% after fix). Tagged `Scope: universal`, `Promotion candidate: yes` — candidate for future `craft-promote` if pattern repeats in another project.

## Conclusion

Craft v0.1 loop is **complete**. Recall is the reference adoption for enterprise RAG phased delivery + Addy implementation + Craft memory.
