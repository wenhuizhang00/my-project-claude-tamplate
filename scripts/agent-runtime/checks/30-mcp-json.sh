#!/usr/bin/env bash
# Validate .mcp.json if present.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
cd "$ROOT"

f=".mcp.json"
[[ -f "$f" ]] || { c_ok "No .mcp.json — skip."; exit 0; }

if command -v python3 >/dev/null 2>&1; then
  if python3 -c "import json,sys; json.load(open('$f'))" 2>/dev/null; then
    c_ok ".mcp.json is valid JSON."
    exit 0
  fi
  c_fail ".mcp.json is not valid JSON."
  exit 1
fi

if command -v jq >/dev/null 2>&1; then
  jq -e . "$f" >/dev/null && { c_ok ".mcp.json validates with jq."; exit 0; }
  c_fail ".mcp.json failed jq validation."
  exit 1
fi

c_warn "Neither python3 nor jq found — cannot validate .mcp.json."
exit 0
