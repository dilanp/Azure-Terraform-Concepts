
#Provider 1.
provider "azurerm" {
  features {}
}

# Provider 2.
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
    }
  }
  alias = "provider2-westus" # Specify Alias for the provider.
}

resource "azurerm_resource_group" "myrg2" {
  name     = "myrg-2"
  location = "West US"

  # Provider Meta Argument.
  provider = azurerm.provider2-westus # Refer provider using the alias.
}
