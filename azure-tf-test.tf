# resource "azurerm_network_interface" "georged-tf-test-nic" {
#   name                = "georged-tf-test-nic"
#   location            = var.defaultAzureRegion
#   resource_group_name = var.defaultAzureResourceGroupName

#   # ip_configuration {
#   #   name                          = "internal"
#   #   subnet_id                     = var.defaultAzureSubnetId
#   #   private_ip_address_version    = "IPv4"
#   #   private_ip_address_allocation = "Dynamic"
#   # }

#   ip_configuration {
#     primary                       = true
#     name                          = "public"
#     subnet_id                     = var.defaultAzureSubnetId
#     public_ip_address_id          = azurerm_public_ip.george-tf-test-public-ip.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = {
#     Owner = var.tagOwner
#   }
# }

# resource "azurerm_network_interface_security_group_association" "georged-tf-test-nic" {
#   network_interface_id      = azurerm_network_interface.georged-tf-test-nic.id
#   network_security_group_id = azurerm_network_security_group.georged-ssh-sg.id
# }

# resource "azurerm_public_ip" "george-tf-test-public-ip" {
#   name                = "george-tf-test-public-ip"
#   resource_group_name = var.defaultAzureResourceGroupName
#   location            = var.defaultAzureRegion
#   allocation_method   = "Static"

#   tags = {
#     Owner = var.tagOwner
#   }
# }

# resource "azurerm_linux_virtual_machine" "georged-tf-test" {
#   name                = "georged-tf-test"
#   resource_group_name = var.defaultAzureResourceGroupName
#   location            = var.defaultAzureRegion
#   size                = "Standard_D2s_v3"

#   admin_username                  = "ubuntu"
#   admin_password                  = "Windows1!"
#   disable_password_authentication = false

#   network_interface_ids = [
#     azurerm_network_interface.georged-tf-test-nic.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   tags = {
#     Owner = var.tagOwner
#   }

#   # Copy in the bash script we want to execute.
#   # The source is the location of the bash script
#   # on the local linux box you are executing terraform
#   # from.  The destination is on the new AWS instance.
#   provisioner "file" {
#     source      = local.dsaSourcePath
#     destination = local.dsaDestinationPath
#   }
#   # Change permissions on bash script and execute from ec2-user.
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x ${local.dsaDestinationPath}",
#       "sudo ${local.dsaDestinationPath}",
#     ]
#   }

#   # Login to the ubuntu with the admin password.
#   connection {
#     type     = "ssh"
#     user     = "ubuntu"
#     password = "Windows1!"
#     host     = self.public_ip_address
#   }
# }

# output "georged-tf-test-vip" {
#   value = azurerm_linux_virtual_machine.georged-tf-test.public_ip_address
# }