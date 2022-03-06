# Use remote module for configuration
terraform {
  source = "git::github.com/cloudacademy/terraform-azure-calabmodules.git//rg?ref=v0.0.1"
}

# Pass data into remote module with inputs
inputs = {
  rg_name = local.env_vars.rgname
}

# Collect values from parent environment_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
