
output "control_plane_name" {
  description = "Name des Control-Plane-Servers"
  value       = hcloud_server.control_plane.name
}

output "control_plane_ipv4" {
  description = "Öffentliche IPv4-Adresse"
  value       = hcloud_server.control_plane.ipv4_address
}

output "control_plane_status" {
  description = "Status des Servers"
  value       = hcloud_server.control_plane.status
}