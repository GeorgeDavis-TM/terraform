variable "region" {
  default = "us-east-2"
}
variable "availabilityZone" {
  default = "us-east-2a"
}
variable "instanceType" {
  default = "t2.micro"
}
variable "keyName" {
  default = "CloudOne"
}
variable "keyPath" {
  default = "~/Downloads/CloudOne.pem"
}
variable "volumeType" {
  default = "gp2"
}
variable "volumeSize" {
  default = 40
}
variable "tagOwner" {
  default = "george_davis@trendmicro.com"
}
variable "localIpCidr" {
  default = "142.116.0.0/15"
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