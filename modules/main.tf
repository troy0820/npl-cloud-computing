terraform {
  required_version = ">0.11.0"
}

provider "aws" {
  version = "~>1.8"
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "null_resource" "is_ready" {
  triggers {
    is_ready = "${var.is_ready}"
  }
}

data "template-file" init {
  template = "${file("${path.module}/scripts/user-data.tpl")}"
}

resource "aws_vpc" "instance-vpc" {
  depends_on = ["null_resource.is_ready"]
  cidr_block = "{var.cidr_block}"

  tags {
    name = "${var.name}"
  }
}

resource "aws_subnet" "instance-subnet" {
  depends_on = ["aws_vpc.instance-vpc"]
  vpc_id     = "${aws_vpc.instance-vpc.id}"
  cidr_block = "${var.cidr_block}"

  tags {
    name = "${var.name}"
  }
}

##########################################
# TODO:// security groups 
#########################################

resource "aws_instance" "npl-instance" {
  depends_on = ["aws_subnet.instance-subnet"]

  count                       = "${var.count}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "{aws_subnet.instance-subnet.id}"
  associate_public_ip_address = true

  tags {
    name = "${var.name}"
  }
}

resource "null_resource" "is_complete" {
  depends_on = ["null_resource.is_ready", "aws_vpc.instance-vpc", "aws_subnet.instance-subnet", "aws_instance.npl-instance"]
}
