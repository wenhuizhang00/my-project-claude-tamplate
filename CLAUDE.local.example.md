# Local-only context (copy to `CLAUDE.local.md`)

This file is a **template**. Copy to `CLAUDE.local.md` (gitignored) for paths and preferences that must not be shared.

## Allowed here

- Local toolchain paths (e.g. where your SDK or profile lives).
- Optional feature flags for your machine only.
- Links to internal docs that are not in this repo.

## Never put here

- API keys, tokens, passwords, or private keys.
- Connection strings with credentials.
- Customer or personal data.

If you need secrets at runtime, use `.env` (gitignored) and `*.env.example` for non-secret variable names only.
