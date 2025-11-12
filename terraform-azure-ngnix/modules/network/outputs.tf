############################################################
# Expose outputs for other modules
# modules/network/outputs.tf
############################################################

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw_subnet.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

