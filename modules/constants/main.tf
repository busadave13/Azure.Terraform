variable "location" {
  type        = string
  description = "The azure region"

  validation {
    condition     = contains(["westus", "westus2"], var.location)
    error_message = "Invalid supported region"
  }
}

variable "environment" {
  type        = string
  description = "The environment for the cluster"

  validation {
    condition     = contains(["staging", "prod"], var.environment)
    error_message = "Invalid supported environment"
  }
}