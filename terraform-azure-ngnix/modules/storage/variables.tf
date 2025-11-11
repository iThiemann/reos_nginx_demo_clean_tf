############################################################
# modules/storage/variables.tf
############################################################

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

# Let caller decide replication (LRS/ZRS/etc.)
variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage account tier (Standard/Premium)"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
}
