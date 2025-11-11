############################################################
# Network module
# Creates:
# - virtual network
# - subnet
# - network security group (NSG) with HTTP+SSH
# - NSG association to subnet
############################################################

# vnet_address_space and subnet_prefixes can be exposed as variables 
locals {
  vnet_address_space = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24"]
}

# VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-$(var.environment)-vnet"
  address_space       = local.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.project_name}-$(var.environment)-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = local.subnet_prefixes
}

# NSG to allow SSH (22) and HTTP (80)
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.project_name}-$(var.environment)-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Attach NSG to the subnet so all VMs in it get these rules
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
