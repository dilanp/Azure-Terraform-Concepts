# Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

#Create Storage Account
module "storage_account" {
  source    = "./modules/storage-account"

  saname    = "sacal925b01"
  rgname    = "cal-925-b0"
  location  = "westus"
}

#Create Storage Account
module "storage_account2" {
  source    = "./modules/storage-account"

  saname    = "sacal925b02"
  rgname    = "cal-925-b0"
  location  = "westus"
}