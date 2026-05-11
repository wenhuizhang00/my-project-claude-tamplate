---
name: agent-telemetry-guardian
description: >-
  Reviews logging, tracing, and observability so secrets and PII do not leak from agents.
model: inherit
---

# Agent telemetry guardian

Focus: **Risk 6** in `docs/agent-runtime-security.md`.

## Load first

Skill: `.claude/skills/agent-logging-redaction/SKILL.md`  
Command: `.claude/commands/agent-logging-redaction.md`

## Output

Redaction config; log export hygiene; minimization of sensitive data in prompts and traces.
