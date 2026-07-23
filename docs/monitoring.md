# Monitoring

Monitoring is implemented using the official kube-prometheus-stack Helm chart.

## Components

- Prometheus
- Grafana
- kube-state-metrics
- Node Exporter

## Collected Metrics

Infrastructure:

- CPU
- Memory
- Disk
- Network

Kubernetes:

- Nodes
- Pods
- Deployments
- ReplicaSets
- Container Restarts

## Dashboards

Grafana provides dashboards for:

- Cluster Overview
- Node Resources
- Application Resources
- Traefik Requests
- Deployment Health

## Alerting

Grafana Alerting monitors critical infrastructure components.

Current alert:

- Deployment replica availability