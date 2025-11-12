###############################################################################
# Module: resource_group/main.tf
# - Creates an Azure Resource Group with standardized tags.
###############################################################################

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
