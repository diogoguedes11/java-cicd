terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "=3.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.38.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

}
provider "helm" {
  kubernetes = {
    host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
  }
}
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate)
}
