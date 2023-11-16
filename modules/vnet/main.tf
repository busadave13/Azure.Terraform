
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.workspace}-vnet-${var.environment}"
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "system" {
  #checkov:skip=CKV2_AZURE_31: "Ensure VNET subnet is configured with a Network Security Group (NSG)"
  name                 = "system-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.system_subnet_address_space]
}

resource "azurerm_subnet" "worker" {
  #checkov:skip=CKV2_AZURE_31: "Ensure VNET subnet is configured with a Network Security Group (NSG)"
  name                 = "worker-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.worker_subnet_address_space]
}

resource "azurerm_subnet" "container_app" {
  #checkov:skip=CKV2_AZURE_31: "Ensure VNET subnet is configured with a Network Security Group (NSG)"
  name                 = "container-app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.container_app_subnet_address_space]
}
