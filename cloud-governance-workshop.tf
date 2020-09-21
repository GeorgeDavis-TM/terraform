# -------------------------------------------------------------------
### AWS
# -------------------------------------------------------------------

module "cgw-team1" {
  source      = "./modules/aws-cloud-governance-workshop"
  teamTag     = "team1"
  teamMembers = ["yama_saadat@trendmicro.com", "george_davis@trendmicro.com", "antoine_saikaley@trendmicro.com"]
  providers = {
    aws = aws.use1
  }
}

module "cgw-team2" {
  source      = "./modules/aws-cloud-governance-workshop"
  teamTag     = "team2"
  teamMembers = ["todd_mccullough@trendmicro.com", "david_giry@trendmicro.com"]
  providers = {
    aws = aws.use1
  }
}

module "cgw-team3" {
  source      = "./modules/aws-cloud-governance-workshop"
  teamTag     = "team3"
  teamMembers = ["jay_kammerer@trendmicro.com", "gabriel_smyth@trendmicro.com"]
  providers = {
    aws = aws.use1
  }
}

# module "cgw-team4" {
#   source      = "./modules/aws-cloud-governance-workshop"
#   teamTag     = "team4"
#   teamMembers = ["yama_saadat@trendmicro.com", "george_davis@trendmicro.com"]
#   providers = {
#     aws = aws.use1
#   }
# }

# module "cgw-team5" {
#   source      = "./modules/aws-cloud-governance-workshop"
#   teamTag     = "team5"
#   teamMembers = ["yama_saadat@trendmicro.com", "george_davis@trendmicro.com"]
#   providers = {
#     aws = aws.use1
#   }
# }

# module "cgw-team6" {
#   source      = "./modules/aws-cloud-governance-workshop"
#   teamTag     = "team6"
#   teamMembers = ["yama_saadat@trendmicro.com", "george_davis@trendmicro.com"]
#   providers = {
#     aws = aws.use1
#   }
# }

# module "cgw-team7" {
#   source      = "./modules/aws-cloud-governance-workshop"
#   teamTag     = "team7"
#   teamMembers = ["george_davis@trendmicro.com"]
#   providers = {
#     aws = aws.use1
#   }
# }

# -------------------------------------------------------------------
### AZURE
# -------------------------------------------------------------------

module "cgw-team8" {
  source      = "./modules/azure-cloud-governance-workshop"
  teamTag     = "team8"
  teamMembers = ["george_davis@trendmicro.com"]
}

# module "cgw-team9" {
#   source      = "./modules/azure-cloud-governance-workshop"
#   teamTag     = "team9"
#   teamMembers = ["yama_saadat@tclabs.ca"]
# }

# module "cgw-team10" {
#   source      = "./modules/azure-cloud-governance-workshop"
#   teamTag     = "team10"
#   teamMembers = ["yama_saadat@tclabs.ca"]
# }

# module "cgw-team11" {
#   source      = "./modules/azure-cloud-governance-workshop"
#   teamTag     = "team11"
#   teamMembers = ["yama_saadat@tclabs.ca"]
# }