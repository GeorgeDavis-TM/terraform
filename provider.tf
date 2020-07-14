provider "aws" {
  region = var.region
}

provider "azurerm" {
  subscription_id = "18cb46c3-ea58-41c2-8cc6-71d8662f1203"
  tenant_id       = "3e04753a-ae5b-42d4-a86d-d6f05460f9e4"
}