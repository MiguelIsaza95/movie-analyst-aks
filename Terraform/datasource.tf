data "azurerm_key_vault" "key_vault" {
  name                = "aztestingvault"
  resource_group_name = "az-tfstate"
}

data "azurerm_key_vault_secret" "ssh_key" {
  name         = "movie-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}