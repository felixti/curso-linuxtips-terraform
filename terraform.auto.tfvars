image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts-gen2"
  version   = "latest"
}

azurerm_settings = {
  subscription_id = "PUT_YOUR_VALUE_HERE"
  client_id       = "PUT_YOUR_VALUE_HERE"
  client_secret   = "PUT_YOUR_VALUE_HERE"
  tenant_id       = "PUT_YOUR_VALUE_HERE"
}

azurerm_remote_state = {
  resource_group_name  = "tfstate"
  storage_account_name = "tfstate15184"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
}
