#!/usr/bin/env bash
# End-to-end Craft smoke test. Run from craft repo root or any path.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRAFT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

pass=0
fail=0

check() {
  local name="$1"
  shift
  if "$@"; then
    echo "PASS: $name"
    pass=$((pass + 1))
  else
    echo "FAIL: $name"
    fail=$((fail + 1))
  fi
}

echo "Craft smoke test"
echo "Craft root: $CRAFT_ROOT"
echo ""

check "craft.manifest.yaml exists" test -f "$CRAFT_ROOT/craft.manifest.yaml"
check "using-craft SKILL.md" test -f "$CRAFT_ROOT/skills/using-craft/SKILL.md"
check "engineering-ledger SKILL.md" test -f "$CRAFT_ROOT/skills/engineering-ledger/SKILL.md"
check "craft-adopt SKILL.md" test -f "$CRAFT_ROOT/skills/craft-adopt/SKILL.md"
check "craft-promote SKILL.md" test -f "$CRAFT_ROOT/skills/craft-promote/SKILL.md"
check "lifecycle-map doc" test -f "$CRAFT_ROOT/docs/lifecycle-map.md"
check "verify-deps executable" test -x "$CRAFT_ROOT/skills/craft-adopt/scripts/verify-deps.sh"

echo ""
echo "Running verify-deps..."
if ( cd "$CRAFT_ROOT" && bash "$CRAFT_ROOT/skills/craft-adopt/scripts/verify-deps.sh" ); then
  echo "PASS: verify-deps"
  pass=$((pass + 1))
else
  echo "FAIL: verify-deps (see errors above)"
  fail=$((fail + 1))
fi

echo ""
echo "Summary: $pass passed, $fail failed"
if (( fail > 0 )); then
  exit 1
fi
echo "Craft is ready."
exit 0
