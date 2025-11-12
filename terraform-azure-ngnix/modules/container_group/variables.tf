###############################################################################
# Module: container_group/variables.tf
# - Inputs for deploying a single-container ACI (nginx) with public IP/FQDN.
###############################################################################

variable "name" {
  description = "Name of the Azure Container Group."
  type        = string
}

variable "location" {
  description = "Azure region for the Container Group."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the ACI will be created."
  type        = string
}

variable "dns_name_label" {
  description = "DNS label for the public IP/FQDN (unique within region)."
  type        = string
}

variable "container_image" {
  description = "Container image to run (e.g., nginx:latest)."
  type        = string
  default     = "nginx:latest"
}

variable "container_cpu" {
  description = "vCPU to allocate to the container."
  type        = number
  default     = 1
}

variable "container_memory" {
  description = "RAM (GB) to allocate to the container."
  type        = number
  default     = 1.5
}

variable "container_env_vars" {
  description = "Non-secret environment variables injected into the container."
  type        = map(string)
  default     = {}
}

variable "index_html_base64" {
  description = "Base64-encoded HTML content for nginx index.html."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the container group."
  type        = map(string)
  default     = {}
}
