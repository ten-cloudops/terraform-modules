
resource "azurerm_network_interface" "windows_virtual_machine_network" {
  name                            = join("-", [var.vm_name,"net"])
  resource_group_name             = var.resource_group_name
  location                        = var.location
  enable_accelerated_networking   = lookup(var.virtual_machines_ip_parameters,"accel_network")
  ip_configuration {
    name                          = join("-", [var.vm_name,"net-config"])
    subnet_id                     = lookup(var.virtual_machines_ip_parameters,"subnet_id")
    private_ip_address_allocation = lookup(var.virtual_machines_ip_parameters,"private_ip_address_allocation")
    private_ip_address            = lookup(var.virtual_machines_ip_parameters,"private_ip_address_allocation") == "Dynamic" ? null : lookup(var.virtual_machines_ip_parameters,"static_ip_address")
  }
}

resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  depends_on                    = [azurerm_network_interface.windows_virtual_machine_network]
  name                          = var.vm_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  network_interface_ids         = [azurerm_network_interface.windows_virtual_machine_network.id]
  size                          = lookup(var.virtual_machines_parameters,"windows_vm_size")
  source_image_id               = lookup(var.virtual_machines_parameters,"windows_vm_image")
  timezone                      = lookup(var.virtual_machines_parameters,"windows_vm_timezone")
  computer_name                 = var.vm_name
  license_type                  = lookup(var.virtual_machines_parameters,"windows_vm_license_type")
  admin_username                = var.windows_vm_user
  admin_password                = var.windows_vm_password
  tags                          = var.tags
  os_disk {
    name                        = join("-", [var.vm_name,"os","disk"])
    caching                     = lookup(var.virtual_machines_parameters,"windows_vm_os_disk_caching")
    storage_account_type        = lookup(var.virtual_machines_parameters,"windows_vm_os_disk_scc_type")
    disk_size_gb                = lookup(var.virtual_machines_parameters,"windows_vm_os_disk_size_gb")
  }
  winrm_listener {
    protocol                    = lookup(var.virtual_machines_parameters,"windows_vm_winrm_protocol")
  }
  lifecycle {
    prevent_destroy             = false
    ignore_changes              = [tags]
  }
}

resource "azurerm_managed_disk" "windows_virtual_machine_data_disk" {
  name                          = join("-", [var.vm_name,"data","disk"])
  resource_group_name           = var.resource_group_name
  location                      = var.location
  storage_account_type          = lookup(var.virtual_machines_data_disk_parameters,"windows_vm_data_disk_storage_account_type")
  create_option                 = lookup(var.virtual_machines_data_disk_parameters,"windows_vm_data_disk_create_option")
  disk_size_gb                  = lookup(var.virtual_machines_data_disk_parameters,"windows_vm_data_disk_size_gb")
  tags                          = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_virtual_machine_data_disk_association" {
  managed_disk_id               = azurerm_managed_disk.windows_virtual_machine_data_disk.id
  virtual_machine_id            = azurerm_windows_virtual_machine.windows_virtual_machine.id
  lun                           = lookup(var.virtual_machines_data_disk_parameters,"windows_vm_data_disk_lun")
  caching                       = lookup(var.virtual_machines_data_disk_parameters,"windows_vm_data_disk_caching")
}
