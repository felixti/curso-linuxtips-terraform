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


module "servers" {
  source = "./vm"

  image_reference  = var.image_reference
  azurerm_settings = var.azurerm_settings
  vms_count        = 3
}
