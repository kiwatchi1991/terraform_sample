provider "aws" {
    # access_key = "${var.access_key}"
    # secret_key = "${var.secret_key}"
    region = "ap-northeast-1"
}

resource "aws_instance" "wordpress_sample"{
    ami = "ami-0f2dd5fc989207c82"
    instance_type = "t2.micro"
    key_name      = "${aws_key_pair.auth.id}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]

    tags = {
        Name = "wordpress"
    }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_security_group" "default" {
  name        = "terraform_security_group2"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}