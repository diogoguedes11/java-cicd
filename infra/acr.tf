resource "azurerm_container_registry" "acr" {
  # name                = "acrjavacicd${random_string.suffix.result}"
  name                = "acrjavacicda9mq0s"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Environment = var.environment
  }
}
