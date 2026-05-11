---
name: threat-modeling
description: >-
  Facilitate lightweight STRIDE-style threat modeling and mitigation mapping for
  features or services. Use when designing new surfaces or reviewing architecture.
---

# Threat modeling

## Preparation

- Define **assets** (data, accounts, money movement, availability).
- Map **actors** and **entry points**.
- Sketch **data flows** across trust boundaries.

## Analysis

1. Walk STRIDE categories that apply (**S**poofing, **T**ampering, **R**epudiation, **I**nfo disclosure, **D**oS, **E**levation).
2. For each material threat, record **likelihood** and **impact** qualitatively.
3. Map **mitigations** (prevent / detect / respond). Prefer design-level fixes over brittle late validation.

## Alignment with repo rules

Cross-check outcomes with:

- `.claude/rules/security-hardening.md` for general controls.
- `.claude/rules/infra.md` when threats involve network or deployment.
- `.claude/rules/api.md` for HTTP/RPC abuse cases.

## Output

Produce a short document: overview, threats table, mitigations, **residual risk** and owners.

## Stop conditions

If the system handles **regulated data** or **high-value transactions**, pair this skill with explicit **human** security sign-off; the skill does not replace compliance review.
