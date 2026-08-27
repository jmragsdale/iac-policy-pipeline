# FIXTURE: compliant. The policy gate must accept this file.

resource "azurerm_storage_account" "secure" {
  name                            = "jrpolicydemosecure"
  resource_group_name             = "rg-policy-demo"
  location                        = "eastus"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}

resource "azurerm_storage_container" "secure" {
  name                  = "private-assets"
  storage_account_name  = azurerm_storage_account.secure.name
  container_access_type = "private"
}
