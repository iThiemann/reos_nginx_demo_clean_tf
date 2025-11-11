############################################################
# variables.tf
############################################################

# --- Azure auth ---
variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure AD application (client) ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure AD application client secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

# --- General ---
variable "location" {
  description = "Azure region to deploy to"
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Environment name: dev, staging, prod"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Base name/prefix for resources"
  type        = string
  default     = "taohc-nginx"
}

variable "admin_username" {
  description = "Admin username for Linux VMs"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Public SSH key content (not path)"
  type        = string
}

# storage-specific
variable "storage_account_sku" {
  description = "Storage account SKU"
  type        = string
  default     = "Standard_LRS"
}
