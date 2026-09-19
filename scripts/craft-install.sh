#!/usr/bin/env bash
# Craft 1-Click Skill Installer & Dynamic Domain Profile Setup
# Usage:
#   bash scripts/craft-install.sh [--profile <global|saas|engineering|product|uiux|marketing|seo|all>] [--fetch <query>]
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
      echo "Craft 1-Click Skill Installer & Auto-Fetcher v0.2.1"
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

echo "=================================================================="
echo "Craft 1-Click Domain Skill Installer & Online Auto-Discovery v0.2.1"
echo "Target Profile: $PROFILE"
echo "Project Dir:    $PROJECT_DIR"
echo "Craft Root:     $CRAFT_ROOT"
echo "=================================================================="
echo ""

# Helper: Install standard Addy agent-skills pack
install_addy_skills() {
  echo "--> [Profile: Core] Installing agent-skills (addyosmani/agent-skills)..."
  ( cd "$PROJECT_DIR" && npx --yes skills add addyosmani/agent-skills ) || {
    echo "  [Fallback] Attempting git clone fallback for addyosmani/agent-skills..."
    mkdir -p "$PROJECT_DIR/.agents/skills"
    git clone https://github.com/addyosmani/agent-skills.git "$PROJECT_DIR/.agents/skills/addy-pack" || true
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
      mkdir -p "$PROJECT_DIR/.agents/skills"
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
    install_uiux_skills
    ;;
  engineering)
    install_addy_skills
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

# Wire Craft native skills into user skill directory (~/.cursor/skills)
echo ""
echo "--> Wiring Craft native skills (using-craft, engineering-ledger, craft-adopt, craft-promote)..."
mkdir -p "$HOME/.cursor/skills"
for skill in "$CRAFT_ROOT/skills"/*; do
  if [[ -d "$skill" ]]; then
    base=$(basename "$skill")
    ln -sf "$skill" "$HOME/.cursor/skills/$base"
  fi
done

# Run dependency verification gate
echo ""
echo "--> Verifying installation..."
bash "$CRAFT_ROOT/skills/craft-adopt/scripts/verify-deps.sh"

echo ""
echo "✓ Craft skill profile '$PROFILE' successfully installed and verified!"
