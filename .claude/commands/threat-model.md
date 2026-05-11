# /threat-model — Lightweight threat modeling command

Produce a **practical** threat model for a feature or component in this repo.

## Inputs (ask if missing)

- Asset being protected (data, capability, uptime).
- Actors (anonymous user, customer, insider, compromised dependency).
- Entry points (HTTP, CLI, queue, admin UI).

## Structure

1. **System overview** in 3–5 bullets (trust boundaries, data flows).
2. **STRIDE**-style table: Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation — list relevant threats only, not every category if N/A.
3. **Mitigations** mapped to threats (prevent, detect, respond).
4. **Residual risks** and decisions needed from humans (acceptable risk vs work required).

Cross-check assumptions with `.claude/rules/security-hardening.md` and `.claude/rules/infra.md` for deployment concerns.
