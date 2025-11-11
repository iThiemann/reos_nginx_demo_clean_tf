############################################################
# modules/compute/variables.tf
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

variable "workspace_sku" {
  description = "Billing SKU for the Log Analytics Workspace Free, Standalone, CapacityReservation, PerGB2018"
  type        = string
  default     = "PerGB2018"
}
