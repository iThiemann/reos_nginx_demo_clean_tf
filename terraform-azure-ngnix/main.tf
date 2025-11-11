############################################################
# Resource Group (top-level)
############################################################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

############################################################
# Read cloud-init user-data from file
# We pass this down to the compute module
############################################################
locals {
  cloud_init = file("${path.module}/files/cloud-init.yaml")
}

############################################################
# Network module: VNet, Subnet, NSG
############################################################
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
}

############################################################
# Compute module: Public IP, NIC, VM with nginx
############################################################
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name

  admin_username  = var.admin_username
  ssh_public_key  = var.ssh_public_key
  subnet_id       = module.network.subnet_id
  cloud_init_data = local.cloud_init
}

