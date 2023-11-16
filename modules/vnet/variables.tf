variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "workspace" {}
variable "address_space" {}
variable "system_subnet_address_space" {}
variable "worker_subnet_address_space" {}
variable "container_app_subnet_address_space" {}

variable "tags" {
  description = "The tags to use for all resources."
  type        = map(string)
}