---
name: secure-coding
description: >-
  Apply secure-by-default patterns while writing or reviewing code: input validation,
  authz, safe logging, crypto hygiene, and dependency caution. Load for any feature
  touching user data, trust boundaries, or external systems.
---

# Secure coding

## Before writing code

1. Identify **trust boundaries** and data classification for the change.
2. Read `.claude/rules/security-hardening.md` and the slice of `.claude/rules/api.md` relevant to your layer.

## Implementation checklist

- **Validate** all external input with schemas, size limits, and types; reject early.
- **Authorize** after authenticate; use resource-scoped checks, not role-only assumptions.
- **Parameterize** database queries; never concatenate untrusted input into SQL or shell commands.
- **Encode** output appropriately for HTML/JSON/SQL contexts when generating strings.
- **Avoid** logging credentials, raw tokens, full `Authorization` headers, or unredacted PII.
- **Use** vetted crypto libraries only; avoid custom protocols.

## Review quick-scan

- New dependencies: maintenance, license, transitive risk.
- New surface area: endpoints, file parsers, deserialization, redirects, SSRF-prone callbacks.

## Escalation

If the change touches **cryptographic protocol design**, **compliance** (HIPAA/PCI scope), or **organization-wide identity**, stop and request human security review even if code appears correct.
