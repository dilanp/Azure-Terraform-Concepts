
resource "azurerm_resource_group" "myrg" {
  name     = "myrg-1"
  location = "East US"
}

resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location # Refer to resource group created above and,
  resource_group_name = azurerm_resource_group.myrg.name     # Creates an implicit dependency on the resource group.
}
