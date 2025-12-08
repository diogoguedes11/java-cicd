
resource "azurerm_kubernetes_cluster" "this" {
  name                = "java-cicd-aks"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "java-cicd-aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B4ms" # 4 vCPUs, 16 GB RAM
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
