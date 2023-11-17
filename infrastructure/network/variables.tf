variable "location" {
  description = "The Azure region to deploy all resources."
  type        = string
}

variable "environment" {
  description = "The environment to deploy all resources."
  type        = string
}

variable "workspace" {
  description = "The name of the workspace to deploy all resources."
  type        = string
}

variable "address_space" {
  description = "CIDR value of the address space for the vnet"
  type        = string
}

variable "system_subnet_address_space" {
  description = "CIDR value of the address space for the system subnet"
  type        = string
}

variable "worker_subnet_address_space" {
  description = "CIDR value of the address space for the worker subnet"
  type        = string
}

variable "container_app_subnet_address_space" {
  description = "CIDR value of the address space for the container app subnet"
  type        = string
}
