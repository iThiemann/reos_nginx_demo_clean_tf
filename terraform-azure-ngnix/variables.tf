############################################################
# Root-level variables
############################################################

variable "project_name" {
  description = "Logical name/prefix for all Azure resources"
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

variable "dns_name_label" {
  description = "DNS name label for the container group public IP (must be unique within the Azure region)"
  type        = string
  default     = "nginx-demo-aci-reos-demo"
}

variable "stage" {
  description = "Deployment stage indicator (dev|staging|prod)."
  type        = string
}

variable "container_image" {
  description = "Container image to run"
  type        = string
  default     = "nginx:latest"
}

variable "container_cpu" {
  description = "CPU for the container"
  type        = number
  default     = 1
}

variable "container_memory" {
  description = "Memory (GB) for the container"
  type        = number
  default     = 1.5
}

variable "container_env_vars" {
  description = "Environment variables to inject into the container (stage-specific)"
  type        = map(string)
  default     = {}
}
