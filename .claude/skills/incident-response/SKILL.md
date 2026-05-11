---
name: incident-response
description: >-
  Structured response guidance for suspected security incidents: contain, eradicate,
  recover, and document. Use for possible credential leaks, active exploits, or
  confirmed breaches in environments connected to this codebase.
---

# Incident response (engineering)

This skill guides **technical** steps for services this repo deploys. Legal, PR, and executive comms are out of scope.

## Phase 1 — Contain

- **Revoke** exposed or suspected credentials immediately (rotate keys, invalidate sessions, disable compromised accounts).
- **Block** malicious IPs or patterns at the WAF or edge if under active abuse (temporary, logged changes).
- **Preserve** relevant logs and artifacts **before** they rotate away (copy to secure, access-controlled storage).

## Phase 2 — Eradicate

- Identify **root cause** (vulnerable dependency, misconfig, stolen token, SQLi, etc.).
- Patch or **redeploy** from a known-good state; verify hashes and build provenance for critical images.

## Phase 3 — Recover

- Restore services with **monitoring** enhanced around the failure mode.
- Confirm **secrets** are rotated everywhere they might have leaked (DB passwords, API keys, signing keys as applicable).

## Phase 4 — Document

- **Timeline** of detection, actions, and customer impact (internal doc as required by policy).
- **Lessons** and backlog items: tests, alerts, hardening from `.claude/rules/security-hardening.md`.

## Rules

- Do **not** exfiltrate production data into tickets or chat; use approved tools.
- Assume **chat and email** may be part of the blast radius if credentials were pasted.

Escalate to the organization's **security operations** channel per internal policy when indicators suggest active compromise beyond a single leaked token.
