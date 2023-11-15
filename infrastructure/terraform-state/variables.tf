variable "location" {
  description = "The Azure Region in which all resources"
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
