data "hcloud_ssh_key" "default" {
  name = var.ssh_key_name
}

locals {
  servers = {
    control-plane = {
      name = "k3s-control-plane"
      role = "control-plane"
    }

    worker-1 = {
      name = "k3s-worker-1"
      role = "worker"
    }

    worker-2 = {
      name = "k3s-worker-2"
      role = "worker"
    }
  }
}

resource "hcloud_server" "nodes" {
  for_each = local.servers

  name        = each.value.name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]

  labels = {
    project = "k3s-infrastructure"
    role    = each.value.role
  }
}

moved {
  from = hcloud_server.control_plane
  to   = hcloud_server.nodes["control-plane"]
}