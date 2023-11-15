locals {
  resource_group_name = "${var.resource_group_name}-${var.environment}"
  tags = {
    environment = var.environment
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

module "stage" {
  source              = "../../modules/terraform-storage"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  environment         = var.environment
  tags                = local.tags
}
