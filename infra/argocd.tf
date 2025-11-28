resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
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

