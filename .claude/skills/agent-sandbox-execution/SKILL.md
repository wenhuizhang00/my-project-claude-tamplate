---
name: agent-sandbox-execution
description: >-
  Sandbox or least-privilege execution for agent tools: shells, file access, browsers,
  and cloud APIs—across vendor implementations.
---

# Agent sandbox and tool execution

## Scope

Mitigations **【5-1】**, **【5-2】**.

## Practices

1. Default-deny **tools**; enable only what the workload needs.
2. Run destructive or network-capable tools in **containers** or **locked-down** service accounts.
3. Isolate **browser** sessions from host filesystem and internal IPs unless strictly required.
4. Map tool permissions to **IAM** roles with least privilege.

## Reference

`docs/agent-runtime-security.md` (Risk 5). Command: `.claude/commands/agent-tool-sandbox-hardening.md`. Agent: `.claude/agents/agent-execution-guardian.md`.
