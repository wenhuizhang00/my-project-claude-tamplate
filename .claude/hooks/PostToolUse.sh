#!/usr/bin/env bash
# PostToolUse: audit or follow-up. stdin is JSON. Must not leak sensitive data.
set -euo pipefail
if ! [ -t 0 ]; then
  cat >/dev/null
fi
exit 0
