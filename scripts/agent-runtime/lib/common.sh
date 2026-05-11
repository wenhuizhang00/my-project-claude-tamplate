# shellcheck shell=bash
# Shared helpers for agent-runtime checks. Source after cd to repo root.
# Resolves repo root from: scripts/agent-runtime/lib/common.sh
export RT_AGENT_ROOT
RT_AGENT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

c_info()  { printf '\033[0;36m[INFO]\033[0m %s\n' "$*"; }
c_warn()  { printf '\033[0;33m[WARN]\033[0m %s\n' "$*"; }
c_fail()  { printf '\033[0;31m[FAIL]\033[0m %s\n' "$*"; }
c_ok()    { printf '\033[0;32m[ OK ]\033[0m %s\n' "$*"; }

# load optional local config (copy from config.env.example)
_load_config() {
  local f="${RT_AGENT_ROOT}/scripts/agent-runtime/config.env"
  if [[ -f "$f" ]]; then
    # shellcheck source=/dev/null
    set -a
    source "$f"
    set +a
    c_info "Loaded $f"
  fi
}
