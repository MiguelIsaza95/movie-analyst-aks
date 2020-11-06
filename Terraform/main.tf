provider "azurerm" {
  features {}
  version = "~>2.0"
}

resource "azurerm_resource_group" "movie_analyst_rg" {
  name     = "${var.resource_group}_${var.environment}"
  location = var.location

  tags = {
    environment = local.build_environment
  }
}
resource "azurerm_resource_group" "aks_rg" {
  name     = "aks_${var.environment}"
  location = var.location

  tags = {
    environment = local.build_environment
  }
}

module "linux_servers" {
  source = "./modules/linux_vms"

  ami_offer            = "UbuntuServer"
  ami_publisher        = "Canonical"
  ami_sku              = "18.04-LTS"
  ami_version          = "latest"
  computer_name        = "bastion-00"
  vm_size              = "Standard_F2"
  location             = var.location
  name                 = "Bastion Host"
  nic                  = azurerm_network_interface.bastion_server_nic.id
  os_caching           = "ReadWrite"
  os_name              = "${var.servers[0]}-disk"
  rg_name              = azurerm_resource_group.movie_analyst_rg.name
  storage_account_type = "Standard_LRS"
  username             = "bastionadmin"
  provision_script     = filebase64("${path.module}/bastion.sh")
  ssh_key              = data.azurerm_key_vault_secret.ssh_key.value
}

module "aks_cluster" {
  source              = "./modules/aks"
  dns_prefix          = "k8stest"
  location            = var.location
  aks_name            = "movie-analyst-cluster"
  resource_group_name = azurerm_resource_group.aks_rg.name
  aks_username        = "movieadmin"
  aks_ssh_key         = data.azurerm_key_vault_secret.ssh_key.value
  pool_name           = "moviepool"
  pool_count          = 3
  vm_size             = "Standard_D2_V2"
  client_id           = var.client_id
  client_secret       = var.client_secret
  load_balancer_sku   = "Standard"
  network_plugin      = "kubenet"
}