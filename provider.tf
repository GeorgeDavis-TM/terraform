provider "aws" {
  version = "=2.70.0"
  region  = var.defaultAwsRegion
}

provider "aws" {
  version = "=2.70.0"
  region  = "us-east-1"
  alias   = "use1"
}

provider "azurerm" {
  subscription_id = "18cb46c3-ea58-41c2-8cc6-71d8662f1203"
  tenant_id       = "3e04753a-ae5b-42d4-a86d-d6f05460f9e4"
  version         = "=2.26.0"
  features {}
}

# resource "azurerm_resource_group" "azurerm_rg_tclabs" {
#   name     = "cloudone"
#   location = "Canada Central"

#   tags = {
#     Owner = var.tagOwner
#   }
# }

# resource "azurerm_virtual_network" "azurerm_vnet_tclabs" {
#   name                = "cloudone-vnet"
#   address_space       = ["10.1.0.0/24"]
#   location            = azurerm_resource_group.azurerm_rg_tclabs.location
#   resource_group_name = azurerm_resource_group.azurerm_rg_tclabs.name

#   tags = {
#     Owner = var.tagOwner
#   }
# }

# resource "azurerm_subnet" "azurerm_subnet_tclabs" {
#   name                 = "default"
#   resource_group_name  = azurerm_resource_group.azurerm_rg_tclabs.name
#   virtual_network_name = azurerm_virtual_network.azurerm_vnet_tclabs.name
#   address_prefixes     = ["10.1.0.0/24"]
# }