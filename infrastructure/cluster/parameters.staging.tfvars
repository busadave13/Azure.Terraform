environment = "staging"
location = "westus"
workspace = "staging"
kubernetes_version = "1.26.3"


// Network setup info
variable "vnet_ip_address_space" {
  type        = string
  description = "The IP address space to reserve for the vnet in the cluster"
  default     = "10.12.0.0/15"
}

variable "cluster_subnet_ip_address_space" {
  type        = string
  description = "The IP address space to reserve for the cluster subnet in the cluster"
  default     = "10.12.0.0/16"
}

// Specific to each cluster node setup
variable "node_count_system_pool" {
  type        = number
  description = "The number of nodes to create in the system node pool"
  default     = 1

  validation {
    condition     = var.node_count_system_pool > 0 && var.node_count_system_pool <= 100
    error_message = "Valid values are from 1 to 100; greater than 100 nodes in a node pool has perf problems, if you need more nodes create a new node pool."
  }
}

variable "node_count_compute_pool" {
  type        = number
  description = "The number of nodes to create in the compute-optimized node pool"
  default     = 1

  validation {
    condition     = var.node_count_compute_pool > 0 && var.node_count_compute_pool <= 100
    error_message = "Valid values are from 1 to 100; greater than 100 nodes in a node pool has perf problems, if you need more nodes create a new node pool."
  }
}

variable "vm_sku_system_pool" {
  type        = string
  description = "The VM SKU to use for the system node pool"
  default     = "Standard_DS2_v2"
}

variable "vm_sku_compute_pool" {
  type        = string
  description = "The VM SKU to use for the compute-optimized node pool"
  default     = "Standard_DS2_v2"
}

variable "os_sku_compute" {
  type        = string
  description = "The OS Sku to use on compute vms, can be CBLMariner (Mariner v1) or Mariner (Mariner v2)"
  default     = "Mariner"

  validation {
    condition     = contains(["CBLMariner", "Mariner"], var.os_sku_compute)
    error_message = "Valid values are CBLMariner and Mariner"
  }
}

variable "os_sku_system" {
  type        = string
  description = "The OS Sku to use on system vms, can be CBLMariner (Mariner v1) or Mariner (Mariner v2)"
  default     = "Mariner"

  validation {
    condition     = contains(["CBLMariner", "Mariner"], var.os_sku_system)
    error_message = "Valid values are CBLMariner and Mariner"
  }
}

variable "use_availability_zones" {
  type        = bool
  description = "True to use availability zones when possible"
  default     = false
}

variable "max_pods" {
  type        = number
  description = "The maximum number of pods per node"
  default     = 100

  validation {
    condition     = var.max_pods >= 20 && var.max_pods <= 120
    error_message = "Valid values are from 20 to 120."
  }
}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS Disk in GB"
  default     = 60

  validation {
    condition     = var.os_disk_size_gb >= 20 && var.os_disk_size_gb <= 1023
    error_message = "Valid values are from 20 to 1023."
  }
}

variable "dns_service_ip" {
  type        = string
  description = "The IP address of the DNS servicer"
  default     = "10.42.0.10"
}

variable "service_cidr" {
  type        = string
  description = "The service CIDR to use for assigning ip addresses to pods"
  default     = "10.42.0.0/15"
}

variable "storage_account_name" {
  type        = string
  description = "The storage account name for the remote data backend"
  default     = "tfstate9501staging"
}

variable "tags" {
  description = "The prefix to use for all resources."
  type        = map(string)
  default = {
    "environment" = "staging"
    "workspace"   = "cluster"
  }
}
