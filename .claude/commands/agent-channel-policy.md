# /agent-channel-policy — Messengers, webhooks, bridges

Use when connecting **Slack**, **Teams**, **Discord**, **Telegram**, **email**, **HTTP webhooks**, or similar to an LLM agent.

## Run checks (this repo)

There is no single portable “bot config” scanner; rely on review + secrets hygiene:

```bash
./scripts/agent-runtime/checks/20-git-tracked-secret-files.sh
./scripts/agent-runtime/checks/25-git-hook-patterns.sh
```

Ensure bot tokens live in env/secret managers, not in tracked files.

## Policy steps

1. Decide **who may trigger** the agent (identified users, workspace allowlist, signing secret on webhooks).
2. Prefer **DM pairing** or **per-sender approval** for high-risk bots.
3. Restrict **group / channel** usage—require **mentions** or **explicit allowlists** where platforms support it.
4. Apply **least OAuth / API scope** on the platform.
5. Add **rate limiting** and **abuse** metrics (latency, token use, failed auth).

## Pair with

- Skill: `.claude/skills/agent-channel-ingress/SKILL.md`
- Agent: `.claude/agents/agent-ingress-guardian.md`

Mitigation **【4-1】** — `docs/agent-runtime-security.md`.
