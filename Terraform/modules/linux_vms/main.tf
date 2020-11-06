resource "azurerm_linux_virtual_machine" "bastion" {
  admin_username        = var.username
  location              = var.location
  name                  = var.name
  network_interface_ids = var.nic
  resource_group_name   = var.rg_name
  size                  = var.vm_size
  os_disk {
    name                 = var.os_name
    caching              = var.os_caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size
  }
  source_image_reference {
    offer     = var.ami_offer
    publisher = var.ami_publisher
    sku       = var.ami_sku
    version   = var.ami_version
  }
  computer_name                   = var.computer_name
  disable_password_authentication = var.disable_passwd_auth
  admin_ssh_key {
    public_key = var.ssh_key
    username   = var.username
  }
  custom_data = var.provision_script
  tags = {
    Environment = "Terraform Demo"
  }
}