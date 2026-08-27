# FIXTURE: intentionally non-compliant. The policy gate must reject this file.
# Do not copy this into real infrastructure.

resource "azurerm_storage_account" "public" {
  name                            = "jrpolicydemopublic"
  resource_group_name             = "rg-policy-demo"
  location                        = "eastus"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = true
}

resource "azurerm_storage_container" "public" {
  name                  = "public-assets"
  storage_account_name  = azurerm_storage_account.public.name
  container_access_type = "container"
}
