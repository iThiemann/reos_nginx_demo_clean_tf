############################################################
# outputs.tf
############################################################

output "public_ip_address" {
  description = "Public IP of the nginx VM"
  value       = module.compute.public_ip_address
}

output "nginx_url" {
  description = "URL to access nginx"
  value       = "http://${module.compute.public_ip_address}"
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "log_analytics_workspace_id" {
  value = module.monitoring.workspace_id
}
