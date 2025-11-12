###############################################################################
# Root: backend.tf (OPTIONAL TEMPLATE)
# For teams, use a remote backend to avoid local .tfstate files.
# Create the storage account & container once, then fill values (or use env vars).
###############################################################################

/*
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-shared"
    storage_account_name = "mystatetfshared001"      # must be globally unique
    container_name       = "tfstate"
    key                  = "nginx-aci/${var.stage}/terraform.tfstate"
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    tenant_id            = "00000000-0000-0000-0000-000000000000"
  }
}
*/
