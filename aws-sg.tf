resource "aws_security_group" "georged-nodejs-sg" {
  name        = "georged-nodejs-sg"
  description = "Allow NodeJs traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.localIpCidr
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
    cidr_blocks = var.localIpCidr
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
    cidr_blocks = var.localIpCidr
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

resource "aws_security_group" "georged-https-sg" {
  name        = "georged-https-sg"
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
    Name  = "georged-https-sg"
    Owner = var.tagOwner
  }
}

resource "aws_security_group" "georged-http-sg" {
  name        = "georged-http-sg"
  description = "Allow HTTP traffic"
  # vpc_id      = "${aws_vpc.main.id }"

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name  = "georged-http-sg"
    Owner = var.tagOwner
  }
}