variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
  default     = "rg-java-cicd"
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "java-cicd-aks"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "java-cicd-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}


