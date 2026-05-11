# Tests and verification

Align automated checks with this repository's tooling. Prefer the same commands contributors and CI use.

## When to run

- After **security-sensitive** changes: auth, crypto, parsers, file uploads, deserialization, SQL/builders, shell usage.
- Before opening a PR: run **format**, **lint**, **typecheck**, and **unit tests** if the project defines them.

## Categories

- **Static analysis**: linters, type checkers, SAST tools already configured in CI.
- **Unit tests**: pure logic, permission checks, input validation.
- **Integration tests**: DB migrations, API contracts, auth flows in a controlled environment.
- **Security regression tests**: replay known bug cases (path traversal, IDOR, injection) where applicable.

## Secure test data

- Do not use **production data** in tests; use fixtures or synthetic data.
- Avoid **real secrets** in test configs; use test-only keys or fakes provided by the stack (e.g. JWT test keys).

## Flaky and slow tests

- Do not weaken security to make tests pass (e.g. disabling TLS verification); fix the harness instead.

## Agent-runtime template checks

This repository includes **`make agent-checks`** (runs `scripts/agent-runtime/run-all.sh`). Use it when changing agent tooling, MCP config, or anything that could affect listeners or tracked secrets. Install **[Gitleaks](https://github.com/gitleaks/gitleaks)** for full secret scanning in that suite (`brew install gitleaks`; set `STRICT_GITLEAKS=1` in CI when gitleaks is installed). Not a substitute for your app’s full test suite.

## Definition of done

- New externally reachable behavior has **automated coverage** or an explicit, time-bounded follow-up issue.
- Failing security-related tests **block merge** when CI enforces them.
