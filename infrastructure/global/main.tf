locals {
  resource_group_name = "${var.workspace}-${var.environment}"
  tags = {
    environment = var.environment
    workspace   = var.workspace
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group_name}"
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
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}
