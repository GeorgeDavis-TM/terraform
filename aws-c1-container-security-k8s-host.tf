resource "aws_instance" "georged-k8s-host" {
  ami                    = data.aws_ami.ubuntu-1804.image_id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.georged-ssh-sg.id, aws_security_group.georged-k8s-sg.id]
  key_name               = var.keyName

  tags = {
    Name    = "georged-k8s-host"
    Owner   = var.tagOwner
    Usecase = "C1-ContainerSecurity"
    Project = "C1-Demo"
  }
}

resource "aws_eip" "georged-k8s-host-public-ip" {
  vpc      = true
  instance = aws_instance.georged-k8s-host.id
  tags = {
    Name  = "georged-k8s-host-public-ip"
    Owner = var.tagOwner
  }
}

output "georged-k8s-host-ip" {
  value = aws_eip.georged-k8s-host-public-ip.public_ip
}