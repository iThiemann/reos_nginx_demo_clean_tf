############################################################
# Expose outputs for other modules
# modules/app_gateway/outputs.tf
############################################################

output "application_gateway_public_ip" {
  value = azurerm_public_ip.appgw_pip.ip_address
}
