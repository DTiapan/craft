#!/usr/bin/env bash
# Craft 1-Click Skill Installer & Domain Profile Setup
# Usage:
#   bash scripts/craft-install.sh [--profile <saas|engineering|product|uiux|all>] [--project-dir <path>]
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRAFT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PROFILE="all"
PROJECT_DIR="$(pwd)"

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
    --help|-h)
      echo "Craft 1-Click Skill Installer"
      echo "Usage: bash scripts/craft-install.sh [options]"
      echo ""
      echo "Options:"
      echo "  --profile, -p <name>    Profile to install (saas, engineering, product, uiux, all) [default: all]"
      echo "  --project-dir, -d <dir> Target project directory [default: current working dir]"
      echo "  --help, -h              Show this help"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "=========================================="
echo "Craft 1-Click Domain Skill Installer v0.2.0"
echo "Target Profile: $PROFILE"
echo "Project Dir:    $PROJECT_DIR"
echo "Craft Root:     $CRAFT_ROOT"
echo "=========================================="
echo ""

# 1. Ensure process skill pack is installed via npx skills
install_addy_skills() {
  echo "--> Installing core engineering & process skills (addyosmani/agent-skills)..."
  ( cd "$PROJECT_DIR" && npx --yes skills add addyosmani/agent-skills )
}

install_uiux_skills() {
  echo "--> Installing UI/UX Pro Max skill pack..."
  ( cd "$PROJECT_DIR" && npx --yes skills add nextlevelbuilder/ui-ux-pro-max-skill -s ui-ux-pro-max -y ) || true
}

case "$PROFILE" in
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
  all)
    install_addy_skills
    install_uiux_skills
    ;;
  *)
    echo "ERROR: Unknown profile '$PROFILE'. Valid options: saas, engineering, product, uiux, all"
    exit 1
    ;;
esac

# 2. Wire Craft native skills into user skill directory (~/.cursor/skills)
echo "--> Wiring Craft native skills (using-craft, engineering-ledger, craft-adopt, craft-promote)..."
mkdir -p "$HOME/.cursor/skills"
for skill in "$CRAFT_ROOT/skills"/*; do
  if [[ -d "$skill" ]]; then
    base=$(basename "$skill")
    ln -sf "$skill" "$HOME/.cursor/skills/$base"
  fi
done

# 3. Verify setup
echo ""
echo "--> Verifying installation..."
bash "$CRAFT_ROOT/skills/craft-adopt/scripts/verify-deps.sh"

echo ""
echo "✓ Craft skill profile '$PROFILE' successfully installed and verified!"
