# k3s Infrastructure

Production-ready Kubernetes infrastructure running on **Hetzner Cloud** using **Terraform**, **Ansible**, **k3s**, **Traefik**, **Helm**, **Prometheus**, and **Grafana**.

This project demonstrates a complete Infrastructure as Code (IaC) workflow, from provisioning Linux servers to deploying, securing, and monitoring Kubernetes applications.

---

# Table of Contents

- [Quickstart](#quickstart)
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Deployment](#deployment)
- [Monitoring](#monitoring)
- [Security](#security)
- [Roadmap](#roadmap)
- [Screenshots](#screenshots)

---

# Quickstart

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

# Features

- Infrastructure provisioning with Terraform
- Linux server automation using Ansible
- Highly available k3s cluster
- Traefik Ingress Controller
- Automatic HTTPS using cert-manager & Let's Encrypt
- Helm-based monitoring stack
- Prometheus metrics collection
- Grafana dashboards
- Grafana alerting
- Infrastructure automation scripts

---

# Architecture

> Architecture diagram coming soon.

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
│       ├── bookstore/
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

| Server | Role |
|---------|------|
| Control Plane | Kubernetes Control Plane |
| Worker 1 | Kubernetes Worker |
| Worker 2 | Kubernetes Worker |

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
- BookStore API

Infrastructure components:

- Traefik
- cert-manager
- Let's Encrypt
- Prometheus
- Grafana

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

# Roadmap

- [x] Terraform Infrastructure
- [x] Ansible Automation
- [x] k3s Cluster
- [x] Traefik Ingress
- [x] cert-manager
- [x] Let's Encrypt
- [x] Helm
- [x] Prometheus
- [x] Grafana
- [x] Grafana Alerting
- [ ] GitHub Actions CI/CD
- [ ] GitOps with ArgoCD

---

# Screenshots

## Architecture

*Coming soon*

---

## Kubernetes Cluster

*Coming soon*

---

## DaBubble

*Coming soon*

---

## BookStore API

*Coming soon*

---

## Grafana Dashboard

*Coming soon*

---

## Grafana Alert

*Coming soon*

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