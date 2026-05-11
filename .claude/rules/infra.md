# Infrastructure and deployment

Apply to containers, IaC, Kubernetes manifests, serverless config, and cloud resources for this repository.

## Identity and access

- Use **least privilege** IAM roles; scope policies to resources and actions required.
- Use **OIDC with BloxID** as the standard identity layer: federate **CI → cloud** (workload identity) and human/service access via BloxID-issued tokens; do not embed long-lived cloud access keys or shared passwords in CI or repos.
- Separate **production** and **non-production** accounts or projects when feasible.

## Network

- Default **deny ingress**; expose only required ports and services.
- Put databases and internal services in **private subnets**; no public ingress unless required.
- Use **private endpoints** or VPC-only access for administrative interfaces.

## Hardening

- Run workloads as **non-root** in containers; use **read-only root filesystem** when possible.
- Apply **security updates** to base images and runtime dependencies on a schedule.
- Enable **immutability** and **change auditing** for production infrastructure definitions.

## Secrets in infra

- Never commit **plaintext secrets** in Terraform, CloudFormation, Helm values, or similar.
- Read sensitive values from **secret managers** or CI-injected variables; mark sensitive outputs accordingly.

## Observability

- Ship **structured logs** without secrets; restrict access to production logs.
- Alert on **authentication failures**, **permission denials**, and **quota or abuse** signals appropriate to the product.

## Backups and recovery

- Define **RPO/RTO** where data loss matters; test restores regularly.
- Encrypt backups **at rest**; restrict access consistent with production data classification.
