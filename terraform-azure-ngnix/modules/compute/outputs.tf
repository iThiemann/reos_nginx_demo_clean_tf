############################################################
# Expose outputs for other modules
# modules/compute/outputs.tf
############################################################

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

# needed for Application Gateway backend
output "private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

# needed for App Gateway association
output "nic_id" {
  value = azurerm_network_interface.nic.id
}

# ipconfig name (we used "ipconfig1" above)
output "nic_ip_configuration_name" {
  value = "ipconfig1"
}
