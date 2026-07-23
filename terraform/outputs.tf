output "server_names" {
  description = "Names of all k3s nodes"

  value = {
    for key, server in hcloud_server.nodes :
    key => server.name
  }
}

output "server_ipv4_addresses" {
  description = "Public IPv4 addresses of all k3s nodes"

  value = {
    for key, server in hcloud_server.nodes :
    key => server.ipv4_address
  }
}

output "server_status" {
  description = "Status of all k3s nodes"

  value = {
    for key, server in hcloud_server.nodes :
    key => server.status
  }
}