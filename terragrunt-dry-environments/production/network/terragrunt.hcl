# Use remote module for configuration
terraform {
  source = "git::github.com/cloudacademy/terraform-azure-calabmodules.git//network?ref=v0.0.1"
}

# Pass data in from a declared dependency
inputs = {
  rg_name = dependency.rg.outputs.rg_name
  rg_location = dependency.rg.outputs.rg_location
  vnet_address = local.env_vars.vnet_address
  snet_address = local.env_vars.snet_address
}

# Define dependencies on other modules
dependency "rg" {
  config_path = "../rg"
}

# Collect values from parent environment_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
