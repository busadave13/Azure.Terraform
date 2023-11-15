resource "random_integer" "num" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "sa" {
  #checkov:skip=CKV_AZURE_59:Ensure that Storage accounts disallow public access
  #checkov:skip=CKV_AZURE_33:Ensure Storage logging is enabled for Queue service for read, write and delete requests
  #checkov:skip=CKV_AZURE_44:Ensure Storage Account is using the latest version of TLS encryption
  #checkov:skip=CKV_AZURE_206:Ensure that Storage Accounts use replication
  #checkov:skip=CKV_AZURE_190:Ensure that Storage blobs restrict public access
  #checkov:skip=CKV2_AZURE_41:Ensure storage account is configured with SAS expiration policy
  #checkov:skip=CKV2_AZURE_21:Ensure Storage logging is enabled for Blob service for read requests
  #checkov:skip=CKV2_AZURE_33:Ensure storage account is configured with private endpoint
  #checkov:skip=CKV2_AZURE_40:Ensure storage account is not configured with Shared Key authorization
  #checkov:skip=CKV2_AZURE_1:Ensure storage for critical data are encrypted with Customer Managed Key
  #checkov:skip=CKV2_AZURE_38:Ensure soft-delete is enabled on Azure storage account
  name                     = "${var.storage_account_name}${random_integer.num.result}${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "sct" {
  name                 = "terraform-state"
  storage_account_name = azurerm_storage_account.sa.name
}

data "azurerm_storage_account_sas" "state" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  resource_types {
    object    = true
    container = true
    service   = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "17520h") # 2 years

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}
