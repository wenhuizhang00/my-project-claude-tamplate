#!/usr/bin/env bash
# Run all agent-runtime checks from repository root. Non-zero exit if any *required* check fails.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$ROOT"

# shellcheck source=scripts/agent-runtime/lib/common.sh
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
_load_config

if [[ -z "$(find "$SCRIPT_DIR/checks" -maxdepth 1 -type f -name '*.sh' 2>/dev/null | head -1)" ]]; then
  c_fail "No checks found in ${SCRIPT_DIR}/checks"
  exit 1
fi

failed=0
while IFS= read -r chk; do
  base=$(basename "$chk")
  echo ""
  c_info ">>> ${base}"
  set +e
  bash "$chk"
  rc=$?
  set -e
  if [[ $rc -ne 0 ]]; then
    c_fail "Check failed: ${base} (exit $rc)"
    failed=$((failed + 1))
  fi
done < <(find "$SCRIPT_DIR/checks" -maxdepth 1 -type f -name '*.sh' | sort)

echo ""
if [[ "$failed" -eq 0 ]]; then
  c_ok "All agent-runtime checks completed with no failures."
  exit 0
fi
c_fail "Finished with $failed failing check(s)."
exit 1
