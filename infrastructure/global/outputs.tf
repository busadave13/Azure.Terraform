output "container_registry_id" {
  value = module.acr.container_registry_id
}

output "container_registry_name" {
  value = module.acr.container_registry_name
}

output "log_analytics_workspace_id" {
  value = module.law.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  value = module.law.log_analytics_workspace_name
}
