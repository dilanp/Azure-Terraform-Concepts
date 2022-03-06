####### Terraform configuration ########
terraform {
  required_version = "= 1.0.0" #EXACT versio
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0" #ANY LATER version
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0.0" #ANY MINOR version
    }
  }
}


######## Terraform configuration with backend #########
# The remote state file will be stored in this Storage Account. 
# Storing the state remotely is great for centralized storage and eliminates the risk of multiple teammates working from the same state file at the same time. 
# If you understand how state works, you know that this would cause major issues when managing Terraform resource with state. 
# State locking is a feature that prevents that state from being opened when it is already in use and is a feature native to Azure Blob Storage.
# During the 'terraform apply', the state file is locked. 
# The Azure Blob Storage is holding the lock status of the file. 
# If another user were to run terraform apply using the same remote state file right now, they would get a lock error. 
# This is great to prevent multiple users from modifying the same infrastructure at once.

# ---- Creation of Azure Storage Account for backend ----
## Login to Azure account.
#az login
## Create a Storage Account and blob container
#az storage account create --name sasacal9331888 --resource-group cal-933-18 --location westus --sku Standard_LRS --encryption-services blob 
#az storage container create --name calab --account-name sasacal9331888 --auth-mode login
## Enable version tracking on the storage account
#az storage account blob-service-properties update -n sasacal9331888 --enable-change-feed true --enable-versioning true
# ---------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "cal-933-18"
    storage_account_name = "sasacal9331888"
    container_name       = "calab"
    key                  = "dev.terraform.tfstate"
  }
}
