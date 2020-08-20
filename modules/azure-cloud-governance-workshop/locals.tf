locals {
  dsaScriptName      = "dsa_deploy_linux.sh"
  dsaSourcePath      = join("", ["./shell-scripts/", local.dsaScriptName])
  dsaDestinationPath = join("", ["/tmp/", local.dsaScriptName])

  vmUser          = "ec2-user"
  vmPass          = "ec2-user"
  mysqlDbRootUser = "root"
  mysqlDbRootPass = "Windows1!Windows1!"
  mysqlHostIP     = "3.20.89.105"

  conformityAzAccountId = "6RSBdHc7r"
}