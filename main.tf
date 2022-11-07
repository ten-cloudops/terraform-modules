module "plan" {
  source              = "/plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_plan_kind       = var.app_plan_kind
  app_plan_reservation = var.app_plan_reservation
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
}
