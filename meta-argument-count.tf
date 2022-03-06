
variable "web_linuxvm_instance_count" {
  description = "Web Linux VM Instance Count"
  type        = number
  default     = 5
}

resource "azurerm_network_interface" "web_linuxvm_nic" {
  count = var.web_linuxvm_instance_count # There will be 5 NICs created.

  name                = "${local.resource_name_prefix}-web-linuxvm-nic-${count.index}" # Resource name will include index.
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    subnet_id                     = azurerm_subnet.websubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  count = var.web_linuxvm_instance_count # There will be 5 VMs created.

  name                = "${local.resource_name_prefix}-web-linuxvm-${count.index}" # Resource name will include index.
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"

  # Splat expression is used to get the list of NICs.
  # element() function is used to pick the correct NIC by count index.
  network_interface_ids = [
    element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index)
  ]

}

# An alternative to the Splat expression is to use [count.index].
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  count = var.web_linuxvm_instance_count

  network_interface_id    = azurerm_network_interface.web_linuxvm_nic[count.index].id
  ip_configuration_name   = azurerm_network_interface.web_linuxvm_nic[count.index].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id
}
