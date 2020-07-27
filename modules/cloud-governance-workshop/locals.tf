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
}