terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
  # All the configuration settings are maintained in a single file at the root of the directory.
  backend "azurerm" {}

}

provider "azurerm" {
  features {}
}


#Create virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-qa-westus-001"
  address_space       = ["10.2.0.0/16"]
  location            = "westus"
  resource_group_name = "cal-1266-1f"
}

# Create subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "snet-qa-westus-001"
  resource_group_name  = "cal-1266-1f"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.2.0.0/24"]
}
