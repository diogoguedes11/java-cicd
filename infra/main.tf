resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "java-cicd-aks"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "java-cicd-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  create_namespace = false
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  values = [
    <<YAML
    redis-ha:
      enabled: false

    controller:
      replicas: 1

    server:
      autoscaling:
        enabled: false

    repoServer:
      autoscaling:
        enabled: false

    configs:
      cm:
        kustomize.buildOptions: --enable-helm --load-restrictor=LoadRestrictionsNone
    YAML
  ]
}

resource "kubernetes_manifest" "java_app_argocd" {
  depends_on = [helm_release.argocd]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "java-demo-app"
      namespace = "argocd"
    }
    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/diogoguedes11/java-cicd.git"
        targetRevision = "main"
        path           = "k8s"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "java-app-ns" # namespace
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }
}
