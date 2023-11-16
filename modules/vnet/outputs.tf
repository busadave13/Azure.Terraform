output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vent_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_cluster_subnet_id" {
  value = azurerm_subnet.clusterSubnet.id
}

output "snat_prefix_ids" {
  value = azurerm_public_ip_prefix.snat.*.id
}