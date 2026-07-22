variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "Name des SSH-Keys in der Hetzner Cloud"
  type        = string
}

variable "server_type" {
  description = "Hetzner Server-Typ"
  type        = string
  default     = "cx23"
}

variable "image" {
  description = "Betriebssystem-Image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "location" {
  description = "Hetzner Rechenzentrum"
  type        = string
  default     = "fsn1"
}