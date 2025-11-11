############################################################
# Monitoring module
# Creates:
# - log analytics workspace
############################################################

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.project_name}-${var.environment}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.workspace_sku
  retention_in_days   = 30

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}
