############################################################
# Root main.tf
############################################################

# Resource group for everything
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
}

# Read cloud-init that installs nginx
locals {
  cloud_init = file("${path.module}/files/cloud-init.yaml")
}

# Network module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment

  # you could override CIDRs here if needed
}

# Storage module (for general purpose / future diag)
module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Monitoring module (Log Analytics, future diag)
module "monitoring" {
source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
}

# Compute module (VM with nginx)
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.network.subnet_id
  cloud_init_data     = local.cloud_init
}

# Application Gateway module
module "app_gateway" {
  source              = "./modules/app_gateway"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
  appgw_subnet_id     = module.network.appgw_subnet_id
  
  backend_nic_id                   = module.compute.nic_id
  backend_nic_ip_configuration_name = module.compute.nic_ip_configuration_name
}
