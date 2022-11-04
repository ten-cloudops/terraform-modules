
#########   Global variables
##################################################################
variable "resource_group_name" {
  description = "Application resource group"
  type = string
}
variable "location" {
  description = "Resources Azure Regional location"
  type = string
}

#########   VMs variables
##################################################################
variable "vm_name" {
  description = "Windows VM name"
  type = string
}
variable "virtual_machines_parameters" {
  description = "Virtual Machines parameters"
  type = map(string)
}
variable "virtual_machines_ip_parameters" {
  description = "Virtual Machines network parameters"
  type = map(string)
}
variable "virtual_machines_data_disk_parameters" {
  description = "Virtual Machines data disk parameters"
  type = map(string)
}
variable "tags" {
  description = "Resource tags"
  type = map(string)
}
variable "windows_vm_user" {
  description = "Windows VM user"
  type = string
}
variable "windows_vm_password" {
  description = "Windows VM user password"
  type = string
}

