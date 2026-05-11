# Project context for Claude Code

This repository uses a **secure-by-default** workflow. Treat every change as production-bound unless explicitly marked experimental.

## How to work in this repo

1. Read `.claude/rules/` before implementing APIs, infrastructure, or anything handling auth, data, or secrets.
2. Prefer small, reviewable diffs; do not refactor unrelated code.
3. Match existing naming, formatting, and test patterns in the codebase.
4. After substantive edits, run the checks described in `.claude/rules/tests.md`.

## Local overrides

Copy `CLAUDE.local.example.md` to `CLAUDE.local.md` for **machine-specific** paths or preferences. Never put secrets in either file.

## Security expectations

- **No secrets** in source, docs, or examples committed to git. Use environment variables and secret managers.
- **Validate all external input** (HTTP, CLI, files, queues). Assume hostile input.
- **Least privilege** for IAM, DB roles, and process users.
- **Logging**: no PII or tokens in logs; redact when unsure.

## Conventions

- **Language**: Use the stack already present in the repo; do not introduce new runtimes without an explicit decision.
- **Formatting**: Follow project formatters/linters; keep line length and style consistent with surrounding files.
- **Dependencies**: Pin versions where the project already does; review supply-chain impact for new packages.

For command and agent shortcuts, see `.claude/commands/` and `.claude/agents/`.

## LLM agent runtime security

When reviewing **any** LLM agent stack (tooling, ingress, sandboxes, plugins/MCP, observability), use **`docs/agent-runtime-security.md`**, **`.claude/skills/agent-*/`**, **`.claude/agents/agent-*-guardian.md`**, and **`.claude/commands/agent-*.md`** (index: `.claude/tools/agent-runtime/README.md`). Run **`make agent-checks`** or **`./scripts/agent-runtime/run-all.sh`** for executable local checks. Pick the guardian that matches the risk area instead of folding everything into one pass.
