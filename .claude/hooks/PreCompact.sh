#!/usr/bin/env bash
# PreCompact: runs before context compaction; keep fast and side-effect free.
set -euo pipefail
if ! [ -t 0 ]; then
  cat >/dev/null
fi
exit 0
