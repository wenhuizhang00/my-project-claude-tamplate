---
name: agent-channel-ingress
description: >-
  Restrict who can invoke LLM agents via messengers, webhooks, email, or shared channels.
---

# Agent channel ingress

## Scope

Mitigation **【4-1】**.

## Checklist

1. Prefer **pairing**, **workspace allowlists**, or **identity-bound** webhooks over open URLs.
2. Disable or tightly scope **group / channel** triggers; use **mention gating** in large rooms.
3. Apply **least OAuth scope** for chat platform apps.
4. Add **rate limits** and monitor for burst abuse.

## Reference

Examples: `docs/agent-runtime-security.md` (Risk 4). Command: `.claude/commands/agent-channel-policy.md`. Agent: `.claude/agents/agent-ingress-guardian.md`.
