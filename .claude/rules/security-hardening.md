# Security hardening (general)

Use this as the baseline for design, code review, and automation in this repository.

## Threat model mindset

- Assume **untrusted networks** and **malicious clients**.
- Identify **trust boundaries** (browser, API gateway, service, database, third-party SaaS) and validate at each step.

## Secure defaults

- **Deny by default** for permissions, firewall rules, and feature flags affecting access.
- **Disable debug modes** and verbose errors in production builds.
- **Minimize attack surface**: remove unused endpoints, dependencies, and open ports.

## Input handling

- Treat all input as **untrusted** until validated: HTTP, CLI arguments, files, webhooks, message queues, environment (when influenced externally).
- Use **allow-lists** over deny-lists for parsers and business rules where feasible.
- Normalize encodings and enforce **size limits** before parsing.

## Output and disclosure

- Do not embed **secrets** in logs, metrics, traces, or client-visible errors.
- **Redact** tokens, cookies, `Authorization` headers, and PII by default in logs.

## Cryptography

- Use **vetted libraries** for hashing, encryption, signatures, and key derivation.
- Prefer **AEAD** for encryption at rest when application-level crypto is required; let the platform manage keys when possible.
- Never hard-code **keys or passwords**; load from a secret manager or environment injected at runtime.

## Dependencies and supply chain

- **Pin** dependency versions consistently with the rest of the repo.
- Review **licenses** and **maintenance** posture before adding packages.
- Run **SCA** and static analysis in CI as defined in `tests.md`.

## Denial of service

- Apply **timeouts**, **concurrency limits**, and **payload size limits** on public interfaces.
- Avoid **unbounded queries** and **regexes** susceptible to catastrophic backtracking on untrusted input.

## Incident readiness

- Ensure **audit logging** for security-relevant actions when the product requires accountability.
- Define **rotation** and **revocation** paths for credentials and tokens.
