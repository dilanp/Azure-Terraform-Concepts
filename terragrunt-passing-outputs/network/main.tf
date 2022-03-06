#Create virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-qa-westus-001"
  address_space       = ["10.2.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

# Create subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "snet-qa-westus-001"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.2.0.0/24"]
}
