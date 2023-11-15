resource "azurerm_container_registry" "acr" {
  #checkov:skip=CKV_AZURE_139:Azure Container registries Public access to All networks is enabled
  #checkov:skip=CKV_AZURE_165:Ensure geo-replicated container registries to match multi-region container deployments
  #checkov:skip=CKV_AZURE_167:Ensure a retention policy is set to cleanup untagged manifests
  #checkov:skip=CKV_AZURE_166:Ensure container image quarantine, scan, and mark images verified
  #checkov:skip=CKV_AZURE_164:Ensures that ACR uses signed/trusted images
  name                = "${var.workspace}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
  # Premium Only
  trust_policy {
    enabled = false
  }
  # Premium Only
  retention_policy {
    enabled = false
    days    = 7
  }
  quarantine_policy_enabled     = false
  public_network_access_enabled = true
  tags                          = var.tags
}
