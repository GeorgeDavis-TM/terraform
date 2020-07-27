resource "azurerm_network_security_group" "georged-ssh-sg" {
  name                = "georged-ssh-sg"
  location            = var.defaultAzureRegion
  resource_group_name = var.defaultAzureResourceGroupName

  security_rule {
    name                       = "ssh-access-rule"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = var.localIpCidr
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }

  tags = {
    Owner = var.tagOwner
  }
}