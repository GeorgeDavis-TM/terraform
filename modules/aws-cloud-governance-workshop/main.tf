resource "random_string" "unique-id" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

resource "aws_instance" "cgw-aws-instance" {
  availability_zone      = var.defaultAwsAvailabilityZone
  ami                    = data.aws_ami.ubuntu-1804.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cgw-aws-ssh-sg.id]
  key_name               = var.defaultAwsKeyName
  # iam_instance_profile   = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name

  root_block_device {
    volume_type = var.defaultAwsVolumeType
    volume_size = var.defaultAwsVolumeSize
  }

  tags = {
    Name      = join("", ["cgw-aws-ec2-instance-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
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

  # Login to the ec2-user with the aws key.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file(var.defaultAwsKeyFilePath)
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "cgw-aws-vol" {
  size              = var.defaultAwsVolumeSize
  availability_zone = var.defaultAwsAvailabilityZone

  tags = {
    Name       = join("", ["cgw-aws-ebs-vol-", random_string.unique-id.result])
    InstanceId = aws_instance.cgw-aws-instance.id
    Owner      = var.tagOwner
    Team-UUID  = join("", ["cgw-aws-", random_string.unique-id.result])
    Project    = "cgw"
    Team       = var.teamTag
  }
}

resource "aws_volume_attachment" "cgw-aws-vol-attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.cgw-aws-vol.id
  instance_id = aws_instance.cgw-aws-instance.id
}

# resource "aws_eip" "cgw-aws-instance-public-ip" {
#   vpc      = true
#   instance = aws_instance.cgw-aws-instance.id

#   tags = {
#     Name    = join("", ["cgw-aws-instance-public-ip-", random_string.unique-id.result])
#     Owner   = var.tagOwner
#     Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
#     Project = "cgw"
#     Team    = var.teamTag
#   }
# }

resource "aws_s3_bucket" "cgw-aws-s3-bucket" {
  bucket = join("", ["cgw-aws-s3-bucket-", random_string.unique-id.result])
  acl    = "public-read"
  region = var.defaultAwsRegion

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }

  tags = {
    Name      = join("", ["cgw-aws-s3-bucket-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_iam_user" "cgw-aws-iam-user" {
  name = join("", ["cgw-aws-iam-user-", random_string.unique-id.result])
  path = "/"

  tags = {
    Name      = join("", ["cgw-aws-iam-user-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Team      = var.teamTag
  }
}

resource "aws_iam_user_login_profile" "cgw-aws-iam-user-login-profile" {
  user                    = aws_iam_user.cgw-aws-iam-user.name
  password_reset_required = false
  pgp_key                 = var.defaultPgpPubKeyBase64Encoded
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

resource "aws_security_group" "cgw-aws-ssh-sg" {
  name        = join("", ["cgw-aws-ssh-sg-", random_string.unique-id.result])
  description = "Allow SSH traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = join("", ["cgw-aws-ssh-sg-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_security_group" "cgw-aws-https-sg" {
  name        = join("", ["cgw-aws-https-sg-", random_string.unique-id.result])
  description = "Allow HTTPS traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = join("", ["cgw-aws-https-sg-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_kms_key" "cgw-aws-kms-key" {
  description         = join("", ["cgw-aws-kms-key-", random_string.unique-id.result, " for ", aws_iam_user.cgw-aws-iam-user.name])
  is_enabled          = true
  enable_key_rotation = false

  tags = {
    Name      = join("", ["cgw-aws-kms-key-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "aws_lb" "cgw-aws-elb" {
  name                       = join("", ["cgw-aws-elb-", random_string.unique-id.result])
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [var.defaultAwsSubnetId]
  enable_deletion_protection = false

  tags = {
    Name      = join("", ["cgw-aws-elb-", random_string.unique-id.result])
    Owner     = var.tagOwner
    Team-UUID = join("", ["cgw-aws-", random_string.unique-id.result])
    Project   = "cgw"
    Team      = var.teamTag
  }
}

resource "local_file" "mysql-script" {
  content = templatefile("${path.module}/db-insert-aws-template.tpl", {
    cgw-aws-uuid                 = random_string.unique-id.result
    cgw-aws-instance-public-ip   = aws_instance.cgw-aws-instance.public_ip
    cgw-aws-instance-id          = aws_instance.cgw-aws-instance.id
    cgw-aws-vol                  = aws_ebs_volume.cgw-aws-vol.id
    cgw-aws-s3-bucket            = aws_s3_bucket.cgw-aws-s3-bucket.bucket_domain_name
    cgw-aws-iam-user             = aws_iam_user.cgw-aws-iam-user.name
    cgw-aws-iam-user-password    = aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password
    cgw-aws-iam-role             = aws_iam_role.cgw-aws-iam-role.name
    cgw-aws-iam-instance-profile = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name
    cgw-aws-iam-policy           = aws_iam_policy.cgw-aws-iam-policy.name
    cgw-aws-ssh-sg               = aws_security_group.cgw-aws-ssh-sg.name
    cgw-aws-kms-key              = aws_kms_key.cgw-aws-kms-key.arn
    cgw-aws-elb                  = aws_lb.cgw-aws-elb.id
  })
  filename = "${path.module}/mysql-script-${random_string.unique-id.result}.sql"
}

resource "null_resource" "mysql-run" {
  connection {
    type     = "ssh"
    user     = local.ubuntuUser
    password = local.ubuntuPass
    host     = local.mysqlHostIP
  }

  provisioner "file" {
    # source      = "./${path.module}/mysql-script-${random_string.unique-id.result}.sql"
    content = templatefile("${path.module}/db-insert-aws-template.tpl", {
      cgw-aws-uuid                 = random_string.unique-id.result
      cgw-aws-instance-public-ip   = aws_instance.cgw-aws-instance.public_ip
      cgw-aws-instance-id          = aws_instance.cgw-aws-instance.id
      cgw-aws-vol                  = aws_ebs_volume.cgw-aws-vol.id
      cgw-aws-s3-bucket            = aws_s3_bucket.cgw-aws-s3-bucket.bucket_domain_name
      cgw-aws-iam-user             = aws_iam_user.cgw-aws-iam-user.name
      cgw-aws-iam-user-password    = aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password
      cgw-aws-iam-role             = aws_iam_role.cgw-aws-iam-role.name
      cgw-aws-iam-instance-profile = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name
      cgw-aws-iam-policy           = aws_iam_policy.cgw-aws-iam-policy.name
      cgw-aws-ssh-sg               = aws_security_group.cgw-aws-ssh-sg.name
      cgw-aws-kms-key              = aws_kms_key.cgw-aws-kms-key.arn
      cgw-aws-elb                  = aws_lb.cgw-aws-elb.id
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