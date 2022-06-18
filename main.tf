terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"           // replace it with your resource group name
    storage_account_name = "tfstate15184"      // replace it with your storage account name
    container_name       = "tfstate"           // replace it with your storage container name
    key                  = "terraform.tfstate" // replace it with your terraform tfstate file name
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azurerm_settings.subscription_id
  client_id       = var.azurerm_settings.client_id
  client_secret   = var.azurerm_settings.client_secret
  tenant_id       = var.azurerm_settings.tenant_id
}


