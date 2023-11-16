variable "location" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "workspace" {
  type        = string
}

variable "address_space" {
  type        = string
}

variable "system_subnet_address_space" {
  type = string
}

variable "worker_subnet_address_space" {
  type = string
}

variable "container_app_subnet_address_space" {
  type = string
}
