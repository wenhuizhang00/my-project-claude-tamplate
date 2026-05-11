#!/usr/bin/env bash
# Warn if DOCKER_HOST points to non-loopback TCP (common footgun for agent sandboxes).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"

if [[ -n "${DOCKER_HOST:-}" ]]; then
  if [[ "$DOCKER_HOST" =~ ^tcp://(127\.0\.0\.1|localhost) ]]; then
    c_ok "DOCKER_HOST is loopback."
  elif [[ "$DOCKER_HOST" =~ ^unix:// ]]; then
    c_ok "DOCKER_HOST is unix socket."
  else
    c_warn "DOCKER_HOST=$DOCKER_HOST — ensure remote Docker API is not exposed without TLS/auth."
  fi
else
  c_ok "DOCKER_HOST unset (default local socket on many setups)."
fi
exit 0
