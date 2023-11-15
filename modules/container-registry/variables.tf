variable "environment" {}
variable "location" {}
variable "workspace" {}
variable "resource_group_name" {}

variable "tags" {
  description = "The tags to use for all resources."
  type        = map(string)
}
