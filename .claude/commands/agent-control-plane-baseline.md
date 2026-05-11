# /agent-control-plane-baseline — Listen surfaces and auth

Use when configuring how the **agent API**, **dashboard**, or **debug/automation** ports listen on hosts or clusters.

## Run checks (this repo)

```bash
./scripts/agent-runtime/checks/10-listeners.sh
```

Optional: tune `AGENT_WATCH_PORTS` and `STRICT_LISTENERS=1` in `scripts/agent-runtime/config.env` (copy from `config.env.example`).

## Checklist

- [ ] Control plane listens on **loopback** or **private** network only, or sits behind an authenticated reverse proxy / API gateway
- [ ] **TLS** and **strong auth** for every remote path (no anonymous control)
- [ ] Debug / CDP / remote-control ports bound to **localhost** when enabled
- [ ] **mDNS / LAN discovery** disabled unless required
- [ ] Firewall or security group rules **deny-by-default** for management ports
- [ ] After changes, re-run `./scripts/agent-runtime/checks/10-listeners.sh`

## Pair with

- Skill: `.claude/skills/agent-access-control/SKILL.md`
- Agent: `.claude/agents/agent-access-guardian.md`

Mitigations **【1-1】–【1-3】** — `docs/agent-runtime-security.md`.
