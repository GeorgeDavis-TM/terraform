module "cgw-team1" {
  source  = "./modules/cloud-governance-workshop"
  teamTag = "team1"
}

module "cgw-team2" {
  source  = "./modules/cloud-governance-workshop"
  teamTag = "team2"
}