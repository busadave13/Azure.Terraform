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

module "terraform-storage" {
  source              = "../modules/terraform-storage"
  location            = azurerm_resource_group.rg.location
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}