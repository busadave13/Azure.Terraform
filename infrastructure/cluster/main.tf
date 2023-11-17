locals {
  resource_group_name = "${var.workspace}-${var.environment}"
  tags = {
    environment = var.environment
    workspace   = var.workspace
  }
}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "terraform_remote_state" "global" {
  backend   = "azurerm"
  workspace = "global"
  config = {
    storage_account_name = "tfstate1168staging"
    resource_group_name  = "terraform-staging" # TODO: Remove this hardcoding
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location

  tags = local.tags
}

resource "azurerm_user_assigned_identity" "base" {
  name                = "base"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "base" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
}

module "constants" {
  source      = "../../modules/constants"
  location    = azurerm_resource_group.rg.location
  environment = var.environment
}

module "cluster" {
  source                 = "../../modules/cluster"
  environment            = var.environment
  location               = var.location
  workspace              = var.workspace
  resource_group_name    = azurerm_resource_group.rg.name
  kubernetes_version     = var.kubernetes_version
  system_pool_node_count = var.system_pool_node_count
  worker_pool_node_count = var.worker_pool_node_count
  vm_sku_system_pool     = var.vm_sku_system_pool
  vm_sku_worker_pool     = var.vm_sku_worker_pool
  os_sku                 = var.os_sku
  use_availability_zones = var.use_availability_zones
  max_pods               = var.max_pods
  os_disk_size_gb        = var.os_disk_size_gb
  system_subnet_id       = data.terraform_remote_state.global.outputs.system_subnet_id
  worker_subnet_id       = data.terraform_remote_state.global.outputs.worker_subnet_id
  identities             = [azurerm_user_assigned_identity.base.id]
  tags                   = local.tags
}

