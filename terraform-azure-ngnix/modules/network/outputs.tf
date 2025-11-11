############################################################
# Expose outputs for other modules
# modules/network/outputs.tf
############################################################

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

