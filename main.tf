terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate15184"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azurerm_settings.subscription_id
  client_id       = var.azurerm_settings.client_id
  client_secret   = var.azurerm_settings.client_secret
  tenant_id       = var.azurerm_settings.tenant_id
}


