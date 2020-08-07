output "cgw-az-uuid" {
  description = "Unique ID for the Resource Group"
  value       = random_string.unique-id.result
}

output "cgw-az-public-ip" {
  description = "Public IP of the Azure VM Instance"
  value       = azurerm_public_ip.cgw-az-public-ip.ip_address
}

output "cgw-az-nic" {
  description = "Network Interface ID of the Azure VM Instance"
  value       = azurerm_network_interface.cgw-az-nic.id
}

output "cgw-az-vm" {
  description = "VM ID of the Azure VM Instance"
  value       = azurerm_linux_virtual_machine.cgw-az-vm.id
}

output "cgw-az-sc" {
  description = "Storage Container ID of the Azure Blob Storage"
  value       = azurerm_storage_container.cgw-az-sc.id
}

output "cgw-az-ssh-sg" {
  description = "Name of the Azure Network Security Group"
  value       = azurerm_network_security_group.cgw-az-ssh-sg.id
}