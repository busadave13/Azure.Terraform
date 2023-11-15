locals {
  resource_group_name = "${var.resource_group_name}-${var.environment}"
  tags = {
    environment = var.environment
    workspace   = var.workspace
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location

  tags = local.tags
}

module "constants" {
  source      = "../../modules/constants"
  location    = azurerm_resource_group.rg.location
  environment = var.environment
}

module "law" {
  source              = "../../modules/log-analytics"
  workspace           = var.workspace
  location            = azurerm_resource_group.rg.location
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

module "acr" {
  source              = "../../modules/container-registry"
  workspace           = var.workspace
  location            = azurerm_resource_group.rg.location
  environment         = var.environment
  resource-group-name = azurerm_resource_group.rg.name
  tags                = local.tags
}

output "containerRegistryId" {
  value = module.acr.container_registry_id
}

output "containerRegistryName" {
  value = module.acr.container_registry_name
}

output "logAnalyticsWorkspaceId" {
  value = module.law.log_analytics_workspace_id
}

output "logAnalyticsWorkspaceName" {
  value = module.law.log_analytics_workspace_name
}
