variable "location" {}
variable "environment" {}
variable "resource_group_name" {}
variable "enabled_for_deployment" {}
variable "workspace" {}
variable "service_principal" {}
variable "tenant_id" {}
variable "owners_group_id" {}

variable "tags" {
  description = "The tags to use for all resources."
  type        = map(string)
}
