#!/usr/bin/env bash
# Verify referenced skills exist locally. Exit 1 if any required skill missing.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRAFT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
MANIFEST="$CRAFT_ROOT/craft.manifest.yaml"

search_paths=(
  "${HOME}/.agents/skills"
  "${HOME}/.cursor/skills"
)

missing=()

while IFS= read -r skill; do
  [[ -z "$skill" ]] && continue
  found=0
  for base in "${search_paths[@]}"; do
    if [[ -f "$base/$skill/SKILL.md" ]]; then
      found=1
      break
    fi
  done
  if [[ $found -eq 0 ]]; then
    missing+=("$skill")
  fi
done < <(awk '
  /id: addyosmani\/agent-skills/ { in_addy=1; in_skills=0; next }
  in_addy && /^  - id:/ { in_addy=0; in_skills=0 }
  in_addy && /^    skills:/ { in_skills=1; next }
  in_addy && in_skills && /^      - / { print substr($0, 9) }
  in_addy && in_skills && /^    [a-z_]/ && !/^    skills:/ { in_skills=0 }
' "$MANIFEST")

echo "Craft dependency check (reference-only)"
echo "Manifest: $MANIFEST"
echo ""

if ((${#missing[@]})); then
  echo "Missing required skills (${#missing[@]}):"
  printf '  - %s\n' "${missing[@]}"
  echo ""
  echo "Install with:"
  echo "  npx skills add addyosmani/agent-skills"
  exit 1
fi

echo "All required Addy skills found locally."
exit 0
