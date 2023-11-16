output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vent_name" {
  value = module.vnet.vent_name
}

output "system_subnet_id" {
  value = module.vnet.system_subnet_id
}

output "worker_subnet_id" {
  value = module.vnet.worker_subnet_id
}

output "container_app_subnet_id" {
  value = module.vnet.container_app_subnet_id
}