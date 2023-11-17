resource "azurerm_kubernetes_cluster" "cluster" {
  #checkov:skip=CKV_AZURE_170: "Ensure that AKS use the Paid Sku for its SLA"
  #checkov:skip=CKV_AZURE_4: "Ensure AKS logging to Azure Monitoring is Configured"
  #checkov:skip=CKV_AZURE_227: "Ensure that the AKS cluster encrypt temp disks, caches, and data flows between Compute and Storage resources"
  #checkov:skip=CKV_AZURE_117: "Ensure that AKS uses disk encryption set"
  #checkov:skip=CKV_AZURE_115: "Ensure that AKS enables private clusters"
  #checkov:skip=CKV_AZURE_172: "Ensure autorotation of Secrets Store CSI Driver secrets for AKS clusters"
  #checkov:skip=CKV_AZURE_116: "Ensure that AKS uses Azure Policies Add-on"
  #checkov:skip=CKV_AZURE_168: "Ensure Azure Kubernetes Cluster (AKS) nodes should use a minimum number of 50 pods."
  #checkov:skip=CKV_AZURE_7: "Ensure AKS cluster has Network Policy configured"

  name                      = "${var.workspace}-aks-${var.environment}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  dns_prefix                = var.workspace
  automatic_channel_upgrade = "stable"
  kubernetes_version        = var.kubernetes_version
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  sku_tier                  = "Free" # Standard
  local_account_disabled = true
  node_resource_group = "nodepool-${var.environment}"

  default_node_pool {
    name                         = "system"
    node_count                   = var.system_pool_node_count
    vm_size                      = var.vm_sku_system_pool
    only_critical_addons_enabled = true
    vnet_subnet_id               = var.system_subnet_id
    max_pods                     = var.max_pods
    min_count                    = 1
    max_count                    = 5
    os_disk_size_gb              = var.os_disk_size_gb
    zones                        = var.use_availability_zones ? ["1", "2", "3"] : []
    os_disk_type                 = "Managed"
    os_sku                       = var.os_sku
    enable_host_encryption       = false
    orchestrator_version         = var.kubernetes_version
    type                         = "VirtualMachineScaleSets"
    enable_auto_scaling          = true

    upgrade_settings {
      max_surge = "20%"
    }

    tags = var.tags
  }

  identity {
    type         = "UserAssigned"
    identity_ids = var.identities
  }

  # kubelet_identity {
  #    client_id                 = azurerm_user_assigned_identity.muiKubelet.client_id
  #    object_id                 = azurerm_user_assigned_identity.muiKubelet.principal_id
  #    user_assigned_identity_id = azurerm_user_assigned_identity.muiKubelet.id
  # }

  # network_profile {
  #   network_plugin    = "azure"
  #   service_cidr      = var.service_cidr
  #   dns_service_ip    = var.dns_service_ip
  #   load_balancer_sku = "standard"
  #   load_balancer_profile {
  #     outbound_ports_allocated = 64000
  #     idle_timeout_in_minutes  = 4
  #     outbound_ip_prefix_ids   = var.snat_prefix_ids
  #   }
  # }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "worker_pool" {
  #checkov:skip=CKV_AZURE_227: "Ensure that the AKS cluster encrypt temp disks, caches, and data flows between Compute and Storage resources"
  #checkov:skip=CKV_AZURE_168: "Ensure Azure Kubernetes Cluster (AKS) nodes should use a minimum number of 50 pods."
  #checkov:skip=CKV2_AZURE_29: "Ensure AKS cluster has Azure CNI networking enabled"

  name = "worker"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.cluster.id
  vm_size                = var.vm_sku_system_pool
  node_count             = var.worker_pool_node_count
  vnet_subnet_id         = var.worker_subnet_id
  max_pods               = var.max_pods
  os_disk_size_gb        = var.os_disk_size_gb
  os_disk_type           = "Managed"
  os_sku                 = var.vm_sku_worker_pool
  enable_host_encryption = false
  orchestrator_version   = var.kubernetes_version
  mode                   = "User"
  zones                  = var.use_availability_zones ? ["1", "2", "3"] : []
  node_taints            = []
  node_labels = {
    compute = "high"
    disk    = "low"
    memory  = "low"
  }

  upgrade_settings {
    max_surge = "20%"
  }

  tags = var.tags

  depends_on = [
    azurerm_kubernetes_cluster.cluster,
  ]
}
