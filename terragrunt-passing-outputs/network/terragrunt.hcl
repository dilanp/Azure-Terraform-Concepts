# Define dependencies on other modules
dependency "rg" {
  config_path = "../rg"
}

# Pass data in from a declared dependency to variables.
inputs = {
  rg_name = dependency.rg.outputs.rg_name
  rg_location = dependency.rg.outputs.rg_location
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
