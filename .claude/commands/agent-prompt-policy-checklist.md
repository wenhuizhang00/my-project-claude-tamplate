# /agent-prompt-policy-checklist — Instructions & memory

Use when defining **system prompts**, **policy files**, **memory backends**, or **retrieval** over untrusted corpora.

## Run checks (this repo)

Lightweight heuristic on checked-in policy docs:

```bash
./scripts/agent-runtime/checks/50-prompt-policy-heuristic.sh
```

## Checks

- [ ] External documents are **data**, not authority—no auto-execution of embedded commands
- [ ] Overrides like “ignore all previous rules” are ineffective by design
- [ ] High-risk tool calls require **human confirmation** or policy engine approval
- [ ] Secret paths and key material are not readable by default
- [ ] Memory and scheduler stores are **integrity-protected** (ACLs, signed commits, alerts on drift)

## Pair with

- Skill: `.claude/skills/agent-prompt-memory/SKILL.md`
- Agent: `.claude/agents/agent-prompt-memory-guardian.md`

Mitigation **【2-1】** — `docs/agent-runtime-security.md`.
