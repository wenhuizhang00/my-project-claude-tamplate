#!/usr/bin/env bash
# Secret scanning with gitleaks (https://github.com/gitleaks/gitleaks).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
_load_config
: "${STRICT_GITLEAKS:=0}"

cd "$ROOT"

if ! command -v gitleaks >/dev/null 2>&1; then
  if [[ "$STRICT_GITLEAKS" == "1" ]]; then
    c_fail "gitleaks is not installed but STRICT_GITLEAKS=1. Install: brew install gitleaks or https://github.com/gitleaks/gitleaks"
    exit 1
  fi
  c_warn "gitleaks not in PATH — skip. Install: brew install gitleaks (or see https://github.com/gitleaks/gitleaks)"
  exit 0
fi

config_args=()
if [[ -f "$ROOT/.gitleaks.toml" ]]; then
  config_args=(--config "$ROOT/.gitleaks.toml")
  c_info "Using $ROOT/.gitleaks.toml"
fi

c_info "Running gitleaks detect (git history + working tree)…"
set +e
# --verbose prints findings; exit 1 if leaks
out=$(gitleaks detect "${config_args[@]}" --source "$ROOT" --verbose 2>&1)
rc=$?
set -e

if [[ "$rc" -ne 0 ]]; then
  c_fail "gitleaks reported potential secrets (exit $rc):"
  printf '%s\n' "$out" | tail -n 60
  exit 1
fi

c_ok "gitleaks detect: no leaks found."
exit 0
