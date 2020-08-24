resource "aws_instance" "cgw-common-db-instance" {
  availability_zone      = var.defaultAwsAvailabilityZone
  ami                    = data.aws_ami.amzn-linux-2.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.georged-ssh-sg.id, aws_security_group.cgw-common-db-sg.id]
  key_name               = var.defaultAwsKeyPairName

  root_block_device {
    volume_type = var.defaultAwsVolumeType
    volume_size = var.defaultAwsVolumeSize
  }

  tags = {
    Name    = "cgw-common-db-ec2-instance"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }

  provisioner "file" {
    source      = local.dsaSourcePath
    destination = local.dsaDestinationPath

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.dsaDestinationPath}",
      "sudo ${local.dsaDestinationPath}"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.defaultAwsKeyPairFilePath)
      host        = self.public_ip
    }
  }
}

resource "aws_eip" "cgw-common-db-instance-public-ip" {
  vpc      = true
  instance = aws_instance.cgw-common-db-instance.id

  tags = {
    Name    = "cgw-common-db-instance-public-ip"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }
}

resource "aws_security_group" "cgw-common-db-sg" {
  name        = "cgw-common-db-sg"
  description = "Allow CGW DB & Services traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.localIpCidr]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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
    Name    = "cgw-common-db-sg"
    Owner   = var.tagOwner
    Project = "cgw-common"
  }
}

output "cgw-common-db-instance-id" {
  value       = aws_instance.cgw-common-db-instance.id
  description = "The Instance ID of the CGW DB Instance"
}

output "cgw-common-db-instance-ip" {
  value       = aws_instance.cgw-common-db-instance.public_ip
  description = "The Public IP of the CGW DB Instance"
}