variable "prefix" {
  default = "curso-terraform"
}

resource "azurerm_resource_group" "curso" {
  name     = "${var.prefix}-resources"
  location = "East US 2"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.curso.location
  resource_group_name = azurerm_resource_group.curso.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.curso.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {
  count                   = var.vms_count
  name                    = "curso-terraform-pip${count.index}"
  location                = azurerm_resource_group.curso.location
  resource_group_name     = azurerm_resource_group.curso.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 10

  tags = {
    environment = "curso"
  }
}

resource "azurerm_network_interface" "main" {
  count               = var.vms_count
  name                = "${var.prefix}-nic-${count.index}"
  location            = azurerm_resource_group.curso.location
  resource_group_name = azurerm_resource_group.curso.name

  ip_configuration {
    name                          = "cursoterraform${count.index}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[count.index].id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.vms_count
  name                            = "${var.prefix}-vm-${count.index}"
  location                        = azurerm_resource_group.curso.location
  resource_group_name             = azurerm_resource_group.curso.name
  network_interface_ids           = [azurerm_network_interface.main[count.index].id]
  size                            = "Standard_B1ls"
  admin_username                  = "curso_terraform"
  computer_name                   = "hostname"
  admin_password                  = "admin1234!"
  disable_password_authentication = false

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  os_disk {
    name                 = "cursoterraformosdisk${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    environment = "curso"
  }
}

data "azurerm_public_ip" "main" {
  count               = var.vms_count
  name                = azurerm_public_ip.main[count.index].name
  resource_group_name = azurerm_linux_virtual_machine.main[count.index].resource_group_name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.main[*].ip_address
}
