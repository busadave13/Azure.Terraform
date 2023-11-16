terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.76.0"
    }
  }
  required_version = ">= 1.1.0"
  backend "azurerm" {
    resource_group_name  = "terraform-state-staging"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
    storage_account_name = "tfstate4213staging"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_client_config" "current" {}
