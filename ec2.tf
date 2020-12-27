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

  tags = {
    Name = "automation"
  }
}
