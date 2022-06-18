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

variable "vms_count" {
  default = 3
}
