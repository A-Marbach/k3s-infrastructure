# k3s Infrastructure

Automated provisioning and operation of a multi-node k3s cluster on Hetzner Cloud using Terraform and Ansible.

This project demonstrates Linux server administration, infrastructure automation, Kubernetes operations, networking, monitoring and TLS management.

---

# Table of Contents

- [Deployment Overview](#deployment-overview)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Security](#security)
- [Technologies](#technologies)
- [Skills Demonstrated](#skills-demonstrated)

---

# Deployment Overview

## Prerequisites

- Linux
- Terraform
- Ansible
- kubectl
- Helm
- Hetzner Cloud account
- SSH key

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
- Hetzner Cloud infrastructure provisioning with Terraform
- Automated Linux server configuration with Ansible
- Multi-node k3s cluster with one control plane and two worker nodes

### Networking
- Traefik Ingress Controller
- TLS certificate management with cert-manager and Let's Encrypt

### Observability
- Prometheus metrics collection
- Grafana dashboards
- Grafana alerting

### Automation
- Infrastructure and cluster automation with Terraform, Ansible and shell scripts

---

# Architecture

![Architecture Diagram](images/architect-diagramm/architecture-diagram.svg)

---

# Project Structure

```text
k3s-infrastructure/

├── terraform/              # Hetzner Cloud infrastructure
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
│
├── ansible/                # Linux server and k3s configuration
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── ansible.cfg
│   └── roles/
│
├── kubernetes/             # Cluster resources
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
├── scripts/                # Automation scripts
│
└── README.md
```

---

# Deployment

## Infrastructure

Terraform provisions the Hetzner Cloud infrastructure for the k3s cluster.

Provisioned servers:

![Hetzner Cloud Servers](images/terraform/hetzner-servers.png)

| Server        | Role                     |
|---------------|--------------------------|
| Control Plane | Kubernetes Control Plane |
| Worker 1      | Kubernetes Worker        |
| Worker 2      | Kubernetes Worker        |

Cluster nodes as seen from Kubernetes:

![Cluster Nodes](images/kubernetes/kubectl-get-nodes.png)

---

## Configuration Management

Ansible configures the Linux servers and prepares them for k3s cluster operation.

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

The k3s cluster runs application workloads and infrastructure components for networking, TLS and monitoring.

Current deployed application:

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

The monitoring stack is installed using the official **kube-prometheus-stack** Helm chart and provides visibility into cluster, node, pod and workload health.

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

Grafana Alerting is used to monitor workload availability.

Example alert condition:

- Monitor available deployment replicas
- Trigger an alert when available replicas fall below the desired replica count

---

# Security

Security measures implemented across the Linux servers and cluster include:

- SSH key authentication
- Root login disabled
- Password authentication disabled
- UFW firewall configuration
- HTTPS with Let's Encrypt
- TLS certificate management with cert-manager
- Automatic certificate renewal

---

# Technologies

| Category                | Technology      |
|-------------------------|-----------------|
| Operating System        | Linux           |
| Cloud                   | Hetzner Cloud   |
| Infrastructure as Code  | Terraform       |
| Configuration Management| Ansible         |
| Container Orchestration | Kubernetes (k3s)|
| Containers              | Docker          |
| Ingress                 | Traefik         |
| Certificate Management  | cert-manager    |
| Monitoring              | Prometheus      |
| Dashboards              | Grafana         |
| Package Management      | Helm            |

---

# Skills Demonstrated

- Linux Server Administration
- Infrastructure as Code with Terraform
- Configuration Management with Ansible
- Kubernetes Operations with k3s
- Cluster Networking with Traefik
- TLS Certificate Management with cert-manager
- Prometheus Monitoring
- Grafana Dashboards and Alerting
- SSH Hardening and Firewall Configuration
- Multi-node Cluster Provisioning
- Infrastructure Troubleshooting

--- 

# License

This project is intended for educational and portfolio purposes.


