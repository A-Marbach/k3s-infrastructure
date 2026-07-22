# k3s Infrastructure

This repository contains a production-oriented Infrastructure as Code (IaC) project that provisions and configures a Kubernetes (k3s) cluster on Hetzner Cloud using Terraform and Ansible.

The project demonstrates a complete infrastructure lifecycle:

- Infrastructure provisioning with Terraform
- Linux server configuration with Ansible
- Kubernetes (k3s) cluster deployment
- Infrastructure hardening
- Infrastructure validation
- Reproducible and scalable deployments

The project will be extended with Ingress, cert-manager, monitoring, GitHub Actions, and automated application deployments.

---

# Table of Contents

- Quickstart
- Infrastructure Overview
- Architecture
- Project Structure
- Terraform
- Ansible
- Kubernetes
- Validation
- Roadmap

---

# Quickstart

## Prerequisites

- Terraform
- Ansible
- Hetzner Cloud Account
- SSH Key
- Ubuntu/Linux Control Machine

## Clone Repository

```bash
git clone git@github.com:A-Marbach/k3s-infrastructure.git
cd k3s-infrastructure
```

---

# Deploy Infrastructure

```bash
cd terraform

terraform init
terraform validate
terraform plan
terraform apply
```

---

# Configure Cluster

```bash
cd ../ansible

ansible-playbook playbook.yml
```

---

# Infrastructure Overview

Current infrastructure:

- Hetzner Cloud
- Ubuntu Server 24.04
- 1 Control Plane
- 2 Worker Nodes
- SSH Key Authentication
- Terraform Provisioning
- Ansible Configuration Management
- Kubernetes (k3s)

---

# Architecture

```text
                     Hetzner Cloud
                           │
                     Terraform IaC
                           │
                ┌──────────┴──────────┐
                │                     │
          Ubuntu Servers
                │
          Ansible Automation
                │
     ┌──────────┴──────────┐
     │                     │
k3s-control-plane
     │
 ┌───┴─────────────┐
 │                 │
worker-1       worker-2
```

---

# Project Structure

```text
k3s-infrastructure/

├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
│
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── ansible.cfg
│   └── roles/
│       ├── common/
│       ├── users/
│       ├── ssh_hardening/
│       ├── system_config/
│       ├── firewall/
│       ├── k3s_prerequisites/
│       ├── k3s_server/
│       └── k3s_agent/
│
├── README.md
└── .gitignore
```

---

# Terraform

Terraform provisions the complete infrastructure on Hetzner Cloud.

## Features

- Hetzner Cloud Provider
- Reusable Variables
- SSH Key Authentication
- Infrastructure Outputs
- for_each Infrastructure
- Infrastructure as Code
- State Refactoring using moved

## Provisioned Servers

| Server | Role | Operating System |
|---------|------|------------------|
| k3s-control-plane | Control Plane | Ubuntu 24.04 |
| k3s-worker-1 | Worker | Ubuntu 24.04 |
| k3s-worker-2 | Worker | Ubuntu 24.04 |

---

# Ansible

After provisioning, Ansible configures every server automatically.

## Roles

### common

- Install required packages
- Update package cache

### users

- Create administrator user
- Configure SSH authorized_keys
- Configure passwordless sudo

### ssh_hardening

- Disable root login
- Disable password authentication
- Enable public key authentication
- Harden SSH configuration

### system_config

- Configure hostname
- Configure timezone
- Install Chrony
- Configure unattended upgrades

### firewall

- Install UFW
- Configure default policies
- Allow SSH
- Allow HTTP
- Allow HTTPS
- Allow Kubernetes API
- Configure Kubernetes network rules

### k3s_prerequisites

- Disable Swap
- Configure Kernel Modules
- Enable IP Forwarding
- Configure sysctl
- Prepare Linux for Kubernetes

### k3s_server

- Install k3s Control Plane
- Configure kubeconfig
- Read Join Token
- Wait until Kubernetes API is ready

### k3s_agent

- Automatically join worker nodes
- Configure k3s-agent service

---

# Kubernetes

The Kubernetes cluster is deployed entirely through Ansible.

Current topology:

- 1 Control Plane
- 2 Worker Nodes

Deployment is fully automated and reproducible.

---

# Validation

Infrastructure validation includes:

- Terraform validation
- Ansible syntax validation
- Idempotency testing
- SSH connectivity verification
- Firewall verification
- Kubernetes service validation
- Kubernetes node validation

---

# Current Progress

## Terraform

- ✅ Terraform initialized
- ✅ Hetzner provider configured
- ✅ Variables created
- ✅ SSH Keys configured
- ✅ Control Plane provisioned
- ✅ Worker Nodes provisioned
- ✅ Infrastructure refactored using for_each

## Ansible

- ✅ Common role
- ✅ Users role
- ✅ SSH Hardening
- ✅ System Configuration
- ✅ Firewall Configuration
- ✅ Kubernetes Prerequisites
- ✅ k3s Server Deployment
- ✅ k3s Worker Deployment
- ✅ Cluster successfully deployed
- ✅ Idempotency verified

---

# Roadmap

- [x] Provision infrastructure with Terraform
- [x] Configure servers with Ansible
- [x] Deploy k3s cluster
- [ ] Deploy sample applications
- [ ] Configure Ingress
- [ ] Install cert-manager
- [ ] Configure Let's Encrypt
- [ ] Deploy Prometheus
- [ ] Deploy Grafana
- [ ] Configure GitHub Actions
- [ ] Continuous Deployment
- [ ] Monitoring Dashboards

---

# Project Goals

This project demonstrates modern Infrastructure as Code principles by combining Terraform, Ansible, and Kubernetes into a reproducible and scalable deployment workflow.

The focus is on:

- Infrastructure as Code
- Configuration Management
- Kubernetes Automation
- Reproducibility
- Scalability
- Linux Administration
- DevOps Best Practices