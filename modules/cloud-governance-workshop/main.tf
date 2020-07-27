resource "random_string" "unique-id" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

resource "aws_instance" "cgw-instance" {
  availability_zone      = var.defaultAwsAvailabilityZone
  ami                    = data.aws_ami.ubuntu-1804.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cgw-ssh-sg.id]
  key_name               = var.defaultAwsKeyName
  # iam_instance_profile   = aws_iam_instance_profile.cgw-iam-instance-profile.name

  root_block_device {
    volume_type = var.defaultAwsVolumeType
    volume_size = var.defaultAwsVolumeSize
  }

  tags = {
    Name    = join("", ["cgw-ec2-instance-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
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

resource "aws_ebs_volume" "cgw-vol" {
  size              = var.defaultAwsVolumeSize
  availability_zone = var.defaultAwsAvailabilityZone

  tags = {
    Name       = join("", ["cgw-ebs-vol-", random_string.unique-id.result])
    InstanceId = aws_instance.cgw-instance.id
    Owner      = var.tagOwner
    Project    = join("", ["cgw-", random_string.unique-id.result])
    Team       = var.teamTag
  }
}

resource "aws_volume_attachment" "cgw-vol-attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.cgw-vol.id
  instance_id = aws_instance.cgw-instance.id
}

# resource "aws_eip" "cgw-instance-public-ip" {
#   vpc      = true
#   instance = aws_instance.cgw-instance.id

#   tags = {
#     Name    = join("", ["cgw-instance-public-ip-", random_string.unique-id.result])
#     Owner   = var.tagOwner
#     Project = join("", ["cgw-", random_string.unique-id.result])
#     Team    = var.teamTag
#   }
# }

resource "aws_s3_bucket" "cgw-s3-bucket" {
  bucket = join("", ["cgw-s3-bucket-", random_string.unique-id.result])
  acl    = "public-read"
  region = var.defaultAwsRegion

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }

  tags = {
    Name    = join("", ["cgw-s3-bucket-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}

resource "aws_iam_user" "cgw-iam-user" {
  name = join("", ["cgw-iam-user-", random_string.unique-id.result])
  path = "/"

  tags = {
    Name    = join("", ["cgw-iam-user-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}

resource "aws_iam_user_login_profile" "cgw-iam-user-login-profile" {
  user                    = aws_iam_user.cgw-iam-user.name
  password_reset_required = false
  pgp_key                 = var.defaultPgpPubKeyBase64Encoded
}

resource "aws_iam_role" "cgw-iam-role" {
  name               = join("", ["cgw-iam-role-", random_string.unique-id.result])
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
    Name    = join("", ["cgw-iam-role-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}

resource "aws_iam_instance_profile" "cgw-iam-instance-profile" {
  name = join("", ["cgw-iam-instance-profile-", random_string.unique-id.result])
  role = aws_iam_role.cgw-iam-role.name
}

resource "aws_iam_policy" "cgw-iam-policy" {
  name        = join("", ["cgw-iam-policy-", random_string.unique-id.result])
  description = join("", ["cgw-iam-policy-", random_string.unique-id.result, " for ", aws_iam_user.cgw-iam-user.name])
  path        = "/"
  policy      = data.aws_iam_policy_document.cgw-iam-policy-doc.json
}

resource "aws_iam_role_policy_attachment" "cgw-iam-role-policy-attach" {
  role       = aws_iam_role.cgw-iam-role.name
  policy_arn = aws_iam_policy.cgw-iam-policy.arn
}

resource "aws_iam_user_policy_attachment" "cgw-iam-user-policy-attach" {
  user       = aws_iam_user.cgw-iam-user.name
  policy_arn = aws_iam_policy.cgw-iam-policy.arn
}

resource "aws_security_group" "cgw-ssh-sg" {
  name        = join("", ["cgw-ssh-sg-", random_string.unique-id.result])
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
    Name    = join("", ["cgw-ssh-sg-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}

resource "aws_kms_key" "cgw-kms-key" {
  description         = join("", ["cgw-kms-key-", random_string.unique-id.result, " for ", aws_iam_user.cgw-iam-user.name])
  is_enabled          = true
  enable_key_rotation = false

  tags = {
    Name    = join("", ["cgw-kms-key-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}

resource "aws_lb" "cgw-elb" {
  name                       = join("", ["cgw-elb-", random_string.unique-id.result])
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = [var.defaultAwsSubnetId]
  enable_deletion_protection = false

  tags = {
    Name    = join("", ["cgw-elb-", random_string.unique-id.result])
    Owner   = var.tagOwner
    Project = join("", ["cgw-", random_string.unique-id.result])
    Team    = var.teamTag
  }
}