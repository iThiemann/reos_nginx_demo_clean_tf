############################################################
# App_Gateway module
# Creates:
# - public IP for the Gateway
# - App_Gateway
# - config frontend, backend, listener
############################################################

# public IP for the gateway
resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.project_name}-${var.environment}-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

resource "azurerm_application_gateway" "appgw" {
  name                = "${var.project_name}-${var.environment}-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ipcfg"
    subnet_id = var.appgw_subnet_id
  }

  frontend_port {
    name = "port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = "nginx-backend-pool"
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule-1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "nginx-backend-pool"
    backend_http_settings_name = "http-settings"
  }

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# THIS is the piece your provider expects:
# associate the VM NIC to the gateway backend pool
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm_to_appgw" {
  network_interface_id    = var.backend_nic_id
  ip_configuration_name   = var.backend_nic_ip_configuration_name
  backend_address_pool_id = element(azurerm_application_gateway.appgw.backend_address_pool[*].id, 0)
}
