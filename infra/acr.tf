resource "azurerm_container_registry" "acr" {
  name                     = "acr-javacicd${random_string.suffix.result}"
  resource_group_name      = "${azurerm_resource_group.this.name}"
  location                 = "${azurerm_resource_group.this.location}"
  sku                      =  "Basic"
  admin_enabled            = false

  tags = {
    Environment = var.environment
  }
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

# output "acr_admin_username" {
#   value = azurerm_container_registry.acr.admin_username
#   sensitive = true
# }

# output "acr_admin_password" {
#   value = azurerm_container_registry.acr.admin_password
#   sensitive = true
# }