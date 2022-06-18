variable "image_reference" {
  description = "All info about source image"
}


variable "azurerm_settings" {
  type = object({
    subscription_id : string
    client_id : string
    client_secret : string
    tenant_id : string
  })
}

variable "azurerm_remote_state" {
  type = object({
    resource_group_name : string
    storage_account_name : string
    container_name : string
    key : string
  })
}


module "servers" {
  source = "./vm"

  image_reference      = var.image_reference
  azurerm_settings     = var.azurerm_settings
  azurerm_remote_state = var.azurerm_remote_state
  vms_count            = 3
}
