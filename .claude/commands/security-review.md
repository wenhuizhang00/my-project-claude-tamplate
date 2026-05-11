# /security-review — Focused review command

Perform a **security-oriented** review of the current change or stated scope.

## Review dimensions

- **AuthZ/authN**: missing checks, confused deputy, overly broad roles.
- **Input validation**: injection (SQL, command, template, deserialization), path traversal, unsafe redirects.
- **Data protection**: PII handling, encryption at rest/transit, logging redaction.
- **Dependencies**: risky additions, unpinned versions, unmaintained packages.
- **Config**: debug flags, default passwords, permissive CORS, open ingress.
- **Crypto**: custom schemes, weak algorithms, key material in repo.

## Process

1. List **files in scope** and trust boundaries they touch.
2. Identify **top 3–5 risks** with concrete exploit scenarios or failure modes.
3. Recommend **fixes** ordered by severity; note quick wins vs deeper work.
4. Call out **tests** or checks to add, per `.claude/rules/tests.md`.

## Output format

Use sections: Summary, Findings (severity-tagged), Recommended changes, Test gaps.
