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

variable "vms_count" {
  default = 3
}
