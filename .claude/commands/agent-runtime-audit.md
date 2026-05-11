# /agent-runtime-audit — Patch and integration review

Use after **runtime upgrades** or when adding **plugins / MCP servers / extensions**.

## Run checks (this repo)

From the repository root:

```bash
./scripts/agent-runtime/run-all.sh
```

Includes git secret patterns, **[Gitleaks](https://github.com/gitleaks/gitleaks)** (if installed), optional `npm audit` when `package.json` exists, and MCP JSON validation. Tighten CI with `scripts/agent-runtime/config.env` (`STRICT_NPM_AUDIT=1`, `STRICT_GITLEAKS=1`). See **`scripts/agent-runtime/README.md`**.

## Manual steps

1. Update the agent runtime, SDK, or CLI to a **pinned**, supported release.
2. Refresh lockfiles / image digests in CI.
3. Run vendor-supplied **security audit**, **lint**, or **policy** commands if they exist.
4. For each new integration, scan with **SAST/SCA** in CI and read **network + filesystem** usage in code.
5. Document risk acceptance for any skipped checks.

## Pair with

- Skill: `.claude/skills/agent-supply-chain/SKILL.md`
- Agent: `.claude/agents/agent-supply-chain-guardian.md`

Mitigations **【3-1】**, **【3-2】** — `docs/agent-runtime-security.md`.
