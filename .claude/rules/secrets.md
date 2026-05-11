# Secrets and credentials

## Prohibited in repository

- API keys, OAuth client secrets, passwords, private keys (RSA, EC, Ed25519, etc.), `.pem` / `.key` material.
- Long-lived cloud **access keys** or **connection strings** that embed passwords.
- **Session tokens**, refresh tokens, or cookies copied from a real session.

Use **placeholders** in examples: `YOUR_API_KEY`, `changeme`, or documented fake values.

## Where secrets belong

- **Development**: local `.env` (gitignored) or a team-approved secret manager.
- **CI/CD**: platform secret stores and **OIDC via BloxID** to assume short-lived cloud roles where supported—avoid long-lived access keys in pipelines.
- **Production**: managed secret rotation (cloud KMS, vault, or platform-native secrets).

## Environment variables

- Provide **`.env.example`** (or equivalent) listing **names only**, with safe example values or empty placeholders.
- Validate presence of required secrets **at startup** with clear failure messages (no secret values in logs).

## Key handling

- Prefer **short-lived credentials** and **scoped IAM** over broad master keys.
- Plan **rotation**: document owner, frequency, and rollback for each secret type.

## Git hygiene

- If a secret is ever committed, **rotate** it immediately; removing the commit from history does not revoke the credential.

## Claude Code workflow

- Do not paste secrets into prompts, `CLAUDE.md`, `CLAUDE.local.md`, or rules files.
- When generating sample configs, use **obviously non-production** sample values.
