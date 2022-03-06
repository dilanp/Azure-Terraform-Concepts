# Create NIC
resource "azurerm_network_interface" "nic" {
  name                      = "nic-server1-001 "
  location                  = var.rg_location
  resource_group_name       = var.rg_name

  ip_configuration {
    name                          = "niccfg-server1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "dynamic"
  }
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "server1"
  location              = var.rg_location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Basic_A1"
  admin_username        = "terraadmin"
  admin_password        = "P@ssw0rdP@ssw0rd"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

