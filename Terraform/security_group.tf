resource "azurerm_network_security_group" "servers_nsg" {
  count               = length(var.servers)
  name                = "${var.servers[count.index]}-nsg"
  location            = var.location
  resource_group_name = var.servers[count.index] == "movie-servers" ? azurerm_resource_group.aks_rg.name : azurerm_resource_group.movie_analyst_rg.name
}

resource "azurerm_network_security_rule" "bastion_server_ng_rule_ssh" {
  resource_group_name         = azurerm_resource_group.movie_analyst_rg.name
  network_security_group_name = azurerm_network_security_group.servers_nsg["bastion-server"].name
  name                        = "SSH inbound"
  priority                    = 100
  direction                   = "inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "179.12.16.164/32"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
}
resource "azurerm_network_security_rule" "bastion_server_outbound_rule_ssh" {
  resource_group_name         = azurerm_resource_group.movie_analyst_rg.name
  network_security_group_name = azurerm_network_security_group.servers_nsg["bastion-server"].name
  name                        = "SSH outbound"
  priority                    = 101
  direction                   = "outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  source_address_prefix       = azurerm_network_interface.bastion_server_nic.private_ip_address
  destination_port_range      = "22"
  destination_address_prefix  = "*"
}

# Attach sg to an interface id
resource "azurerm_network_interface_security_group_association" "bastion_server_nsg_association" {
  network_security_group_id = azurerm_network_security_group.servers_nsg["bastion_server"].id
  network_interface_id      = azurerm_network_interface.bastion_server_nic.id
}
