locals {
  dsaScriptName = join(
    "",
    [
      "dsa_deploy_",
      data.aws_ami.ubuntu-1804.platform == "windows" ? "windows" : "linux",
      data.aws_ami.ubuntu-1804.platform == "windows" ? ".ps1" : ".sh"
    ]
  )
  dsaSourcePath      = join("", ["./shell-scripts/", local.dsaScriptName])
  dsaDestinationPath = join("", ["/tmp/", local.dsaScriptName])

  ubuntuUser      = "user"
  ubuntuPass      = "user"
  mysqlDbRootUser = "root"
  mysqlDbRootPass = "root"
  mysqlHostIP     = "192.168.2.37"
}