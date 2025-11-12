###############################################################################
# Module: container_group/outputs.tf
###############################################################################

output "fqdn" {
  value       = azurerm_container_group.this.fqdn
  description = "Public FQDN of the container group."
}

output "ip_address" {
  value       = azurerm_container_group.this.ip_address
  description = "Public IP address assigned to the container group."
}
