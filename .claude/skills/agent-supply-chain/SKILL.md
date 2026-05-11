---
name: agent-supply-chain
description: >-
  Secure the supply chain for agent plugins, MCP servers, IDE extensions, and container
  images: pin versions, scan, and review egress.
---

# Agent supply chain

## Scope

Mitigations **【3-1】**, **【3-2】**.

## Workflow

1. Keep the **runtime and CLI** patched.
2. After adding or upgrading any integration: review source, run **SAST/SCA** if available, inspect declared permissions.
3. Prefer **internal mirrors** or **curated registries** with admission control.
4. Model third-party tools as **running arbitrary code** beside your data.

## Reference

`docs/agent-runtime-security.md` (Risk 3). Command: `.claude/commands/agent-runtime-audit.md`. Agent: `.claude/agents/agent-supply-chain-guardian.md`.

## Runnable scripts

`./scripts/agent-runtime/run-all.sh` or `./scripts/agent-runtime/checks/26-gitleaks.sh` — install [gitleaks](https://github.com/gitleaks/gitleaks) first. Copy `config.env.example` and set `STRICT_GITLEAKS=1` in CI to require the binary.
