#!/usr/bin/env bash
# Heuristic: ensure project policy files mention untrusted / injection concepts.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
cd "$ROOT"

candidates=( "CLAUDE.md" ".claude/rules/security-hardening.md" "docs/agent-runtime-security.md" )
found=0
for c in "${candidates[@]}"; do
  [[ -f "$c" ]] || continue
  found=1
  if grep -qiE 'untrusted|injection|least privilege|secret' "$c"; then
    c_ok "Policy file mentions security basics: $c"
  else
    c_warn "Policy file may lack injection/untrusted guidance: $c"
  fi
done

if [[ "$found" -eq 0 ]]; then
  c_warn "No standard policy files found for heuristic scan."
fi
exit 0
