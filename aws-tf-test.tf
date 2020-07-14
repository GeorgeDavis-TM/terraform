locals {
  scriptName = join(
    "",
    [
      "dsa_deploy_",
      data.aws_ami.ubuntu-1804.platform == "windows" ? "windows" : "linux",
      data.aws_ami.ubuntu-1804.platform == "windows" ? ".ps1" : ".sh"
    ]
  )
  sourcePath      = join("", ["shell-scripts/", local.scriptName])
  destinationPath = join("", ["/tmp/", local.scriptName])
}

resource "aws_instance" "georged-tf-test" {
  ami                    = data.aws_ami.ubuntu-1804.image_id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.georged-ssh-sg.id]
  key_name               = var.keyName

  root_block_device {
    volume_type = var.volumeType
    volume_size = var.volumeSize
    encrypted   = true
  }

  tags = {
    Name  = "georged-tf-test"
    Owner = var.tagOwner
  }

  # Copy in the bash script we want to execute.
  # The source is the location of the bash script
  # on the local linux box you are executing terraform
  # from.  The destination is on the new AWS instance.
  provisioner "file" {
    source      = local.sourcePath
    destination = local.destinationPath
  }
  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.destinationPath}",
      "sudo ${local.destinationPath}",
    ]
  }

  # Login to the ec2-user with the aws key.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
}

resource "aws_ebs_volume" "georged-tf-test-vol" {
  size              = var.volumeSize
  availability_zone = var.availabilityZone
  encrypted         = true

  tags = {
    Name  = aws_instance.georged-tf-test.id
    Owner = var.tagOwner
  }
}

resource "aws_volume_attachment" "georged-tf-test-vol-att" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.georged-tf-test-vol.id
  instance_id = aws_instance.georged-tf-test.id
}

resource "aws_eip" "georged-tf-test-public-ip" {
  vpc      = true
  instance = aws_instance.georged-tf-test.id

  tags = {
    Name  = "georged-tf-test-public-ip"
    Owner = var.tagOwner
  }
}

output "georged-tf-test-ip" {
  value = aws_eip.georged-tf-test-public-ip.public_ip
}