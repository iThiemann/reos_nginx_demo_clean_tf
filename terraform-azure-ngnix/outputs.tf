###############################################################################
# Root: outputs.tf
# - Convenience values useful at the end of `terraform apply`.
###############################################################################

output "resource_group_name" {
  value       = module.rg.name
  description = "Name of the created Resource Group."
}

output "nginx_fqdn" {
  value       = module.nginx.fqdn
  description = "Public FQDN of the nginx container."
}

output "nginx_ip_address" {
  value       = module.nginx.ip_address
  description = "Public IP address assigned to the container group."
}
