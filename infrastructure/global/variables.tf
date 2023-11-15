variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  type        = string
}

variable "environment" {
  description = "The enviornment in which all resources should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group in which all resources should be created."
  type        = string
}

variable "workspace" {
  description = "The prefix to use for all resources."
  type        = string
}
