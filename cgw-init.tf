resource "null_resource" "cgw-init" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "find . -type f -name '*.tf' -exec terraform fmt {} \\;"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "mysql -u ${local.mysqlDbRootUser} -p${local.mysqlDbRootPass} -e 'DROP DATABASE tm_cgw_db;'"
  #   ]

  #   connection {
  #     type     = "ssh"
  #     user     = local.vmUser
  #     password = local.vmPass
  #     host     = local.mysqlHostIP
  #   }
  # }
}