# -------------------------------------------------------------------
### AWS
# -------------------------------------------------------------------

# module "cgw-team1" {
#   source  = "./modules/aws-cloud-governance-workshop"
#   teamTag = "team1"
# }

# module "cgw-team2" {
#   source  = "./modules/aws-cloud-governance-workshop"
#   teamTag = "team2"
# }

# module "cgw-team3" {
#   source  = "./modules/aws-cloud-governance-workshop"
#   teamTag = "team3"
# }

module "cgw-team4" {
  source  = "./modules/aws-cloud-governance-workshop"
  teamTag = "team4"
}

# module "cgw-team5" {
#   source  = "./modules/aws-cloud-governance-workshop"
#   teamTag = "team5"
# }

# -------------------------------------------------------------------
### AZURE
# -------------------------------------------------------------------

# module "cgw-team6" {
#   source  = "./modules/azure-cloud-governance-workshop"
#   teamTag = "team6"
# }

module "cgw-team7" {
  source  = "./modules/azure-cloud-governance-workshop"
  teamTag = "team7"
}