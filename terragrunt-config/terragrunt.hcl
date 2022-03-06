# Remote backend settings for all child directories
remote_state {
  backend = "azurerm"
  config  = {
    resource_group_name   = "cal-1266-1f"
    storage_account_name  = "sacalabscal12661f"
    container_name        = "calab" 
    key                   = "${path_relative_to_include()}/terraform.tfstate"
  }
}
