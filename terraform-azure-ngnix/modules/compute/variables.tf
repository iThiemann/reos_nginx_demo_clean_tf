variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "project_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  description = "Either a path to a public key or the key itself"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID from the network module"
  type        = string
}

variable "cloud_init_data" {
  description = "Full cloud-init yaml content"
  type        = string
}

#
