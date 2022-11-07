
variable "app_service_plan_name" {
  description = "Service plan name"
  type = string
}

variable "location" {
  description = "resource location"
  type = string
}

variable "resource_group_name" {
  description = "resource group name"
  type = string
}

variable "app_plan_kind" {
  description = "Service plan kind"
  type = string
}

variable "app_plan_reservation" {
  description = "app plan reservation"
  type = string
}

variable "sku_tier" {
  description = "app plan tier"
  type = string
}

variable "sku_size" {
  description = "app plan size"
  type = string
}
