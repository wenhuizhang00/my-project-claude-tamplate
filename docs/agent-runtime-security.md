# Agent runtime security

This guide applies to **any LLM-based agent system** that can use tools, reach networks, accept messages from users or integrations, and persist instructions or memory—coding assistants, autonomous agents, bot backends, RPA-style stacks, or IDE-embedded agents.

Stronger autonomy increases risk across **exposure**, **supply chain**, **untrusted content**, and **privileged execution**. Mitigations use stable IDs **【1-1】–【6-1】** for cross-links from `.claude/skills/agent-*/`, `.claude/agents/agent-*-guardian.md`, and `.claude/commands/agent-*.md`.

---

## Risk 1 — Insecure access to the control plane

**Summary**: HTTP APIs, WebSockets, admin UIs, or debug endpoints (including browser automation debugging) exposed on **all interfaces** (`0.0.0.0`) or the public internet allow unauthorized control or code execution.

**Attack vectors**: Port scanning; leaked bearer tokens or session cookies; unauthenticated local services reachable via SSRF or forwarded ports.

**Impact**: Unauthorized actions, data theft, RCE, full environment takeover.

| ID | Mitigation |
|----|------------|
| 【1-1】 | Bind administrative and agent **control APIs** to **loopback** or private networks; require **strong authentication** (mutual TLS, OAuth, API keys from secret stores—not config repos). |
| 【1-2】 | Bind **debug / automation / CDP-style** ports to localhost only when browser or desktop control is enabled. |
| 【1-3】 | Disable **broadcast discovery** (mDNS, LAN advertisement) unless required and reviewed. |

**Illustrative pattern** (adapt keys to your product—Helm, systemd, env vars, or JSON config):

```yaml
# Example intent only
agent_control_plane:
  listen: "127.0.0.1"
  port: 8443
  auth: required  # e.g. OAuth2, API key header, mTLS
browser_debug:
  listen: "127.0.0.1"
  port: 9222
discovery:
  mdns: false
```

---

## Risk 2 — Prompt injection and poisoned memory

**Summary**: Untrusted text (web, email, tickets, documents, chat) can manipulate model behavior. Persistent stores (**system prompts**, **memory DBs**, **instruction files**, scheduled jobs) can be abused for **long-lived** malicious goals.

**Attack vectors**: Direct chat injection; indirect injection via retrieved content; compromised write paths to memory or policy files.

**Impact**: Data exfiltration, fraudulent actions, lateral movement via tools, covert persistence.

| ID | Mitigation |
|----|------------|
| 【2-1】 | Separate **trusted policy** from **untrusted data**: treat fetched content as data only; ignore hierarchy-breaking directives; require **explicit human confirmation** for high-impact actions; restrict agent reads of secret paths (`~/.ssh`, keys, cloud credential files); enforce **no secrets in model output or logs**. |

Align with `.claude/rules/security-hardening.md` and `.claude/rules/secrets.md`.

---

## Risk 3 — Supply chain (plugins, MCP, extensions, tools)

**Summary**: Third-party **plugins**, **MCP servers**, **skills**, **extensions**, or container images expand capability—and attack surface. Malicious or compromised packages may steal credentials or execute code.

**Impact**: Host compromise, stolen tokens, covert channels.

| ID | Mitigation |
|----|------------|
| 【3-1】 | **Patch** the agent runtime, CLI, and dependencies on a schedule; pin versions in CI. |
| 【3-2】 | After adding or upgrading integrations: run **vendor security scans** or **static analysis** where available; review network egress and filesystem access in code; prefer curated registries with admission policy. |

---

## Risk 4 — Unsafe ingress (chat, webhooks, email bridges)

**Summary**: Connectors that accept messages from **messengers**, **webhooks**, **email**, or **shared channels** can be contacted by anyone permitted by platform settings—enabling abuse and injection.

**Impact**: Cost drain, reconnaissance, chained attacks into tools or downstream systems.

| ID | Mitigation |
|----|------------|
| 【4-1】 | Use **allowlists**, **workspace boundaries**, **DM pairing**, or **bot mention requirements**; disable wide-open group handling unless scoped; align OAuth scopes with least privilege; rate-limit and monitor anomalies. |

**Illustrative JSON** (field names vary by vendor):

```json
{
  "group_messages": "disabled",
  "direct_messages": "pairing_required",
  "integrations": {
    "chat_platform_a": {
      "enabled": true,
      "group_messages": "disabled",
      "token": "env:CHAT_PLATFORM_TOKEN"
    }
  }
}
```

---

## Risk 5 — Over-privileged tool execution

**Summary**: Tool runners (`shell`, file writes, HTTP clients, DB drivers) often run as a **normal OS user** or **broad IAM role**. A manipulated agent inherits that power.

**Attack vectors**: Destructive commands, malware download, credential harvesting.

**Impact**: Data loss, persistence, privilege escalation, lateral movement.

| ID | Mitigation |
|----|------------|
| 【5-1】 | Run tools in **containers** or **sandboxed processes** with minimal filesystem and network access; maintain explicit **allow/deny lists** for tools and integrations. |
| 【5-2】 | Isolate **browser automation** (dedicated image or VM, no host filesystem sharing unless required, disable unsafe bridging). |

---

## Risk 6 — Sensitive data in logs and traces

**Summary**: Secrets in env files, sidecars, or tool parameters can appear in **application logs**, **LLM traces**, **APM**, or **support dumps**.

**Impact**: Credential leakage to operators, vendors, or attackers with log access.

| ID | Mitigation |
|----|------------|
| 【6-1】 | Enable **structured redaction** for logs and traces (tokens, `Authorization`, cookie headers, cloud signing material); scrub before export; minimize sensitive fields in prompts. |

Implement redaction in your observability stack if the agent product does not do it natively.

---

## Deployment patterns

| Pattern | Dominant concerns |
|---------|-------------------|
| Self-hosted VM / k8s | Firewall mistakes, public LoadBalancers, stale images |
| SaaS / multi-tenant agent hosting | Shared gateway abuse, tenant isolation, account takeover |
| Desktop / IDE agents | Shadow installs, local secret files, workstation malware |

**Shared gateways**: DDoS, auth bypass bugs, noisy neighbors, scraping—combine rate limits, WAF where applicable, and strong identity.

**Endpoints**: Inventory installs; MDM or policy to restrict unauthorized agent software; least-privilege OS accounts.

---

## Organizational themes

1. **Secure defaults**: local-only admin surfaces, mandatory auth, conservative tool sets.  
2. **Defense in depth**: network controls, EDR, secrets managers, optional governance layers (approval gates for risky tools).  
3. **Continuous**: dependency updates, integration reviews, alerting on anomalous tool or egress patterns.

---

## Runnable checks in this repository

This template ships **bash** scripts you can run locally or in CI (no dependency on a specific agent product):

```bash
make agent-checks
# or
./scripts/agent-runtime/run-all.sh
```

They cover listeners on all interfaces, secrets in git, **[Gitleaks](https://github.com/gitleaks/gitleaks)** secret scanning (when the binary is present), `.mcp.json` syntax, optional `npm audit`, and other quick wins. See **`scripts/agent-runtime/README.md`** for configuration (`config.env`) and strict CI flags (`STRICT_LISTENERS`, `STRICT_NPM_AUDIT`, `STRICT_GITLEAKS`).

---

## Versioning

Concrete keys and CLI flags depend on each vendor—treat **their documentation** and your **internal security checklist** as authoritative; use this repo’s skills and commands as a **product-agnostic** review aide.
