#!/usr/bin/env bash
# Detect TCP listeners bound to all interfaces (* or 0.0.0.0) — common agent risk.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
# shellcheck source=scripts/agent-runtime/lib/common.sh
source "${ROOT}/scripts/agent-runtime/lib/common.sh"
_load_config

: "${AGENT_WATCH_PORTS:=8443,9222,18789,3000,7681}"
: "${STRICT_LISTENERS:=0}"

IFS=',' read -ra PORTS <<< "$AGENT_WATCH_PORTS"
exit_code=0

if ! command -v lsof >/dev/null 2>&1; then
  c_warn "lsof not found — skipping listener check (install lsof or use full run-all on macOS/Linux)."
  exit 0
fi

c_info "Scanning TCP listeners (public bind) — watch ports: ${AGENT_WATCH_PORTS}"

# Lines where NAME column shows *:port or 0.0.0.0:port
# lsof -nP avoids DNS; -iTCP -sTCP:LISTEN for listeners only
PUB_LINES=()
while IFS= read -r line; do
  PUB_LINES+=("$line")
done < <(lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | grep -E '(\*|0\.0\.0\.0):[0-9]+' || true)

if [[ ${#PUB_LINES[@]} -eq 0 ]]; then
  c_ok "No TCP listeners found on * / 0.0.0.0 (or lsof had no matches)."
  exit 0
fi

printf '%s\n' "--- listeners on all interfaces (sample) ---"
printf '%s\n' "${PUB_LINES[@]}" | head -n 40
[[ ${#PUB_LINES[@]} -gt 40 ]] && c_info "... ($(( ${#PUB_LINES[@]} - 40 )) more lines truncated)"

for p in "${PORTS[@]}"; do
  p="${p// /}"
  [[ -z "$p" ]] && continue
  if printf '%s\n' "${PUB_LINES[@]}" | grep -E "[:.]${p} \(LISTEN\)|[:.]${p}$" >/dev/null 2>&1; then
    c_warn "Port ${p} appears to listen on a public bind — verify agent control plane / debug is intended."
    if [[ "$STRICT_LISTENERS" == "1" ]]; then
      c_fail "STRICT_LISTENERS=1 and watched port ${p} is public."
      exit_code=1
    fi
  fi
done

exit "$exit_code"
