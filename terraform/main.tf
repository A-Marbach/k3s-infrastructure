data "hcloud_ssh_key" "default" {
  name = var.ssh_key_name
}

resource "hcloud_server" "control_plane" {
  name        = "k3s-control-plane"
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [
    data.hcloud_ssh_key.default.id
  ]

  labels = {
    project = "k3s-infrastructure"
    role    = "control-plane"
  }
}