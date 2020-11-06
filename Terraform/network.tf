resource "azurerm_virtual_network" "servers_vnet" {
  name                = "${var.resource_group}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.movie_analyst_rg.name
  address_space       = [var.network]

  tags = {
    environment = local.build_environment
  }
}

# multiple subnets with for_each
resource "azurerm_subnet" "servers_subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.movie_analyst_rg
  virtual_network_name = azurerm_virtual_network.servers_vnet
  address_prefixes     = [each.value]
}

resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "${var.servers[0]}-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.movie_analyst_rg

  #conditional
  allocation_method = var.environment == "Prod" ? "Static" : "Dynamic"
}

resource "azurerm_network_interface" "bastion_server_nic" {
  name                = "${var.servers[0]}-${format("%02d", 0)}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.movie_analyst_rg

  ip_configuration {
    name                          = "${var.servers[0]}-ip"
    subnet_id                     = azurerm_subnet.servers_subnets["bastion-server"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_public_ip.id
  }
}