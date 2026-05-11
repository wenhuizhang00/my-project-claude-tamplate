#!/usr/bin/env bash
# SessionStart: optional environment or banner. Keep stdout clean for Claude Code.
set -euo pipefail
if ! [ -t 0 ]; then
  cat >/dev/null
fi
exit 0
