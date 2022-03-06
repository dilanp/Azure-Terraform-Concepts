# Terragrunt will only apply the Terraform configurations in child folders that contain a terragrunt.hcl file.
# Apply the Terraform configuration in all child folders.
terragrunt apply-all

# The terragrunt destroy-all command should be used with caution.
# It should not be used against production environments and is more suited to ephemeral test or QA environments. 
# Destroy all resources that have been provisioned in each folder.
terragrunt destroy-all