locals {
  dsaScriptName      = "dsa_deploy_linux.sh"
  dsaSourcePath      = join("", ["./shell-scripts/", local.dsaScriptName])
  dsaDestinationPath = join("", ["/tmp/", local.dsaScriptName])

  ubuntuUser      = "user"
  ubuntuPass      = "user"
  mysqlDbRootUser = "root"
  mysqlDbRootPass = "root"
  mysqlHostIP     = "192.168.2.37"
}