.PHONY: agent-checks

# Run local agent-runtime security scripts (see scripts/agent-runtime/README.md)
agent-checks:
	@chmod +x scripts/agent-runtime/run-all.sh scripts/agent-runtime/checks/*.sh 2>/dev/null || true
	@./scripts/agent-runtime/run-all.sh
