
# Refer a value determined prior to resource creation.
output "db_subnet_name" {
  description = "Db Subnet name"
  value       = azurerm_subnet.dbsubnet.name
}

# Refer a value determined after resource creation.
output "db_subnet_id" {
  description = "Db Subnet id"
  value       = azurerm_subnet.dbsubnet.id
}

# Output secret information
output "primary_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.sa.primary_access_key
  sensitive   = true
}

# Using splat expressions.
output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value       = azurerm_linux_virtual_machine.web_linuxvm[*].id
}

# List output.
output "web_linuxvm_private_ip_address_list" {
  description = "Web Linux Virtual Machine Private IP"
  value       = [for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.private_ip_address]
}

# Map output.
output "web_linuxvm_private_ip_address_map" {
  description = "Web Linux Virtual Machine Private IP"
  value       = { for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_address }
}

# Using keys() function.
output "web_linuxvm_private_ip_address_keys_function" {
  description = "Web Linux Virtual Machine Private IP"
  value       = keys({ for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_address })
}

# Using values() function.
output "web_linuxvm_private_ip_address_values_function" {
  description = "Web Linux Virtual Machine Private IP"
  value       = values({ for vm in azurerm_linux_virtual_machine.web_linuxvm : vm.name => vm.private_ip_address })
}

# Output List - using an iterator.
output "web_linuxvm_network_interface_id_list" {
  description = "Web Linux VM Network Interface ID"
  value       = [for vm, nic in azurerm_network_interface.web_linuxvm_nic : nic.id]
}

# Output Map  - using an iterator.
output "web_linuxvm_network_interface_id_map" {
  description = "Web Linux VM Network Interface ID"
  value       = { for vm, nic in azurerm_network_interface.web_linuxvm_nic : vm => nic.id }
}
