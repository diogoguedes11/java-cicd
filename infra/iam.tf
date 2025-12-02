resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id

  role_definition_name = "AcrPull"

  scope = azurerm_container_registry.acr.id

  skip_service_principal_aad_check = true
}
