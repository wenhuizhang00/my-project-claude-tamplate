---
name: agent-logging-redaction
description: >-
  Prevent secrets and sensitive PII from appearing in logs, traces, or exported debug
  bundles from LLM agent runs.
---

# Agent logging and redaction

## Scope

Mitigation **【6-1】**.

## Checklist

1. Enable **redaction** in log and trace pipelines (tokens, cookies, `Authorization`, signing keys).
2. Keep `.env` and key files **out of repos**; restrict file permissions on servers.
3. Scrub artifacts before sharing with vendors or in tickets.
4. Minimize secret material in **prompts** and **few-shot** examples.

## Reference

`docs/agent-runtime-security.md` (Risk 6). Command: `.claude/commands/agent-logging-redaction.md`. Agent: `.claude/agents/agent-telemetry-guardian.md`.
