#!/usr/bin/env bash
# PreToolUse: optional gate on tool calls. stdin is JSON from Claude Code.
# Add policy checks here (fail closed only after validating hook contract for your Claude Code version).
set -euo pipefail
if ! [ -t 0 ]; then
  cat >/dev/null
fi
exit 0
