output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vent_name" {
  value = azurerm_virtual_network.vnet.name
}

output "system_subnet_id" {
  value = azurerm_subnet.system.id
}

output "worker_subnet_id" {
  value = azurerm_subnet.worker.id
}

output "container_app_subnet_id" {
  value = azurerm_subnet.container_app.id
}
