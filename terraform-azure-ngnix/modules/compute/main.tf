############################################################
# Compute module
# Creates:
# - public IP
# - network interface
# - Linux VM (Ubuntu) with cloud-init that installs nginx
############################################################

# Public IP so we can reach nginx
resource "azurerm_public_ip" "pip" {
  name                = "${var.project_name}-$(var.environment)-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# NIC for the VM
resource "azurerm_network_interface" "nic" {
  name                = "${var.project_name}-$(var.environment)-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}

# Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.project_name}-$(var.environment)-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"  # small & cheap
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  # Ubuntu 22.04 LTS
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # If ssh_public_key looks like a path, Terraform's file() in root
  # already turned it into content, so here we just use it directly.
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  computer_name                   = "${var.project_name}-$(var.environment)-vm"
  disable_password_authentication = true

  # Pass cloud-init from root (must be base64)
  custom_data = base64encode(var.cloud_init_data)

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${var.project_name}-$(var.environment)-osdisk"
  }

  tags = {
    environment = var.environment
    project     = var.project_name
  }
}
