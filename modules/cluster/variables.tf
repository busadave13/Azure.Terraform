variable "environment" {
  type = string
}
variable "location" {
  type = string
}
variable "workspace" {
  type = string
}
 variable "resource_group_name" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "system_pool_node_count" {
  type = number
  validation {
    condition     = var.system_pool_node_count > 0 && var.system_pool_node_count <= 100
    error_message = "Valid values are from 1 to 100"
  }
}
variable "worker_pool_node_count" {
  type = number
  validation {
    condition     = var.worker_pool_node_count > 0 && var.worker_pool_node_count <= 100
    error_message = "Valid values are from 1 to 100"
  }
}
variable "vm_sku_system_pool" {
  type = string
}
variable "vm_sku_worker_pool" {
  type = string
}
variable "os_sku_system" {
  type = string
  validation {
    condition     = contains(["CBLMariner", "Mariner"], var.os_sku_system)
    error_message = "Valid values are CBLMariner and Mariner"
  }
}
variable "os_sku_worker" {
  type = string
  validation {
    condition     = contains(["CBLMariner", "Mariner"], var.os_sku_worker)
    error_message = "Valid values are CBLMariner and Mariner"
  }
}
variable "use_availability_zones" {
  type = bool
}
variable "max_pods" {
  type = number
  validation {
    condition     = var.max_pods >= 20 && var.max_pods <= 120
    error_message = "Valid values are from 20 to 120."
  }
}
variable "os_disk_size_gb" {
  type = number
  validation {
    condition     = var.os_disk_size_gb >= 20 && var.os_disk_size_gb <= 1023
    error_message = "Valid values are from 20 to 1023."
  }
}
variable "system_subnet_id" {
  type = string
}
variable "worker_subnet_id" {
  type = string
}
variable "identities" {
  type = set(string)
}
variable "tags" {
  type = map(string)
}
