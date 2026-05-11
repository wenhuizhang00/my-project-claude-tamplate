# Runnable agent-runtime checks

POSIX **bash** scripts in this folder perform quick, local security checks that apply to **any** LLM agent / dev environment — not one vendor.

## One command

From the **repository root**:

```bash
chmod +x scripts/agent-runtime/run-all.sh scripts/agent-runtime/checks/*.sh   # once
./scripts/agent-runtime/run-all.sh
```

Or via Make:

```bash
make agent-checks
```

## Configuration (optional)

```bash
cp scripts/agent-runtime/config.env.example scripts/agent-runtime/config.env
# Edit AGENT_WATCH_PORTS, STRICT_LISTENERS, STRICT_NPM_AUDIT, STRICT_GITLEAKS
```

`config.env` is gitignored.

## What runs

| Script | Role |
|--------|------|
| `checks/10-listeners.sh` | `lsof` for TCP listeners on `*` / `0.0.0.0`; optional **strict** fail for watched ports |
| `checks/20-git-tracked-secret-files.sh` | fail if `.pem`, tracked `.env`, `id_rsa`, etc. |
| `checks/25-git-hook-patterns.sh` | `git grep` for PEM keys (fail), AKIA pattern (warn) |
| `checks/26-gitleaks.sh` | **[Gitleaks](https://github.com/gitleaks/gitleaks)** `detect` over the repo; optional `STRICT_GITLEAKS` |
| `checks/30-mcp-json.sh` | validate `.mcp.json` with `python3` or `jq` |
| `checks/40-node-audit.sh` | `npm audit --omit=dev` when `package.json` exists |
| `checks/50-prompt-policy-heuristic.sh` | sanity check that policy docs mention security keywords |
| `checks/60-docker-socket-warning.sh` | warn on non-local `DOCKER_HOST` |

Exit code **0** means no **failed** check. Warnings may still print (e.g. `npm audit` when `STRICT_NPM_AUDIT=0`).

## CI

Set:

```bash
export STRICT_LISTENERS=1
export STRICT_NPM_AUDIT=1
export STRICT_GITLEAKS=1   # after: brew install gitleaks  (or CI image with gitleaks)
```

and run `run-all.sh` so risky public binds, npm findings, and **missing gitleaks** (when strict) fail the job.

Install **gitleaks** for secret scanning: [gitleaks](https://github.com/gitleaks/gitleaks) (`brew install gitleaks` on macOS). Optional repo config: **`.gitleaks.toml`** (allowlist / paths).

## Individual checks

```bash
./scripts/agent-runtime/checks/10-listeners.sh
```

Requires macOS or Linux with `bash`, `git`, `lsof` (optional), **`gitleaks`** (optional locally; recommended in CI—use `STRICT_GITLEAKS=1` to require it), `python3` or `jq` for MCP JSON.
