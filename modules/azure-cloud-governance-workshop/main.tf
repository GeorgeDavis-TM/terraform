resource "random_string" "unique-id" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

resource "azurerm_public_ip" "cgw-az-public-ip" {
  name                = join("", ["cgw-az-public-ip-", random_string.unique-id.result])
  resource_group_name = var.defaultAzureResourceGroupName
  location            = var.defaultAzureRegion
  allocation_method   = "Static"

  tags = {
    Name      = join("", ["cgw-az-public-ip-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "azurerm_network_interface" "cgw-az-nic" {
  name                = join("", ["cgw-az-nic-", random_string.unique-id.result])
  location            = var.defaultAzureRegion
  resource_group_name = var.defaultAzureResourceGroupName

  # ip_configuration {
  #   name                          = "internal"
  #   subnet_id                     = var.defaultAzureSubnetId
  #   private_ip_address_version    = "IPv4"
  #   private_ip_address_allocation = "Dynamic"
  # }

  ip_configuration {
    primary                       = true
    name                          = "public"
    subnet_id                     = var.defaultAzureSubnetId
    public_ip_address_id          = azurerm_public_ip.cgw-az-public-ip.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Name      = join("", ["cgw-az-nic-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "azurerm_network_security_group" "cgw-az-ssh-sg" {
  name                = join("", ["cgw-az-ssh-sg-", random_string.unique-id.result])
  location            = var.defaultAzureRegion
  resource_group_name = var.defaultAzureResourceGroupName

  security_rule {
    name                       = "ssh-access-rule"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }

  tags = {
    Name      = join("", ["cgw-az-ssh-sg-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "azurerm_network_interface_security_group_association" "cgw-az-nic-sg" {
  network_interface_id      = azurerm_network_interface.cgw-az-nic.id
  network_security_group_id = azurerm_network_security_group.cgw-az-ssh-sg.id
}

resource "azurerm_linux_virtual_machine" "cgw-az-vm" {
  name                = join("", ["cgw-az-vm-", random_string.unique-id.result])
  resource_group_name = var.defaultAzureResourceGroupName
  location            = var.defaultAzureRegion
  size                = "Standard_D2s_v3"

  admin_username = "ubuntu"

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.cgw-az-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.defaultAzVolumeSize
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    Name      = join("", ["cgw-az-vm-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }

  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the new AWS instance.
  provisioner "file" {
    source      = local.dsaSourcePath
    destination = local.dsaDestinationPath
  }
  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.dsaDestinationPath}",
      "sudo ${local.dsaDestinationPath}",
    ]
  }

  # Login to the ubuntu with the admin password.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_public_ip.cgw-az-public-ip.ip_address
  }
}

resource "azurerm_managed_disk" "cgw-az-vol" {
  name                 = join("", ["cgw-az-vm-", random_string.unique-id.result])
  resource_group_name  = var.defaultAzureResourceGroupName
  location             = var.defaultAzureRegion
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.defaultAzVolumeSize
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.cgw-az-vol.id
  virtual_machine_id = azurerm_linux_virtual_machine.cgw-az-vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_storage_account" "cgw-az-sa" {
  name                     = join("", ["cgwazsa", random_string.unique-id.result])
  resource_group_name      = var.defaultAzureResourceGroupName
  location                 = var.defaultAzureRegion
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Name      = join("", ["cgw-az-sa-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "azurerm_storage_container" "cgw-az-sc" {
  name                  = join("", ["cgw-az-sc-", random_string.unique-id.result])
  storage_account_name  = azurerm_storage_account.cgw-az-sa.name
  container_access_type = "blob"
}

resource "azurerm_lb" "cgw-az-lb" {
  name                = join("", ["cgw-az-lb-", random_string.unique-id.result])
  resource_group_name = var.defaultAzureResourceGroupName
  location            = var.defaultAzureRegion

  tags = {
    Name      = join("", ["cgw-az-lb-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "azurerm_key_vault" "cgw-az-kv" {
  name                            = join("", ["cgw-az-kv-", random_string.unique-id.result])
  location                        = var.defaultAzureRegion
  resource_group_name             = var.defaultAzureResourceGroupName
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enabled_for_deployment          = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled             = false
  purge_protection_enabled        = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get", "list"
    ]

    secret_permissions = [
      "get", "list"
    ]

    storage_permissions = [
      "get", "list"
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {
    Name      = join("", ["cgw-az-kv-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

# resource "azurerm_key_vault_key" "cgw-az-kv-key" {
#   name         = join("", ["cgw-az-kv-key-", random_string.unique-id.result])
#   key_vault_id = azurerm_key_vault.cgw-az-kv.id
#   key_type     = "RSA"
#   key_size     = 2048

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]

#   tags = {
#     Name      = join("", ["cgw-az-kv-key-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "azurerm_key_vault_secret" "cgw-az-kv-secret" {
#   name         = join("", ["cgw-az-kv-secret-", random_string.unique-id.result])
#   value        = join("", ["cgw-", random_string.unique-id.result])
#   key_vault_id = azurerm_key_vault.cgw-az-kv.id

#   tags = {
#     Name      = join("", ["cgw-az-kv-secret-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

resource "aws_cloudformation_stack" "cgw-aws-sns" {
  name = join("", ["cgw-aws-sns-", random_string.unique-id.result])
  template_body = templatefile("${path.module}/email-sns-stack.json-template.tpl", {
    display_name  = join("", ["cgw-aws-sns-", random_string.unique-id.result])
    subscriptions = join(",", formatlist("{ \"Endpoint\": \"%s\", \"Protocol\": \"email\"  }", var.teamMembers))
  })

  tags = {
    Name      = join("", ["cgw-aws-sns-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-az-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_sns_topic_policy" "cgw-aws-sns-policy" {
  arn    = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
  policy = data.aws_iam_policy_document.cgw-aws-sns-policy-doc.json
}

resource "local_file" "mysql-script" {
  content = templatefile("${path.module}/db-insert-az-template.tpl", {
    cgw-az-uuid      = random_string.unique-id.result
    cgw-az-public-ip = azurerm_public_ip.cgw-az-public-ip.ip_address
    cgw-az-nic       = azurerm_network_interface.cgw-az-nic.id
    cgw-az-vm        = azurerm_linux_virtual_machine.cgw-az-vm.id
    cgw-az-sc        = azurerm_storage_container.cgw-az-sc.id
    # cgw-iam-user             = aws_iam_user.cgw-iam-user.name
    # cgw-iam-user-password    = aws_iam_user_login_profile.cgw-iam-user-login-profile.encrypted_password
    # cgw-iam-role             = aws_iam_role.cgw-iam-role.name
    # cgw-iam-instance-profile = aws_iam_instance_profile.cgw-iam-instance-profile.name
    # cgw-iam-policy           = aws_iam_policy.cgw-iam-policy.name
    cgw-az-ssh-sg = azurerm_network_security_group.cgw-az-ssh-sg.id
  })
  filename = "${path.module}/mysql-script-${random_string.unique-id.result}.sql"
}

resource "null_resource" "mysql-run" {
  connection {
    type        = "ssh"
    user        = local.vmUser
    private_key = file(var.dbAwsKeyPairFilePath)
    host        = local.mysqlHostIP
  }

  provisioner "file" {
    # source      = "./${path.module}/mysql-script-${random_string.unique-id.result}.sql"
    content = templatefile("${path.module}/db-insert-az-template.tpl", {
      cgw-az-uuid      = random_string.unique-id.result
      cgw-az-public-ip = azurerm_public_ip.cgw-az-public-ip.ip_address
      cgw-az-nic       = azurerm_network_interface.cgw-az-nic.id
      cgw-az-vm        = azurerm_linux_virtual_machine.cgw-az-vm.id
      cgw-az-sc        = azurerm_storage_container.cgw-az-sc.id
      # cgw-iam-user             = aws_iam_user.cgw-iam-user.name
      # cgw-iam-user-password    = aws_iam_user_login_profile.cgw-iam-user-login-profile.encrypted_password
      # cgw-iam-role             = aws_iam_role.cgw-iam-role.name
      # cgw-iam-instance-profile = aws_iam_instance_profile.cgw-iam-instance-profile.name
      # cgw-iam-policy           = aws_iam_policy.cgw-iam-policy.name
      cgw-az-ssh-sg = azurerm_network_security_group.cgw-az-ssh-sg.id
    })
    destination = "/tmp/mysql-script.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "mysql -u ${local.mysqlDbRootUser} -p${local.mysqlDbRootPass} < /tmp/mysql-script.sql",
      "rm -rf /tmp/mysql-script.sql"
    ]
  }
}

resource "local_file" "cgw-conformity-api-az-script" {
  content = templatefile("${path.module}/az-conformity-api-cmd-template.tpl", {
    cgw-az-uuid               = random_string.unique-id.result
    cgw-aws-cf-stack-arn      = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
    cgw-az-conformity-acct-id = local.conformityAzAccountId
  })
  filename = "${path.module}/az-conformity-api-cmd-${random_string.unique-id.result}.sh"
}

resource "null_resource" "cgw-conformity-api-az-script-run" {
  provisioner "local-exec" {
    command     = "${path.module}/az-conformity-api-cmd-${random_string.unique-id.result}.sh"
    interpreter = ["/bin/bash"]
  }
}