#!/usr/bin/env bash
# Fail if obvious secret material is tracked by git.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
source "${ROOT}/scripts/agent-runtime/lib/common.sh"

cd "$ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  c_warn "Not a git repo — skipping git secret-path check."
  exit 0
fi

exit_code=0
bad=()

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  bad+=("$f")
done < <(git ls-files | grep -E '\.(pem|p12|pfx|key)$|(^|/)\.env$|(^|/)id_rsa$|(^|/)credentials(\.json)?$' || true)

if [[ ${#bad[@]} -gt 0 ]]; then
  c_fail "Tracked files look like keys or .env — remove from git and rotate secrets if they were real:"
  printf '  %s\n' "${bad[@]}"
  exit_code=1
else
  c_ok "No high-risk secret filenames tracked (.pem, .env, id_rsa, …)."
fi

exit "$exit_code"
