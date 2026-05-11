# Agent runtime tooling (general)

Repeatable **playbooks** live in `.claude/commands/agent-*.md`. **Executable** checks live in **`scripts/agent-runtime/`**.

## Run everything

```bash
make agent-checks
# or
./scripts/agent-runtime/run-all.sh
```

Details: **`scripts/agent-runtime/README.md`**.

| Command | Topic |
|---------|--------|
| `agent-runtime-audit.md` | Updates and supply-chain checks |
| `agent-control-plane-baseline.md` | Listen addresses, auth, discovery |
| `agent-prompt-policy-checklist.md` | Prompts, memory, injection |
| `agent-channel-policy.md` | Chat, webhooks, ingress |
| `agent-tool-sandbox-hardening.md` | Sandboxing and tool allowlists |
| `agent-logging-redaction.md` | Logs and traces |

Canonical narrative: **`docs/agent-runtime-security.md`**. Scripts in **`scripts/agent-runtime/`** include [Gitleaks](https://github.com/gitleaks/gitleaks) when installed.
