
# Locals block with 3 map values.
locals {
  web_vmnic_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
  }
}

# 3 resources will be created!
resource "azurerm_network_security_rule" "web_vmnic_nsg_rule_inbound" {
  #Add for_each block at the top and use each variable to refer values.
  for_each                    = local.web_vmnic_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_vmnic_nsg.name
}
