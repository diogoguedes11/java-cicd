# Service principal for Github actions
resource "azuread_application" "github_actions" {
  display_name = "sp-github-actions-acr-push"
}

resource "azuread_service_principal" "github_actions" {
  client_id = azuread_application.github_actions.client_id
}

resource "azuread_service_principal_password" "github_actions" {
  service_principal_id = azuread_service_principal.github_actions.id
}

# Assign "AcrPush" role to this Service Principal
resource "azurerm_role_assignment" "github_to_acr" {
  principal_id         = azuread_service_principal.github_actions.object_id
  role_definition_name = "AcrPush" # Permission to push images
  scope                = azurerm_container_registry.acr.id
}

output "github_actions_client_id" {
  value = azuread_application.github_actions.client_id
}

output "github_actions_client_secret" {
  value     = azuread_service_principal_password.github_actions.value
  sensitive = true
}