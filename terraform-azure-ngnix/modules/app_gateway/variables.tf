############################################################
# modules/app_gateway/variables.tf
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

# subnet where the App Gateway lives (must be dedicated)
variable "appgw_subnet_id" {
  type = string
}

# NIC of the VM (from compute module)
variable "backend_nic_id" {
  type = string
}

# name of the NIC ip_configuration (we used "ipconfig1")
variable "backend_nic_ip_configuration_name" {
  type    = string
  default = "ipconfig1"
}

# the nginx VM private IP to send traffic to
# variable "backend_private_ip" {
#   type = string
# }
