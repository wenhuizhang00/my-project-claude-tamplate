#!/usr/bin/env bash
# Run npm audit when Node project detected.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
_load_config
: "${STRICT_NPM_AUDIT:=0}"
cd "$ROOT"

[[ -f package.json ]] || { c_ok "No package.json — skip npm audit."; exit 0; }
command -v npm >/dev/null 2>&1 || { c_warn "npm not found — skip."; exit 0; }

if [[ ! -f package-lock.json ]] && [[ ! -f pnpm-lock.yaml ]] && [[ ! -f yarn.lock ]]; then
  c_warn "package.json without a lockfile — pin dependencies in CI."
  exit 0
fi

c_info "Running npm audit (production deps)..."
set +e
out=$(npm audit --omit=dev 2>&1)
code=$?
set -e
printf '%s\n' "$out" | tail -n 25

if [[ "$code" -ne 0 ]]; then
  if [[ "$STRICT_NPM_AUDIT" == "1" ]]; then
    c_fail "npm audit reported issues (STRICT_NPM_AUDIT=1)."
    exit 1
  fi
  c_warn "npm audit exit $code — review above (set STRICT_NPM_AUDIT=1 to fail CI)."
  exit 0
fi

c_ok "npm audit reported no issues (or only informational)."
exit 0
