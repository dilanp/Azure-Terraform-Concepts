# Generate provider configuration for all child directories
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
  backend "azurerm" {}

}

provider "azurerm" {
  features {}
}
EOF
}

# Remote backend settings for all child directories
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "cal-1455-7c"
    storage_account_name = "sacalabscal14557c"
    container_name       = "calab" 
    key            = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Collect values from environment_vars.yaml and set as local variables
locals {
  env_vars = yamldecode(file("environment_vars.yaml"))

}