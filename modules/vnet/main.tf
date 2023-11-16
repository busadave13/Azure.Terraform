
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.workspace}-vnet-${var.environment}"
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "system" {
  name                 = "system-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.system_subnet_address_space]
}

resource "azurerm_subnet" "worker" {
  name                 = "worker-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.worker_subnet_address_space]
}

resource "azurerm_subnet" "container_app" {
  name                 = "container-app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.container_app_subnet_address_space]
}
