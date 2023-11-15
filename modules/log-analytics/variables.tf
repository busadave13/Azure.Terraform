variable "environment" {}
variable "location" {}
variable "resource_group_name" {}
variable "workspace" {}

variable "tags" {
  description = "The tags to use for all resources."
  type        = map(string)
}
