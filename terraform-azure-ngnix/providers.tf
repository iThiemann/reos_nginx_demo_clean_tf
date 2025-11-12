###############################################################################
# Root: providers.tf
# - Pins Terraform and AzureRM provider versions for reproducibility.
# - Provider auth:
#     * Locally: use `az login`
#     * CI: use OIDC (ARM_USE_OIDC=true) or classic client secret env vars.
###############################################################################

terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Use a stable major line to avoid surprises in teams.
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Authentication options (choose one):
  # 1) Azure CLI:             `az login`
  # 2) OIDC in CI:            ARM_USE_OIDC=true + federated credentials
  # 3) Service principal env: ARM_TENANT_ID, ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET
}
