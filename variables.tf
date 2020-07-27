variable "defaultAwsRegion" {
  default     = "us-east-2"
  description = "Default AWS Region"
}

variable "defaultAwsAvailabilityZone" {
  default     = "us-east-2a"
  description = "Default AWS Availability Zone"
}

variable "defaultAwsInstanceType" {
  default     = "t2.micro"
  description = "Default AWS Instance Type"
}

variable "defaultAwsKeyName" {
  default     = "CloudOne"
  description = "Default AWS Key Name"
}

variable "defaultAwsKeyFilePath" {
  default     = "~/Downloads/CloudOne.pem"
  description = "Default AWS Key File Path"
}

variable "defaultAwsIamInstanceProfileName" {
  default     = "Cloud1"
  description = "Default AWS IAM Instance Profile Name"
}

variable "defaultAwsVolumeType" {
  default     = "gp2"
  description = "Default AWS Volume Type"
}

variable "defaultAwsVolumeSize" {
  default     = 40
  description = "Default AWS Volume Size"
}

variable "tagOwner" {
  default     = "george_davis@trendmicro.com"
  description = "Default AWS Resource Tag:Owner Value"
}

variable "localIpCidr" {
  default     = "142.116.0.0/15"
  description = "Default AWS Local IP CIDR"
}

variable "defaultAwsSubnetId" {
  default     = "subnet-c1dc41a8"
  description = "Default AWS Subnet ID"
}

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

# variable "subnet" {
#    default = "subnet-<PUT IN YOUR VPC SUBNET>"
# }
# variable "securityGroups" {
#    type = list
#    default = [ "sg-<PUT IN YOUR VPC SECURITY GROUP>" ]
# }
# variable "instanceName" {
#    default = "<PUT IN YOUR INSTANCE NAME>"
# }
# ami-0b898040803850657 is the free Amazon Linux 2 AMI
# for the us-east-1 region. Amazon Linux 2 
# is a downstream version of Red Hat Enterprise Linux / 
# Fedora / CentOS. It is analogous to RHEL 7.
# variable "amis" {
#    default = {
#      "us-east-1" = "ami-0b898040803850657"
#    }
# }