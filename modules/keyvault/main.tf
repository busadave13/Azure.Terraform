resource "azurerm_key_vault" "keyVault" {
  name                            = "${var.workspace}-kv-${var.environment}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  purge_protection_enabled        = false
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_deployment
  sku_name                        = "standard"

  tags = var.tags
}

#Add r/w access for owners group, eg for users who jit into the owners role
resource "azurerm_key_vault_access_policy" "keyVaultOwnerPolicy" {

  key_vault_id = azurerm_key_vault.keyVault.id
  tenant_id    = var.tenant_id
  object_id    = var.owners_group_id

  key_permissions = [
    "Backup",
    "Create",
    "Delete",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Update"
  ]
  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageIssuers",
    "Recover",
    "Restore",
    "Purge",
    "SetIssuers",
    "Update",
  ]
}

# Add read access for all sp's so our services can run
resource "azurerm_key_vault_access_policy" "keyVaultServicePrincipalPolicy" {
  key_vault_id = azurerm_key_vault.keyVault.id
  tenant_id    = var.tenant_id
  object_id    = var.service_principal

  key_permissions = [
    "Get",
    "List",
  ]
  secret_permissions = [
    "Get",
    "List",
  ]
  certificate_permissions = [
    "Get",
    "List",
  ]
}

output "keyvault_name" {
  value = azurerm_key_vault.keyVault.name
}

output "keyvault_id" {
  value = azurerm_key_vault.keyVault.id
}

output "keyvault_url" {
  value = azurerm_key_vault.keyVault.vault_uri
}
