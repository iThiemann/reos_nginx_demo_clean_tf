############################################################
# Output public IP / URL to access nginx
############################################################

output "public_ip_address" {
  description = "Public IP of the nginx VM"
  value       = module.compute.public_ip_address
}

output "nginx_url" {
  description = "URL to reach the nginx hello page"
  value       = "http://${module.compute.public_ip_address}"
}

