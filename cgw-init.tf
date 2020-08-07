resource "null_resource" "cgw-init" {

  triggers = {
    always_run = "${timestamp()}"
  }

  connection {
    type     = "ssh"
    user     = local.ubuntuUser
    password = local.ubuntuPass
    host     = local.mysqlHostIP
  }

  provisioner "local-exec" {
    command = "find . -type f -name '*.tf' -exec terraform fmt {} \\;"
  }

  #   provisioner "remote-exec" {
  #     inline = [
  #       "mysql -u ${local.mysqlDbRootUser} -p${local.mysqlDbRootPass} -e 'DROP DATABASE tm_cgw_db;'"
  #     ]
  #   }
}