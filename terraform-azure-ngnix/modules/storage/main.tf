############################################################
# Storage module
# Creates:
# - storage account
############################################################

# build a predictable name; must be: lowercase, 3-24 chars, unique
locals {
  # remove non-alnum and trim to 24 chars
  storage_account_name = substr(
    lower(replace("${var.project_name}${var.environment}sa", "/[^a-z0-9]/", "")),
    0,
    24
  )
}

resource "azurerm_storage_account" "sa" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # recommended
  allow_blob_public_access = false

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}
