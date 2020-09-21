resource "azurerm_network_security_group" "georged-ssh-sg" {
  name                = "georged-ssh-sg"
  location            = var.defaultAzureRegion
  resource_group_name = var.defaultAzureResourceGroupName

  tags = {
    Owner = var.tagOwner
  }
}

resource "azurerm_network_security_rule" "georged-ssh-sg-rule" {
  count                       = length(var.localIpCidr)
  name                        = join("", ["ssh-access-rule-", count.index])
  description                 = join("", ["Network Security Rule for ", var.localIpCidr[count.index]])
  priority                    = 200 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = var.localIpCidr[count.index]
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  resource_group_name         = var.defaultAzureResourceGroupName
  network_security_group_name = azurerm_network_security_group.georged-ssh-sg.name
}