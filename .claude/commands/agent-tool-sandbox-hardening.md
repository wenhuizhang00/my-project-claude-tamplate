# /agent-tool-sandbox-hardening — Tools and browser isolation

Use when agents can invoke **shell**, **filesystem**, **HTTP**, **databases**, or **browsers**.

## Run checks (this repo)

```bash
./scripts/agent-runtime/checks/60-docker-socket-warning.sh
./scripts/agent-runtime/run-all.sh
```

`60-docker-socket-warning.sh` flags risky `DOCKER_HOST` values. Use full `run-all` for listeners / npm audit as well.

## General isolation

1. Run tool workers under **dedicated** users, containers, or sandboxes with **read-only** roots where possible.
2. Maintain explicit **allow/deny** lists for tools and external endpoints.
3. Map cloud actions to **narrow IAM** roles; forbid wildcard credentials in the agent environment.

## Browser / desktop automation

1. Use isolated **browser profiles** or **headless** containers; disable remote debugging on `0.0.0.0`.
2. Block or proxy **egress** to metadata endpoints and internal IPs unless required.

## Pair with

- Skill: `.claude/skills/agent-sandbox-execution/SKILL.md`
- Agent: `.claude/agents/agent-execution-guardian.md`

Mitigations **【5-1】**, **【5-2】** — `docs/agent-runtime-security.md`.
