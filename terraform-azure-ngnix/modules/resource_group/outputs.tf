###############################################################################
# Module: resource_group/outputs.tf
###############################################################################

output "name" {
  value       = azurerm_resource_group.this.name
  description = "Name of the created Resource Group."
}

output "location" {
  value       = azurerm_resource_group.this.location
  description = "Region of the created Resource Group."
}
