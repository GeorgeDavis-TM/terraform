resource "aws_security_group" "georged-nodejs-sg" {
  name        = "georged-nodejs-sg"
  description = "Allow NodeJs traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["142.116.27.242/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["142.116.27.242/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "georged-nodejs-sg"
    Owner = var.tagOwner
  }
}

resource "aws_security_group" "georged-k8s-sg" {
  name        = "georged-k8s-sg"
  description = "Allow k8s traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.localIpCidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "georged-k8s-sg"
    Owner = var.tagOwner
  }
}

resource "aws_security_group" "georged-ssh-sg" {
  name        = "georged-ssh-sg"
  description = "Allow SSH traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.localIpCidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "georged-ssh-sg"
    Owner = var.tagOwner
  }
}