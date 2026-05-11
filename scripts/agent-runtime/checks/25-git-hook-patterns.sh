#!/usr/bin/env bash
# Grep tracked text for a few high-signal secret patterns.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
cd "$ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exit 0
fi

if git grep -nE 'BEGIN (OPENSSH|RSA |EC )?PRIVATE KEY' -a >/dev/null 2>&1; then
  c_fail "Private key block detected in tracked files:"
  git grep -nE 'BEGIN (OPENSSH|RSA |EC )?PRIVATE KEY' -a | head -20 || true
  exit 1
fi

if git grep -nE 'AKIA[0-9A-Z]{16}' -a >/dev/null 2>&1; then
  c_warn "Possible AWS access key id (AKIA…) in tracked content — verify:"
  git grep -nE 'AKIA[0-9A-Z]{16}' -a | head -10 || true
fi

c_ok "No PEM private key blocks detected in git grep."
exit 0
