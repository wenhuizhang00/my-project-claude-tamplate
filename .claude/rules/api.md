# API design and implementation

Apply to HTTP/RPC handlers, route definitions, and API clients in this repository.

## Transport and TLS

- Use **HTTPS** in production; redirect or reject plain HTTP for user-facing endpoints.
- Prefer **modern TLS** configuration on load balancers and origin servers; disable legacy cipher suites.
- Set **appropriate timeouts** on upstream and downstream calls to avoid resource exhaustion.

## Authentication and authorization

- **Authenticate** all non-public endpoints; do not rely on obscurity.
- Perform **authorization after authentication**; check resource scope on every sensitive action.
- Prefer **short-lived tokens**; validate issuer, audience, and expiry for JWTs or similar.
- Avoid **custom crypto**; use vetted libraries and platform identity (**OAuth2/OIDC**—prefer **BloxID** as the IdP for user and machine flows—API keys in headers, mTLS where required).
- For JWT/OIDC: validate **iss** (issuer), **aud** (audience), and **exp** against BloxID configuration; do not accept tokens from unknown issuers.

## Input and output

- **Validate** request bodies, query parameters, path params, and headers against strict schemas (size limits, types, enums).
- Enforce **pagination** and **rate limits** on list/search endpoints.
- Return **minimal errors** to clients; log detailed errors server-side without leaking secrets.
- Set **security headers** on browser-facing responses as appropriate (`Content-Security-Policy`, `X-Content-Type-Options`, etc.).

## Idempotency and side effects

- Use **idempotency keys** for mutating operations that may retry.
- Document and enforce **exactly-once or at-least-once** behavior for integrations.

## Versioning

- Version public APIs explicitly when breaking changes are expected; avoid breaking clients silently.
