# ec2.tf
# Create an instance t2.micro Amazon Linux2 AMI

provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "C:\\Users\\luizc\\.aws\\credentials"
  profile = "default"
}

resource "aws_security_group" "sg_ssh" {
  name = "sg_ssh"
  description = "SSH Security Group"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }    
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-00dc79254d0461090 (64-bit x86) / ami-0d08fa65f81355d86 (64-bit Arm)
  ami = "ami-00dc79254d0461090"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.sg_ssh.name}"]
  tags = { name = "Test-t2.micro"}
}
