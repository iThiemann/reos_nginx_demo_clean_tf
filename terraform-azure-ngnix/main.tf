############################################################
# main.tf
############################################################

# 1. Resource group for everything
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
}

# 2. Read cloud-init that installs nginx
locals {
  cloud_init = file("${path.module}/files/cloud-init.yaml")
}

# 3. Network module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment

  # you could override CIDRs here if needed
}

# 4. Storage module (for general purpose / future diag)
module "storage" {
  source              = "./modules/storage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
  account_sku         = var.storage_account_sku
}

# 5. Monitoring module (Log Analytics, future diag)
module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment
}

# 6. Compute module (VM with nginx)
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  project_name        = var.project_name
  environment         = var.environment

  admin_username  = var.admin_username
  ssh_public_key  = var.ssh_public_key
  subnet_id       = module.network.subnet_id
  cloud_init_data = local.cloud_init
}
