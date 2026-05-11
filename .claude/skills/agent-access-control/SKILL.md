---
name: agent-access-control
description: >-
  Harden control plane and debug exposure for LLM agent deployments: listen addresses,
  TLS/auth, discovery off by default. Vendor-agnostic.
---

# Agent access control

## Scope

Mitigations **【1-1】–【1-3】** — any product that exposes an HTTP/WebSocket API or debug port for driving the agent.

## Checklist

1. Bind admin and agent APIs to **loopback** or **private** subnets; put a reverse proxy with auth in front for remote access.
2. Require **authentication** for every control endpoint; forbid anonymous LAN access in production.
3. Restrict **browser/debug automation** ports to localhost.
4. Turn off **mDNS/broadcast** unless you explicitly need device discovery.
5. After changes, run your stack’s **security audit** or **config validation** if the vendor provides it.

## Reference

`docs/agent-runtime-security.md` (Risk 1). Pair with `.claude/agents/agent-access-guardian.md`.

## Runnable scripts

`./scripts/agent-runtime/checks/10-listeners.sh` — requires `lsof`. Optional: `scripts/agent-runtime/config.env` with `AGENT_WATCH_PORTS` and `STRICT_LISTENERS`.
