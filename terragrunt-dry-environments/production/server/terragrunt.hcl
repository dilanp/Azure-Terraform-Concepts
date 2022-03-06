# Use remote module for configuration
terraform {
  source = "git::github.com/cloudacademy/terraform-azure-calabmodules.git//server?ref=v0.0.2"
}

# Pass data in from a declared dependency
inputs = {
    rg_name = dependency.rg.outputs.rg_name
    rg_location = dependency.rg.outputs.rg_location
    subnet_id = dependency.network.outputs.subnet_id
    vm_size = local.env_vars.vm_size
    admin_username = local.env_vars.admin_username
    admin_password = local.env_vars.admin_password
    servername = local.env_vars.servername

}

# Define dependencies on other modules
dependency "rg" {
  config_path = "../rg"
}

dependency "network" {
  config_path = "../network"
}

# Collect values from parent environment_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}