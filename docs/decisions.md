# Decisions and Trade-offs

1. **Kustomize for app deployment**: keeps manifests simple and environment-agnostic; image is injected by CI at deploy time.
2. **External Secrets + AWS Secrets Manager**: avoids plaintext secret commits and centralizes secret lifecycle in AWS.
3. **OIDC for GitHub Actions**: removes static AWS keys and narrows trust to this repository and selected events.
4. **Single NAT gateway**: lowers cost for a small environment while preserving private subnet egress.
5. **kube-prometheus-stack**: quick observability baseline with Prometheus and Grafana for cluster + app metrics.
