resource "random_string" "unique-id" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

# # # [ Phase 1 - Send SNS/SES Subscription Emails ]

resource "aws_cloudformation_stack" "cgw-aws-sns" {
  name = join("", ["cgw-aws-sns-", random_string.unique-id.result])
  template_body = templatefile("${path.module}/email-sns-stack.json-template.tpl", {
    display_name  = join("", ["Cloud Governance Workshop - Team UUID: ", random_string.unique-id.result])
    subscriptions = join(",", formatlist("{ \"Endpoint\": \"%s\", \"Protocol\": \"email\"  }", var.teamMembers))
  })

  tags = {
    Name      = join("", ["cgw-aws-sns-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_sns_topic_policy" "cgw-aws-sns-policy" {
  arn    = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
  policy = data.aws_iam_policy_document.cgw-aws-sns-policy-doc.json
}

resource "aws_iam_user" "cgw-aws-iam-user" {
  name = join("", ["cgw-aws-iam-user-", random_string.unique-id.result])
  path = "/"

  tags = {
    Name      = join("", ["cgw-aws-iam-user-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_iam_role" "cgw-aws-iam-role" {
  name               = join("", ["cgw-aws-iam-role-", random_string.unique-id.result])
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF

  tags = {
    Name      = join("", ["cgw-aws-iam-role-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_iam_instance_profile" "cgw-aws-iam-instance-profile" {
  name = join("", ["cgw-aws-iam-instance-profile-", random_string.unique-id.result])
  role = aws_iam_role.cgw-aws-iam-role.name
}

resource "aws_iam_policy" "cgw-aws-iam-policy" {
  name        = join("", ["cgw-aws-iam-policy-", random_string.unique-id.result])
  description = join("", ["cgw-aws-iam-policy-", random_string.unique-id.result, " for ", aws_iam_user.cgw-aws-iam-user.name])
  path        = "/"
  policy      = data.aws_iam_policy_document.cgw-aws-iam-policy-doc.json
}

resource "aws_iam_role_policy_attachment" "cgw-aws-iam-role-policy-attach" {
  role       = aws_iam_role.cgw-aws-iam-role.name
  policy_arn = aws_iam_policy.cgw-aws-iam-policy.arn
}

resource "aws_iam_user_policy_attachment" "cgw-aws-iam-user-policy-attach" {
  user       = aws_iam_user.cgw-aws-iam-user.name
  policy_arn = aws_iam_policy.cgw-aws-iam-policy.arn
}

# # # [ End: Phase 1 - Send SNS/SES Subscription Emails ]



# # # # [ Phase 1 - Spin Up Resources ]

resource "aws_iam_user_login_profile" "cgw-aws-iam-user-login-profile" {
  user                    = aws_iam_user.cgw-aws-iam-user.name
  password_reset_required = false
  pgp_key                 = "keybase:georgedavistm"
}

resource "local_file" "cgw-aws-iam-user-password-decrypt" {
  content  = <<EOF
echo ${aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password} | base64 --decode | keybase pgp decrypt > ${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt
EOF
  filename = "${path.module}/local_files/cgw-aws-iam-user-password-decrypt-${random_string.unique-id.result}.sh"
}

# resource "null_resource" "cgw-aws-iam-user-password-decrypt-run" {
#   provisioner "local-exec" {
#     command     = "./${path.module}/local_files/cgw-aws-iam-user-password-decrypt-${random_string.unique-id.result}.sh"
#     interpreter = ["/bin/bash"]
#   }
#   depends_on = [
#     local_file.cgw-aws-iam-user-password-decrypt
#   ]
# }

# resource "local_file" "cgw-aws-iam-user-ses-email-destinations" {
#   content  = join(",", formatlist("{ \"Destination\": { \"ToAddresses\": [ \"%s\" ] } }", var.teamMembers))
#   filename = "${path.module}/local_files/cgw-aws-iam-user-ses-email-destinations-${random_string.unique-id.result}.json"
#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run
#   ]
# }

# resource "local_file" "cgw-aws-iam-user-ses-template-json" {
#   content = templatefile("${path.module}/cgw-aws-iam-user-ses-trigger.json-template.tpl", {
#     cgw-workshop-web                        = local.cgwWorkshopWebUrl
#     cgw-aws-uuid                            = random_string.unique-id.result
#     cgw-aws-console-url                     = local.awsConsoleUrl
#     cgw-aws-account-id                      = local.awsAccountId
#     cgw-aws-iam-user                        = aws_iam_user.cgw-aws-iam-user.name
#     cgw-aws-iam-user-console-password       = file("${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt")
#     cgw-aws-iam-user-ses-email-destinations = file("${path.module}/local_files/cgw-aws-iam-user-ses-email-destinations-${random_string.unique-id.result}.json")
#   })
#   filename = "${path.module}/local_files/cgw-aws-iam-user-ses-email-${random_string.unique-id.result}.json"
#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run,
#     local_file.cgw-aws-iam-user-ses-email-destinations
#   ]
# }

# resource "local_file" "cgw-aws-iam-user-ses-send-templated-email-script" {
#   content  = <<EOF
# cd ${path.module}/local_files
# aws ses send-bulk-templated-email --cli-input-json file://cgw-aws-iam-user-ses-email-${random_string.unique-id.result}.json
# EOF
#   filename = "${path.module}/local_files/cgw-aws-iam-user-ses-send-templated-email-script-${random_string.unique-id.result}.sh"
# }

# resource "null_resource" "cgw-aws-iam-user-ses-send-templated-email-script-run" {
#   provisioner "local-exec" {
#     command     = "./${path.module}/local_files/cgw-aws-iam-user-ses-send-templated-email-script-${random_string.unique-id.result}.sh"
#     interpreter = ["/bin/bash"]
#   }
#   depends_on = [
#     local_file.cgw-aws-iam-user-ses-template-json,
#     local_file.cgw-aws-iam-user-ses-send-templated-email-script
#   ]
# }

# resource "aws_instance" "cgw-aws-instance" {
#   availability_zone      = var.defaultAwsAvailabilityZone
#   ami                    = data.aws_ami.amzn-linux-2.image_id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.cgw-aws-ssh-sg.id] # TODO: Enable Code Server - aws_security_group.cgw-aws-codeserver-sg.id
#   key_name               = var.defaultAwsKeyPairName
#   iam_instance_profile   = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name

#   root_block_device {
#     volume_type = var.defaultAwsVolumeType
#     volume_size = var.defaultAwsVolumeSize
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-ec2-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }

#   provisioner "file" {
#     source      = local.dsaSourcePath
#     destination = local.dsaDestinationPath

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "file" {
#     source      = "${path.module}/code-server_deploy"
#     destination = "~/code-server_deploy"

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x ${local.dsaDestinationPath}",
#       "sudo ${local.dsaDestinationPath}",
#       "sudo mkdir -p ~/.config/code-server",
#       "sudo touch ~/.config/code-server/config.yaml",
#       "sudo chown -R ec2-user:ec2-user ~/.config/code-server",
#       "sudo mkdir -p ~/vscode/user-data/User",
#       "sudo touch ~/vscode/user-data/User/settings.json",
#       "sudo chown -R ec2-user:ec2-user ~/vscode"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "file" {
#     source      = "${path.module}/code-server_deploy/code-server_conformity-extension-settings.json"
#     destination = "~/vscode/user-data/User/settings.json"

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "curl -fsSL https://code-server.dev/install.sh | sh",
#       "sudo chown -R ec2-user:ec2-user ~/.local"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "file" {
#     content = templatefile("${path.module}/code-server_deploy/code-server_config-template.tpl", {
#       cgw-aws-uuid = random_string.unique-id.result
#     })
#     destination = "~/.config/code-server/config.yaml"

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "~/.local/bin/code-server --install-extension ~/code-server_deploy/raphaelbottino.cc-template-scanner-0.4.0.vsix",
#       "rm -f ~/code-server_deploy/*.tpl",
#       "rm -f ~/code-server_deploy/README.md", # TODO: CF Question - Comment to leave clue for Phase 2 with Conformity
#       "~/.local/bin/code-server &"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file(var.defaultAwsKeyPairFilePath)
#       host        = self.public_ip
#     }
#   }
# }

# resource "aws_ebs_volume" "cgw-aws-vol" {
#   size              = var.defaultAwsVolumeSize
#   availability_zone = var.defaultAwsAvailabilityZone

#   tags = {
#     Name       = join("", ["cgw-aws-ebs-vol-", random_string.unique-id.result])
#     InstanceId = aws_instance.cgw-aws-instance.id
#     Owner      = var.tagOwner
#     Team-UUID  = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project    = "cgw"
#     Team       = var.teamTag
#   }
# }

# resource "aws_volume_attachment" "cgw-aws-vol-attach" {
#   device_name = "/dev/sdb"
#   volume_id   = aws_ebs_volume.cgw-aws-vol.id
#   instance_id = aws_instance.cgw-aws-instance.id
# }

# # # # TODO: Do we need the Elastic IPs to run the challenge, AWS limits in us-east-1 have not been improved??
# # # resource "aws_eip" "cgw-aws-instance-public-ip" {
# # #   vpc      = true
# # #   instance = aws_instance.cgw-aws-instance.id

# # #   tags = {
# # #     Name    = join("", ["cgw-aws-instance-public-ip-", random_string.unique-id.result])
# # #     Owner   = var.tagOwner
# # #     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
# # #     Project = "cgw"
# # #     Team    = var.teamTag
# # #   }
# # # }

# resource "aws_s3_bucket" "cgw-aws-s3-bucket" {
#   bucket = join("", ["cgw-aws-s3-bucket-", random_string.unique-id.result])
#   acl    = "public-read"
#   region = var.defaultAwsRegion

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
#     allowed_origins = ["*"]
#     expose_headers  = ["ETag"]
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-s3-bucket-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_security_group" "cgw-aws-ssh-sg" {
#   name        = join("", ["cgw-aws-ssh-sg-", random_string.unique-id.result])
#   description = "Allow SSH traffic"
#   # vpc_id      = "${aws_vpc.main.id }"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-ssh-sg-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_security_group" "cgw-aws-https-sg" {
#   name        = join("", ["cgw-aws-https-sg-", random_string.unique-id.result])
#   description = "Allow HTTPS traffic"
#   # vpc_id      = "${aws_vpc.main.id }"

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-https-sg-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_security_group" "cgw-aws-codeserver-sg" {
#   name        = join("", ["cgw-aws-codeserver-sg-", random_string.unique-id.result])
#   description = "Allow Code Server traffic"
#   # vpc_id      = "${aws_vpc.main.id }"

#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-codeserver-sg-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_kms_key" "cgw-aws-kms-key" {
#   description         = join("", ["cgw-aws-kms-key-", random_string.unique-id.result, " for ", aws_iam_user.cgw-aws-iam-user.name])
#   is_enabled          = true
#   enable_key_rotation = false

#   tags = {
#     Name      = join("", ["cgw-aws-kms-key-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_lb" "cgw-aws-elb" {
#   name                       = join("", ["cgw-aws-elb-", random_string.unique-id.result])
#   internal                   = false
#   load_balancer_type         = "network"
#   subnets                    = [var.defaultAwsSubnetId]
#   enable_deletion_protection = false

#   tags = {
#     Name      = join("", ["cgw-aws-elb-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "local_file" "mysql-script" {
#   content = templatefile("${path.module}/db-insert-aws-template.tpl", {
#     cgw-aws-uuid                        = random_string.unique-id.result
#     cgw-aws-instance-public-ip          = aws_instance.cgw-aws-instance.public_ip
#     cgw-aws-instance-id                 = aws_instance.cgw-aws-instance.id
#     cgw-aws-vol                         = aws_ebs_volume.cgw-aws-vol.id
#     cgw-aws-s3-bucket                   = aws_s3_bucket.cgw-aws-s3-bucket.bucket_domain_name
#     cgw-aws-iam-user                    = aws_iam_user.cgw-aws-iam-user.name
#     cgw-aws-iam-user-password           = aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password
#     cgw-aws-iam-role                    = aws_iam_role.cgw-aws-iam-role.name
#     cgw-aws-iam-instance-profile        = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name
#     cgw-aws-iam-policy                  = aws_iam_policy.cgw-aws-iam-policy.name
#     cgw-aws-ssh-sg                      = aws_security_group.cgw-aws-ssh-sg.name
#     cgw-aws-kms-key                     = aws_kms_key.cgw-aws-kms-key.arn
#     cgw-aws-elb                         = aws_lb.cgw-aws-elb.id
#     cgw-aws-sns-topic                   = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
#     cgw-aws-iam-user-password-decrypted = file("${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt")
#   })
#   filename = "${path.module}/local_files/mysql-script-${random_string.unique-id.result}.sql"
#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run
#   ]
# }

# resource "null_resource" "mysql-run" {
#   provisioner "file" {
#     content = templatefile("${path.module}/db-insert-aws-template.tpl", {
#       cgw-aws-uuid                        = random_string.unique-id.result
#       cgw-aws-instance-public-ip          = aws_instance.cgw-aws-instance.public_ip
#       cgw-aws-instance-id                 = aws_instance.cgw-aws-instance.id
#       cgw-aws-vol                         = aws_ebs_volume.cgw-aws-vol.id
#       cgw-aws-s3-bucket                   = aws_s3_bucket.cgw-aws-s3-bucket.bucket_domain_name
#       cgw-aws-iam-user                    = aws_iam_user.cgw-aws-iam-user.name
#       cgw-aws-iam-user-password           = aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password
#       cgw-aws-iam-role                    = aws_iam_role.cgw-aws-iam-role.name
#       cgw-aws-iam-instance-profile        = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name
#       cgw-aws-iam-policy                  = aws_iam_policy.cgw-aws-iam-policy.name
#       cgw-aws-ssh-sg                      = aws_security_group.cgw-aws-ssh-sg.name
#       cgw-aws-kms-key                     = aws_kms_key.cgw-aws-kms-key.arn
#       cgw-aws-elb                         = aws_lb.cgw-aws-elb.id
#       cgw-aws-sns-topic                   = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
#       cgw-aws-iam-user-password-decrypted = file("${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt")
#     })
#     destination = "/tmp/mysql-script.sql"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "mysql -u ${local.mysqlDbRootUser} -p${local.mysqlDbRootPass} < /tmp/mysql-script.sql",
#       "rm -rf /tmp/mysql-script.sql"
#     ]
#   }

#   connection {
#     type        = "ssh"
#     user        = local.vmUser
#     private_key = file(var.dbAwsKeyPairFilePath)
#     host        = local.mysqlHostIP
#   }

#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run
#   ]
# }



# resource "aws_iam_role" "cgw-aws-iam-service-role-lambda" {
#   name               = join("", ["cgw-aws-iam-service-role-lambda-", random_string.unique-id.result])
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": "CGWStsRole"
#     }
#   ]
# }
# EOF

#   tags = {
#     Name      = join("", ["cgw-aws-iam-service-role-lambda-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }
# }

# resource "aws_iam_policy" "cgw-aws-iam-service-role-lambda-policy" {
#   name        = join("", ["cgw-aws-iam-service-role-lambda-policy-", random_string.unique-id.result])
#   description = join("", ["cgw-aws-iam-service-role-lambda-policy-", random_string.unique-id.result, " for ", aws_iam_user.cgw-aws-iam-user.name])
#   path        = "/"
#   policy      = data.aws_iam_policy_document.cgw-aws-lambda-sns-policy-doc.json
# }

# resource "aws_iam_role_policy_attachment" "cgw-aws-iam-service-role-lambda-policy-attach" {
#   role       = aws_iam_role.cgw-aws-iam-service-role-lambda.name
#   policy_arn = aws_iam_policy.cgw-aws-iam-service-role-lambda-policy.arn
# }

# resource "aws_lambda_function" "cgw-aws-lambda-sendmail" {
#   filename      = "${path.module}/cgw-aws-lambda-sendmail/cgw-aws-lambda-sendmail.zip"
#   function_name = join("", ["cgw-aws-lambda-sendmail-", random_string.unique-id.result])
#   role          = aws_iam_role.cgw-aws-iam-service-role-lambda.arn
#   handler       = "lambda_function.send_to_sns"

#   source_code_hash = filebase64sha256("${path.module}/cgw-aws-lambda-sendmail/cgw-aws-lambda-sendmail.zip")

#   runtime = "python2.7"

#   environment {
#     variables = {
#       SNS_TOPIC_ARN      = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
#       MSG_SUBJECT        = join("", ["Cloud Governance Workshop - Team Confidential - Team Name: ", random_string.unique-id.result])
#       MSG_SENSITIVE_TEXT = join("", ["Team Name : ", random_string.unique-id.result, "\n\nTeam Password : ", file("${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt"), "\n\nAWS Account Id : 666402644145\n\nAWS IAM User : ", aws_iam_user.cgw-aws-iam-user.name, "\n\nAWS Console Password : ", file("${path.module}/local_files/cgw-aws-iam-user-password-${random_string.unique-id.result}.decrypt"), "\n\nAWS Console URL : https://us-east-1.signin.aws.amazon.com/oauth?SignatureVersion=4&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJMOATPLHVSJ563XQ&X-Amz-Date=2020-09-21T15%3A13%3A03.581Z&X-Amz-Signature=18c6bee2d92342c54df907049ca72a112e39c6192f6d3c34f992b1b11313688f&X-Amz-SignedHeaders=host&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&code_challenge=Z6qUwxhEBwVuQceompsh69AirLI-AQIvHUfyDoAoy5Y&code_challenge_method=SHA-256&redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&response_type=code&state=hashArgs%23", "\n\nWeb Workshop URL - https://trendcyberdefence.ca"])
#     }
#   }

#   tags = {
#     Name      = join("", ["cgw-aws-lambda-sendmail-", random_string.unique-id.result])
#     Owner     = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project   = "cgw"
#     Team      = var.teamTag
#   }

#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run
#   ]
# }

# # # # TODO: Do we need the lambda to run and send out an email??
# resource "local_file" "cgw-aws-lambda-invoke-function-sendmail-script" {
#   content  = <<EOF
# aws lambda invoke --function-name cgw-aws-lambda-sendmail-${random_string.unique-id.result} --region us-east-1 ${path.module}/local_files/cgw-aws-lambda-invoke-function-sendmail-script-response-${random_string.unique-id.result}.json
# cat ${path.module}/local_files/cgw-aws-lambda-invoke-function-sendmail-script-response-${random_string.unique-id.result}.json
# EOF
#   filename = "${path.module}/local_files/cgw-aws-lambda-invoke-function-sendmail-${random_string.unique-id.result}.sh"
#   depends_on = [
#     aws_lambda_function.cgw-aws-lambda-sendmail
#   ]
# }

# resource "null_resource" "cgw-aws-lambda-invoke-function-sendmail-script-run" {
#   provisioner "local-exec" {
#     command     = "./${path.module}/local_files/cgw-aws-lambda-invoke-function-sendmail-${random_string.unique-id.result}.sh"
#     interpreter = ["/bin/bash"]
#   }
#   depends_on = [
#     local_file.cgw-aws-lambda-invoke-function-sendmail-script
#   ]
# }

# # # [ End: Phase 1 - Spin Up Resources ]



# # # [ Phase 2 - Conformity Run ]

# resource "local_file" "cgw-conformity-api-aws-script" {
#   content = templatefile("${path.module}/aws-conformity-api-cmd-template.tpl", {
#     cgw-aws-uuid               = random_string.unique-id.result
#     cgw-aws-cf-stack-arn       = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
#     cgw-aws-conformity-acct-id = local.conformityAwsAccountId
#   })
#   filename = "${path.module}/local_files/aws-conformity-api-cmd-${random_string.unique-id.result}.sh"
# }

# resource "null_resource" "cgw-conformity-api-aws-script-run" {
#   provisioner "local-exec" {
#     command     = "${path.module}/aws-conformity-api-cmd-${random_string.unique-id.result}.sh"
#     interpreter = ["/bin/bash"]
#   }
#   depends_on = [
#     local_file.cgw-conformity-api-aws-script
#   ]
# }

# resource "local_file" "cgw-aws-conformity-ses-email-destinations" {
#   content  = join(",", formatlist("{ \"Destination\": { \"ToAddresses\": [ \"%s\" ] } }", var.teamMembers))
#   filename = "${path.module}/local_files/cgw-aws-conformity-ses-email-destinations-${random_string.unique-id.result}.json"
#   depends_on = [
#     null_resource.cgw-aws-iam-user-password-decrypt-run
#   ]
# }

# resource "local_file" "cgw-aws-conformity-ses-template-json" {
#   content = templatefile("${path.module}/cgw-aws-conformity-ses-trigger.json-template.tpl", {
#     cgw-aws-uuid                              = random_string.unique-id.result
#     cgw-aws-conformity-url                    = random_string.unique-id.result
#     cgw-aws-conformity-rule-id                = random_string.unique-id.result
#     cgw-aws-conformity-rule-title             = random_string.unique-id.result
#     cgw-aws-resource-link                     = random_string.unique-id.result
#     cgw-aws-conformity-status                 = random_string.unique-id.result
#     cgw-aws-conformity-message                = random_string.unique-id.result
#     cgw-aws-conformity-risk-level             = random_string.unique-id.result
#     cgw-aws-conformity-categories             = random_string.unique-id.result
#     cgw-aws-conformity-ses-email-destinations = file("${path.module}/local_files/cgw-aws-conformity-ses-email-destinations-${random_string.unique-id.result}.json")
#   })
#   filename = "${path.module}/local_files/cgw-aws-conformity-ses-email-${random_string.unique-id.result}.json"
#   depends_on = [
#     local_file.cgw-aws-iam-user-ses-email-destinations
#   ]
# }

# resource "local_file" "cgw-aws-conformity-ses-send-templated-email-script" {
#   content  = <<EOF
# cd ${path.module}/local_files
# aws ses send-bulk-templated-email --cli-input-json file://cgw-aws-conformity-ses-email-${random_string.unique-id.result}.json
# EOF
#   filename = "${path.module}/local_files/cgw-aws-conformity-ses-send-templated-email-script-${random_string.unique-id.result}.sh"
# }

# resource "null_resource" "cgw-aws-conformity-ses-send-templated-email-script-run" {
#   provisioner "local-exec" {
#     command     = "./${path.module}/local_files/cgw-aws-conformity-ses-send-templated-email-script-${random_string.unique-id.result}.sh"
#     interpreter = ["/bin/bash"]
#   }
#   depends_on = [
#     local_file.cgw-aws-iam-user-ses-template-json,
#     local_file.cgw-aws-conformity-ses-send-templated-email-script
#   ]
# }

# resource "null_resource" "conformity-invite-user" {
#   count = length(var.teamMembers)
#   provisioner "local-exec" {
#     command     = "/usr/local/bin/python3 python-scripts/conformity-invite-user.py var.teamMembers[count.index] local.conformityAwsAccountId"
#     interpreter = ["/bin/bash"]
#   }  
# }

# # # [ End: Phase 2 - Conformity Run ]