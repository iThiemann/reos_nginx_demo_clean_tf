###############################################################################
# Module: container_group/main.tf
# - Provisions Azure Container Instances (Linux) running nginx
# - Writes provided HTML (base64) to /usr/share/nginx/html/index.html
# - Exposes port 80 publicly with a regional DNS FQDN
###############################################################################

resource "azurerm_container_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  # Public IP with FQDN: <dns_name_label>.<region>.azurecontainer.io
  ip_address_type = "Public"
  dns_name_label  = var.dns_name_label

  container {
    name   = "nginx"
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = 80
      protocol = "TCP"
    }

    # Inject simple (non-secret) environment variables.
    # For secrets, prefer Key Vault + secure env or secret volumes.
    environment_variables = var.container_env_vars

    # Startup command:
    # 1) Decode the provided base64 HTML
    # 2) Write to nginx's default document root
    # 3) Start nginx in the foreground
    commands = [
      "/bin/sh",
      "-c",
      "echo \"${var.index_html_base64}\" | base64 -d > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
    ]
  }

  tags = var.tags
}
