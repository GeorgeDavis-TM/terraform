variable "teamTag" {
  type = string
} # Input parameter from the root module invocation

variable "teamMembers" {
  type = list(string)
} # Input parameter from the root module invocation

variable "defaultAwsRegion" {
  default     = "us-east-1"
  description = "Default AWS Region"
}

variable "defaultAwsVpcId" {
  default     = "vpc-96c5c8f0"
  description = "Default AWS VPC ID"
}

variable "defaultAwsAvailabilityZone" {
  default     = "us-east-1a"
  description = "Default AWS Availability Zone"
}

variable "defaultAwsSubnetId" {
  default     = "subnet-aaf41586"
  description = "Default AWS Subnet ID"
}

variable "defaultAwsKeyPairName" {
  default     = "CGW-Keypair"
  description = "Default AWS Key Pair Name"
}

variable "defaultAwsKeyPairFilePath" {
  default     = "~/Downloads/CGW-Keypair.pem"
  description = "Default AWS Key Pair File Path"
}

variable "dbAwsKeyPairFilePath" {
  default     = "~/Downloads/CloudOne.pem"
  description = "DB AWS Key Pair File Path"
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

variable "defaultAwsIamUserName" {
  default     = "georged"
  description = "Default AWS IAM User Name"
}

variable "defaultPgpPubKeyBase64Encoded" {
  default     = "mQENBF8eTOIBCADE0jkSx/Qg4944I6Jb0MTKGWRsHam5++Bwaa3yCDB36cR0jYRxhkXs2LKO5jF4z5RhdyKjGk/PfFAJc05TqOuHUGpIBWyzUd8r/ZCnoxGLlzj3rkPrP+7Bd9a8O0Y3L+wWKvzYzJ3rn3N9J10un5f7PFKrsIjQHT53oYfQVEnpABIF56cim+ZW+y5SO4l6VscW3htn9Sm+O6UE22o/Xe/sQH4QxU6rXLmJuFvlm6zLCrw+8rIiBZ275mfu8luEkL8iCdhE92Ou6Ed90tBJJCoWH7N7DBPtGpSCjv5l221UXsPj/oSVS49bxXna80ssmzm9tSJPQLVHkTHDV/V76lGTABEBAAG0R0dlb3JnZSBEYXZpcyAoVGVycmFmb3JtIElBTSBVc2VyIEdQRyBLZXkpIDxnZW9yZ2VfZGF2aXNAdHJlbmRtaWNyby5jb20+iQFOBBMBCAA4FiEEumdJtXfZ6FnXL1vFK81dTnV/bCkFAl8eTOICGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQK81dTnV/bClrUgf+JMXYtZeqXySPzv5hUl6tlHJSANuFYNgOIzcpi/ou6ChCpjzEq7FQmUIfWondBMVXubtwZEKx2KSmh8/+lilgsX8zpxMzZjOs+7uM7ViZezbKSeVaZlxpcYdIBGx3pGXzeDern51GH1+xYoOU6Om4LhHhHsS/aQcZkfTaPtsQuNnQzcVUuRbbH8dKXIjA1sjzazEJ4tjpuUl7JGAccEp+z0NTQol2gYZyA2bGbcbtQBwmsjYHbHlYXt7OV78pqQU8mkR7L/kmeMWR7KiEQhN9/hTJlAzdqBb6rpbMkT0cqOYh7HUHDxxSpc1XxW+oQZwPfa8/C2UWZCcD0Yvas3TK77kBDQRfHkziAQgAoykB5P435fsgLE39Uh8JCPZiLzkzijpyACfaDG3Bv2Rd0tSW733el8MEdDOtnNJpVC0N7k/Qj50nbh1kmfWM5kF+NoHBbjs2U6X6ChzHTU9BQT4D3jCMGdfuJXj7m+kqi08W4PYx6fruAWrDbrDCmFdK0y+XFVBXx0o0eFKdah7x8nyxP0MdxZNTD6HZXShATny3NXbNBaedEKn96hRgovo/1cOIfNzpPw8YuzBnA2n7h+vzrUsj46UPba97rpwxXOmARoUevxICWPPRaf7eRQoI7fORXPyFoCblQgivDsvuuZIGXRFKgSMeJQBYVOyEoCgTK4BfToPiC7W9zDnitQARAQABiQE2BBgBCAAgFiEEumdJtXfZ6FnXL1vFK81dTnV/bCkFAl8eTOICGwwACgkQK81dTnV/bClGyQf+JAFlrqZMgq4tSHTv7CfiMnFXvNshIly2/N74XPs+t/quB0ieJ8oM2Zktr6EgNIiPqjWI5gEgYTAfbddA7kcAc78SUPnE15B0x4fsVv0uhnWint8+5WqHug3O5D8e6nbAMgOrJvkHc5K0u9dNGbSrK+ATuVs4VtmBetoSC2hNPKUxj3N3VGxwepre8SxdsNqr6WRK/fcTB2XHEQaDV9N6f9KTON5gHwwQMpPxIOtq59uRCOza+Hdyd0S/IUVDpLnt/rBc9eyMeHNvughavijESFAwum6dNbeL9x9zlivRoGJSQ4C7TLoZHcggGOl9aybe14PDt9LCYNZn7xvUt19EZA=="
  description = "Default PGP Public Key encoded in Base64 - George Davis / george_davis@trendmicro.com / Passphrase - Welcome@123$"
}