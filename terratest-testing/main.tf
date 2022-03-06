# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = "pip-${var.servername}-dev-${var.location}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

# Create network security group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-appsallow-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "App-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Create NIC
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.servername}-001"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "niccfg-${var.servername}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }

}

#Network interface Association
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "webserver" {
  name                = var.servername
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                = var.vm_size
  admin_username      = "adminuser"
  admin_password = "P@ssw0rdP@ssw0rd"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


#Azure Custom Script Extension for Script Deployment
resource "azurerm_virtual_machine_extension" "cs" {
  name                 = "${var.servername}-script-ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.webserver.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${filebase64("${path.module}/custom_script.sh")}"
    }
SETTINGS

lifecycle {
    ignore_changes = [
      settings,
    ]
  }
}
