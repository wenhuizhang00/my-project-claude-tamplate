# Claude Code project template

This repository is a **starter layout for [Claude Code](https://claude.ai/code)**-style workflows: shared agent instructions, reusable skills, and policies aimed at **secure-by-default** development. Use it as a base when you want consistent AI-assisted coding without baking secrets or ad-hoc prompts into the tree.

## What is in here

| Area | Purpose |
|------|---------|
| `CLAUDE.md` | Main project instructions for the assistant (scope, security bar, conventions). |
| `CLAUDE.local.example.md` | Template for **local-only** notes; copy to `CLAUDE.local.md` (gitignored). |
| `.claude/rules/` | Topic rules: APIs, secrets, infrastructure, tests, and general **security hardening**. |
| `.claude/commands/` | Slash-style workflows (ship, security review, threat model, **agent-runtime** playbooks, …). |
| `.claude/agents/` | Agent briefs (code review, security review, **agent-\*-guardian** personas, …). |
| `.claude/skills/` | Packaged skills (`secure-coding`, `threat-modeling`, `incident-response`, **`agent-*`**, …). |
| `.claude/hooks/` | Session/tool lifecycle shell hooks you can extend for auditing or policy. |
| `.claude/output-styles/` | Output tone (e.g. `terse.md` for brief, actionable replies). |
| `.mcp.json` | MCP server configuration (empty placeholder; add your integrations here). |
| `settings.local.example.json` | Example for optional local settings; copy to `settings.local.json` (gitignored). |
| `plugins/vercel/` | Placeholder for Vercel-related plugin or scripts when you wire them up. |
| `docs/agent-runtime-security.md` | **Vendor-agnostic** LLM agent hardening (risks **【1-1】–【6-1】**) + links to runnable checks. |
| `scripts/agent-runtime/` | **Executable** `bash` checks: `run-all.sh`, `checks/*.sh`; read **`scripts/agent-runtime/README.md`**. |
| `Makefile` | `make agent-checks` runs the full script bundle. |
| `.claude/agents/agent-*-guardian.md` | Six guardians for agent-runtime topics (access, prompt/memory, supply chain, ingress, execution, telemetry). |
| `.claude/skills/agent-*/SKILL.md` | Six skills aligned with those areas. |
| `.claude/commands/agent-*.md` | Repeatable runbooks (audit, control plane, prompt policy, channels, sandbox, logging). |
| `.claude/tools/agent-runtime/README.md` | Index mapping commands ↔ skills ↔ guardians. |

## LLM agent runtime hardening (general)

Applies to **any** product that runs LLM agents with tools, integrations, and observability—not one vendor.

### Reference doc

- **[docs/agent-runtime-security.md](docs/agent-runtime-security.md)** — Full risk register, deployment patterns, and enterprise themes.

### Guardian agents

| Focus | File |
|--------|------|
| Control plane / listen / auth | `.claude/agents/agent-access-guardian.md` |
| Prompt injection / memory | `.claude/agents/agent-prompt-memory-guardian.md` |
| Plugins, MCP, supply chain | `.claude/agents/agent-supply-chain-guardian.md` |
| Chat, webhooks, ingress | `.claude/agents/agent-ingress-guardian.md` |
| Sandboxing / tools | `.claude/agents/agent-execution-guardian.md` |
| Logs / traces / redaction | `.claude/agents/agent-telemetry-guardian.md` |

### Skills

| Topic | Path |
|-------|------|
| Access & control plane | `.claude/skills/agent-access-control/SKILL.md` |
| Prompt & memory | `.claude/skills/agent-prompt-memory/SKILL.md` |
| Supply chain | `.claude/skills/agent-supply-chain/SKILL.md` |
| Ingress | `.claude/skills/agent-channel-ingress/SKILL.md` |
| Sandbox / execution | `.claude/skills/agent-sandbox-execution/SKILL.md` |
| Logging | `.claude/skills/agent-logging-redaction/SKILL.md` |

### Commands (playbooks)

| Command | Path |
|---------|------|
| Patch & integration audit | `.claude/commands/agent-runtime-audit.md` |
| Control plane baseline | `.claude/commands/agent-control-plane-baseline.md` |
| Prompt / memory policy | `.claude/commands/agent-prompt-policy-checklist.md` |
| Channel / webhook policy | `.claude/commands/agent-channel-policy.md` |
| Tool sandbox | `.claude/commands/agent-tool-sandbox-hardening.md` |
| Logging redaction | `.claude/commands/agent-logging-redaction.md` |

Index: **`.claude/tools/agent-runtime/README.md`**.

### Executable checks

```bash
make agent-checks
```

Uses `scripts/agent-runtime/run-all.sh` (listeners, git patterns, **Gitleaks** if installed, MCP JSON, optional npm audit, …). Configure via `scripts/agent-runtime/config.env.example` → `config.env` (`STRICT_GITLEAKS`, etc.).

## Quick start

1. Read `CLAUDE.md` so the assistant follows this repo’s expectations.
2. Copy `CLAUDE.local.example.md` → `CLAUDE.local.md` for machine-specific paths (never commit secrets).
3. Fill `.mcp.json` if you use MCP tools; register hooks in Claude Code if your version requires hook wiring.
4. Add your application code alongside this layout; keep secrets in environment variables or a secret manager, not in git.

This template does **not** prescribe a programming language or framework—the rules are written to layer on top of whatever stack you choose.
