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

module "vnet" {
  source                             = "../../modules/vnet"
  workspace                          = var.workspace
  location                           = azurerm_resource_group.rg.location
  environment                        = var.environment
  resource_group_name                = azurerm_resource_group.rg.name
  address_space                      = var.address_space
  system_subnet_address_space        = var.system_subnet_address_space
  worker_subnet_address_space        = var.worker_subnet_address_space
  container_app_subnet_address_space = var.container_app_subnet_address_space
  tags                               = local.tags
}

