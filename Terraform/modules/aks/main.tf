resource "azurerm_kubernetes_cluster" "movie_aks" {
  dns_prefix          = var.dns_prefix
  location            = var.location
  name                = var.aks_name
  resource_group_name = var.resource_group_name
  linux_profile {
    admin_username = var.aks_username
    ssh_key {
      key_data = var.aks_ssh_key
    }
  }
  default_node_pool {
    name       = var.pool_name
    vm_size    = var.vm_size
    node_count = var.pool_count
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  network_profile {
    load_balancer_sku = var.load_balancer_sku
    network_plugin    = var.network_plugin
  }
  tags = {
    Environment = "Test"
  }
}