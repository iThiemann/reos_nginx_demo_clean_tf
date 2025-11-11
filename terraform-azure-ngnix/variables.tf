############################################################
# Root-level variables
############################################################

variable "project_name" {
  description = "Short name prefix for Azure resources"
  type        = string
  default     = "nginx-demo"
}

variable "location" {
  description = "Azure region to deploy to"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
  default     = "rg-nginx-demo"
}

variable "admin_username" {
  description = "Linux admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Path to your SSH public key (e.g. ~/.ssh/id_rsa.pub) or the key string"
  type        = string
  # you can change this to the actual key string if you prefer
  default     = "~/.ssh/id_rsa.pub"
}

