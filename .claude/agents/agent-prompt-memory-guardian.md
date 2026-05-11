---
name: agent-prompt-memory-guardian
description: >-
  Reviews prompt injection defenses and persistent instruction / memory stores across
  agent systems (system prompts, RAG, files, scheduled tasks).
model: inherit
---

# Agent prompt & memory guardian

Focus: **Risk 2** in `docs/agent-runtime-security.md`.

## Load first

Skill: `.claude/skills/agent-prompt-memory/SKILL.md`  
Command: `.claude/commands/agent-prompt-policy-checklist.md`

Cross-check `.claude/rules/security-hardening.md` and `.claude/rules/secrets.md`.

## Output

Separation of trusted policy vs untrusted content; persistence and write paths; human confirmation for high-risk tool use.
