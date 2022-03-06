# Define dependencies on other modules
dependency "rg" {
  config_path = "../rg"
}

dependency "network" {
  config_path = "../network"
}

# Pass data in from a declared dependency
inputs = {
  rg_name = dependency.rg.outputs.rg_name
  rg_location = dependency.rg.outputs.rg_location
  subnet_id = dependency.network.outputs.subnet_id
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
