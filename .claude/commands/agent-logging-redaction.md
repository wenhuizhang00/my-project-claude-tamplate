# /agent-logging-redaction — Observability hygiene

Use when configuring **logs**, **traces**, **metrics**, or exporting **debug bundles** from agent services.

## Run checks (this repo)

Validate that high-signal secrets are not committed (often the first place leaks appear):

```bash
./scripts/agent-runtime/checks/20-git-tracked-secret-files.sh
./scripts/agent-runtime/checks/25-git-hook-patterns.sh
```

For runtime log pipelines, configure redaction in your observability stack (no generic script can know every vendor format).

## Steps

1. Enable **redaction** middleware or sidecar rules for tokens, cookies, `Authorization`, API keys in query strings.
2. Confirm your **APM / LLM trace** products scrub prompts if they may contain secrets.
3. Restrict access to raw traces with **RBAC**; time-bound **download** links for support.
4. Never paste production secrets into chats or tickets—even for debugging.

## Pair with

- Skill: `.claude/skills/agent-logging-redaction/SKILL.md`
- Agent: `.claude/agents/agent-telemetry-guardian.md`

Mitigation **【6-1】** — `docs/agent-runtime-security.md`.
