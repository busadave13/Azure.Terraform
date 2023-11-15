resource "azurerm_container_registry" "acr" {
  #checkov:skip=CKV_AZURE_139:Azure Container registries Public access to All networks is enabled
  #checkov:skip=CKV_AZURE_165:Ensure geo-replicated container registries to match multi-region container deployments
  #checkov:skip=CKV_AZURE_167:Ensure a retention policy is set to cleanup untagged manifests
  name                = "${var.workspace}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
  trust_policy {
    enabled = true
  }
 # retention_policy {
 #   enabled = true
 #   days    = 7
 # }
  quarantine_policy_enabled     = true
  public_network_access_enabled = false
  tags                          = var.tags
}
