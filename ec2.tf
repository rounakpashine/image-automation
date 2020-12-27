provider "aws" {
  region     = "us-east-1"
}

data "aws_ami" "ec2-ami" {
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "tag:Name"
    values = ["Packer-Ansible"]
  }
  most_recent = true
  owners = ["self"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ec2-ami.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "automation"
  }
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-04a19ec0df5243ed0"

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}  
}
