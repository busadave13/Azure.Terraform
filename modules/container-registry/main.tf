resource "azurerm_container_registry" "acr" {
  name                = "${var.workspace}acr${var.environment}"
  resource_group_name = var.resource-group-name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true

  tags = var.tags
}

output "container_registry_id" {
  value = azurerm_container_registry.acr.id
}

output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}
