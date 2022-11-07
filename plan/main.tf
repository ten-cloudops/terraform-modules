resource "azurerm_app_service_plan" "gaia_app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.app_plan_kind
  reserved            = var.app_plan_reservation
  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}
