variable "teamTag" {} # Input parameter from the root module invocation

variable "defaultAzureRegion" {
  default     = "Canada Central"
  description = "Default Azure Region"
}

variable "defaultAzureResourceGroupName" {
  default     = "cloudone"
  description = "Default Azure Resource Group Name"
}

variable "defaultAzureVirtualNetwork" {
  default     = "cloudone-vnet"
  description = "Default Azure Virtual Network Name"
}

variable "defaultAzureSubnetId" {
  default     = "/subscriptions/18cb46c3-ea58-41c2-8cc6-71d8662f1203/resourceGroups/cloudone/providers/Microsoft.Network/virtualNetworks/cloudone-vnet/subnets/default"
  description = "Default Azure Subnet Name"
}

variable "tagOwner" {
  default     = "george_davis@trendmicro.com"
  description = "Default AWS Resource Tag:Owner Value"
}

variable "defaultAzVolumeSize" {
  default     = 40
  description = "Default Azure Root Volume Size"
}

variable "dbAwsKeyPairFilePath" {
  default     = "~/Downloads/CloudOne.pem"
  description = "DB AWS Key Pair File Path"
}