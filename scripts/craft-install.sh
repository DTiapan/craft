#!/usr/bin/env bash
# Craft 1-Click Skill Installer & Dynamic Domain Profile Setup
# Usage:
#   bash scripts/craft-install.sh [--profile <global|saas|engineering|product|uiux|marketing|seo|all>] [--project-dir <dir>] [--fetch <query>]
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRAFT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PROFILE="all"
PROJECT_DIR="$(pwd)"
CUSTOM_FETCH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile|-p)
      PROFILE="$2"
      shift 2
      ;;
    --project-dir|-d)
      PROJECT_DIR="$2"
      shift 2
      ;;
    --fetch|-f)
      CUSTOM_FETCH="$2"
      shift 2
      ;;
    --help|-h)
      echo "Craft 1-Click Skill Installer & Auto-Fetcher v0.2.3"
      echo "Usage: bash scripts/craft-install.sh [options]"
      echo ""
      echo "Options:"
      echo "  --profile, -p <name>    Profile to install (global, saas, engineering, product, uiux, marketing, seo, all) [default: all]"
      echo "  --project-dir, -d <dir> Target project directory [default: current working dir]"
      echo "  --fetch, -f <query>     Dynamically fetch an online skill package if missing"
      echo "  --help, -h              Show this help"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Resolve absolute path for PROJECT_DIR
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"

echo "=================================================================="
echo "Craft 1-Click Domain Skill Installer & Project Initializer v0.2.3"
echo "Target Profile: $PROFILE"
echo "Project Dir:    $PROJECT_DIR"
echo "Craft Root:     $CRAFT_ROOT"
echo "=================================================================="
echo ""

# Ensure .agents/skills directory exists in target project
mkdir -p "$PROJECT_DIR/.agents/skills"

# Helper: Install standard Addy agent-skills pack
install_addy_skills() {
  echo "--> [Profile: Core] Installing agent-skills (addyosmani/agent-skills)..."
  ( cd "$PROJECT_DIR" && npx --yes skills add addyosmani/agent-skills ) || {
    echo "  [Fallback] Attempting git clone fallback for addyosmani/agent-skills..."
    git clone https://github.com/addyosmani/agent-skills.git "$PROJECT_DIR/.agents/skills/addy-pack" || true
  }
}

# Helper: Install proyecto26 System Design skill pack
install_system_design_skills() {
  echo "--> [Profile: System Design] Installing System Design skill pack (proyecto26/system-design-skills)..."
  ( cd "$PROJECT_DIR" && npx --yes skills add proyecto26/system-design-skills -y ) || {
    echo "  [Fallback] Attempting git clone fallback for proyecto26/system-design-skills..."
    git clone https://github.com/proyecto26/system-design-skills.git "$PROJECT_DIR/.agents/skills/system-design-pack" || true
  }
}

# Helper: Install UI/UX Pro Max skill pack
install_uiux_skills() {
  echo "--> [Profile: UI/UX] Installing UI/UX Pro Max skill pack..."
  ( cd "$PROJECT_DIR" && npx --yes skills add nextlevelbuilder/ui-ux-pro-max-skill -s ui-ux-pro-max -y ) || true
}

# Helper: Dynamic online fetch for custom missing skills
fetch_online_skill() {
  local query="$1"
  echo "--> [Online Auto-Discovery] Searching and fetching online skill: '$query'..."
  if ( cd "$PROJECT_DIR" && npx --yes skills add "$query" ); then
    echo "  ✓ Successfully installed online skill '$query' via npx skills"
  else
    echo "  ! Could not auto-install '$query' via npx. Trying git fallback..."
    if [[ "$query" == *"/"* ]]; then
      git clone "https://github.com/${query}.git" "$PROJECT_DIR/.agents/skills/$(basename "$query")" || true
    fi
  fi
}

case "$PROFILE" in
  global)
    install_addy_skills
    ;;
  saas)
    install_addy_skills
    install_system_design_skills
    install_uiux_skills
    ;;
  engineering)
    install_addy_skills
    install_system_design_skills
    ;;
  product)
    install_addy_skills
    ;;
  uiux)
    install_addy_skills
    install_uiux_skills
    ;;
  marketing)
    install_addy_skills
    ;;
  seo)
    install_addy_skills
    install_uiux_skills
    ;;
  all)
    install_addy_skills
    install_system_design_skills
    install_uiux_skills
    ;;
  *)
    echo "ERROR: Unknown profile '$PROFILE'. Valid options: global, saas, engineering, product, uiux, marketing, seo, all"
    exit 1
    ;;
esac

# Execute custom online fetch if requested
if [[ -n "$CUSTOM_FETCH" ]]; then
  fetch_online_skill "$CUSTOM_FETCH"
fi

# Install Craft native skills directly into project .agents/skills/
echo ""
echo "--> Installing Craft native skills into project .agents/skills/..."
for skill in "$CRAFT_ROOT/skills"/*; do
  if [[ -d "$skill" ]]; then
    base=$(basename "$skill")
    dest="$PROJECT_DIR/.agents/skills/$base"
    if [[ "$skill" != "$dest" ]]; then
      cp -R "$skill" "$PROJECT_DIR/.agents/skills/"
      echo "  + Installed skill: $base"
    fi
  fi
done

# Initialize project ledger artifacts if missing (like git init)
echo ""
echo "--> Initializing Craft project artifacts in $PROJECT_DIR..."
if [[ ! -d "$PROJECT_DIR/docs/engineering-ledger" ]]; then
  echo "  + Scaffolding docs/engineering-ledger/ and docs/decisions/..."
  mkdir -p "$PROJECT_DIR/docs/engineering-ledger" "$PROJECT_DIR/docs/decisions"
  cp -R "$CRAFT_ROOT/skills/engineering-ledger/templates/"* "$PROJECT_DIR/docs/engineering-ledger/"
else
  echo "  ✓ Existing docs/engineering-ledger found."
fi

if [[ ! -f "$PROJECT_DIR/craft.project.yaml" ]]; then
  echo "  + Creating craft.project.yaml..."
  cat << EOF > "$PROJECT_DIR/craft.project.yaml"
craft_version: "0.2.3"
profiles:
  - ${PROFILE}
ledger_path: docs/engineering-ledger
adr_path: docs/decisions
manifest_ref: DTiapan/craft craft.manifest.yaml
EOF
else
  echo "  ✓ Existing craft.project.yaml found."
fi

if [[ ! -f "$PROJECT_DIR/AGENTS.md" ]]; then
  echo "  + Creating AGENTS.md with Craft instructions..."
  cat << 'EOF' > "$PROJECT_DIR/AGENTS.md"
# AGENTS.md

## Craft (orchestration + ledger)

- Non-trivial work: read `docs/engineering-ledger/INDEX.md` first.
- Route phases via `using-craft` skill (reference-only — do not copy Addy skills into this repo).
- Append DR/LL/INDEX before ending substantive sessions.
- Irreversible forks: ADR in `docs/decisions/` per `documentation-and-adrs`.
EOF
elif ! grep -q "## Craft" "$PROJECT_DIR/AGENTS.md"; then
  echo "  + Appending Craft instructions to AGENTS.md..."
  cat << 'EOF' >> "$PROJECT_DIR/AGENTS.md"

## Craft (orchestration + ledger)

- Non-trivial work: read `docs/engineering-ledger/INDEX.md` first.
- Route phases via `using-craft` skill (reference-only — do not copy Addy skills into this repo).
- Append DR/LL/INDEX before ending substantive sessions.
- Irreversible forks: ADR in `docs/decisions/` per `documentation-and-adrs`.
EOF
else
  echo "  ✓ Craft section already present in AGENTS.md."
fi

# Run dependency verification gate
echo ""
echo "--> Verifying project installation..."
bash "$CRAFT_ROOT/skills/craft-adopt/scripts/verify-deps.sh" "$PROJECT_DIR"

echo ""
echo "✓ Craft skill profile '$PROFILE' successfully initialized in $PROJECT_DIR!"
