resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}
