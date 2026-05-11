# /ship — Release checklist command

Run this flow before merging or deploying from this repository.

## Steps

1. Confirm the branch is **up to date** with the target base branch.
2. Run project **format, lint, typecheck, and tests** (see `.claude/rules/tests.md`).
3. Review **security-sensitive** changes against `.claude/rules/security-hardening.md` and `.claude/rules/api.md`.
4. Ensure **no secrets** or credentials were added (`git grep -iE 'api_?key|secret|BEGIN .+PRIVATE KEY'` should return only intentional placeholders).
5. Update **changelog** or release notes if the project maintains them.
6. If deploying: verify **environment variables** and **feature flags** in staging before production.

## Output

Summarize blockers, risk level (low/medium/high), and exact next commands the human should run if anything remains manual.
