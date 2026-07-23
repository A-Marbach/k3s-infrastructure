# k3s Infrastructure

Infrastructure as Code (IaC) project showcasing the automated provisioning, configuration, deployment and monitoring of a Kubernetes cluster on **Hetzner Cloud** using **Terraform**, **Ansible**, **k3s**, **Traefik**, **Helm**, **Prometheus**, and **Grafana**.

The focus of this repository is infrastructure automation, Linux administration and Kubernetes operations rather than application development.
---

# Table of Contents

- [Deployment Overview](#deployment-overview)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Security](#security)

---

# Deployment Overview

## Prerequisites

- Terraform
- Ansible
- kubectl
- Helm
- Hetzner Cloud Account
- SSH Key
- Linux Control Machine

---

## Clone Repository

```bash
git clone git@github.com:A-Marbach/k3s-infrastructure.git
cd k3s-infrastructure
```

---

## Provision Infrastructure

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

---

## Configure Cluster

```bash
cd ../ansible

ansible-playbook playbook.yml
```

---

## Deploy Kubernetes Resources

```bash
kubectl apply -f kubernetes/
```

---

## Features

### Infrastructure
- Infrastructure provisioning with Terraform
- Linux server automation using Ansible
- Multi-node k3s cluster

### Networking
- Traefik Ingress Controller
- Automatic HTTPS using cert-manager & Let's Encrypt

### Observability
- Prometheus metrics collection
- Grafana dashboards
- Grafana alerting

### Automation
- Infrastructure automation scripts

---

# Architecture

![Architecture Diagram](../images/architect-diagramm/architecture-diagram.png)

<!--
Insert architecture diagram here.
-->

---

# Project Structure

```text
k3s-infrastructure/

├── terraform/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
│
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── ansible.cfg
│   └── roles/
│
├── kubernetes/
│   ├── infrastructure/
│   │   ├── cert-manager/
│   │   └── traefik/
│   │
│   ├── monitoring/
│   │   ├── values.yaml
│   │   └── grafana-ingress.yaml
│   │
│   └── apps/
│       └── da-bubble/
│
├── scripts/
│
└── README.md
```

---

# Deployment

## Infrastructure

Terraform provisions the complete infrastructure on Hetzner Cloud.

Provisioned servers:

![Hetzner Cloud Servers](images/terraform/hetzner-servers.png)

| Server | Role |
|---------|------|
| Control Plane | Kubernetes Control Plane |
| Worker 1 | Kubernetes Worker |
| Worker 2 | Kubernetes Worker |

Cluster nodes as seen from Kubernetes:

![Cluster Nodes](images/kubernetes/kubectl-get-nodes.png)

---

## Configuration Management

Ansible configures all Linux servers automatically.

Configuration includes:

- Package installation
- SSH hardening
- Administrator user creation
- Firewall configuration
- Kubernetes prerequisites
- k3s installation
- Cluster bootstrap
- Worker node joining

---

## Kubernetes

Current deployed applications:

- DaBubble

Infrastructure components:

- Traefik
- cert-manager
- Let's Encrypt
- Prometheus
- Grafana

All pods running across the cluster:

![All Pods](images/kubernetes/kubectl-get-pods-all.png)

Ingress routes exposing applications through Traefik:

![Ingress Overview](images/kubernetes/kubectl-get-ingress-all.png)

TLS certificates issued via cert-manager and Let's Encrypt:

![Certificates](images/kubernetes/kubectl-get-certificates-all.png)

### DaBubble

![DaBubble Login](images/apps/dabubble-https-login.png)


---

# Monitoring

The monitoring stack is installed using the official **kube-prometheus-stack** Helm chart.

## Components

- Prometheus
- Grafana
- kube-state-metrics
- Node Exporter

---

## Dashboard Features

- Node CPU Usage
- Node Memory Usage
- Pod Monitoring
- Deployment Monitoring
- HTTP Request Metrics
- Container Resource Usage
- Pod Restarts
- Custom Grafana Dashboards

![Grafana Dashboard](images/monitoring/grafana-dashboard.png)

---

## Alerting

Grafana Alerting is configured to monitor application health.

Example alert:

- Deployment replica count
- Trigger when available replicas fall below the desired state



---

# Security

Security best practices implemented:

- SSH Key Authentication
- Root Login Disabled
- Password Authentication Disabled
- UFW Firewall
- Automatic HTTPS
- Let's Encrypt Certificates
- Automatic Certificate Renewal

---

# Technologies

| Category | Technology |
|----------|------------|
| Cloud | Hetzner Cloud |
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Container Orchestration | Kubernetes (k3s) |
| Containers | Docker |
| Ingress | Traefik |
| Certificate Management | cert-manager |
| Monitoring | Prometheus |
| Dashboards | Grafana |
| Package Management | Helm |

---

# License

This project is intended for educational and portfolio purposes.