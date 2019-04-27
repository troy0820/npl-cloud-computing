resource "null_resource" "is_ready" {
  triggers {
    is_ready = "${var.is_ready}"
  }
}

data "template_file" init {
  template = "${file("${path.module}/scripts/user-data.tpl")}"
}

resource "aws_key_pair" "ec2-key-pair" {
  key_name   = "${var.key_name}"
  public_key = "${file("${var.public_key}")}"
}

resource "aws_vpc" "instance-vpc" {
  depends_on = ["null_resource.is_ready"]
  cidr_block = "${var.cidr_block}"

  tags {
    name = "${var.name}"
  }
}

resource "aws_internet_gateway" "gw" {
  depends_on = ["aws_vpc.instance-vpc"]
  vpc_id     = "${aws_vpc.instance-vpc.id}"

  tags {
    name = "${var.name}"
  }
}

resource "aws_route" "r" {
  route_table_id         = "${aws_vpc.instance-vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_subnet" "instance-subnet" {
  depends_on = ["aws_vpc.instance-vpc"]
  vpc_id     = "${aws_vpc.instance-vpc.id}"
  cidr_block = "${var.cidr_block}"

  tags {
    name = "${var.name}"
  }
}

resource "aws_security_group" "allow_all" {
  depends_on  = ["aws_vpc.instance-vpc"]
  name        = "allow_all"
  description = "Allow All inbound traffic"
  vpc_id      = "${aws_vpc.instance-vpc.id}"

  ingress {
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
}

resource "aws_instance" "npl-instance" {
  depends_on = ["aws_subnet.instance-subnet"]

  count                       = "${var.count}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.ec2-key-pair.key_name}"
  subnet_id                   = "${aws_subnet.instance-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true

  tags {
    name = "${var.name}"
  }
}

resource "null_resource" "is_complete" {
  depends_on = ["null_resource.is_ready", "aws_key_pair.ec2-key-pair", "aws_vpc.instance-vpc", "aws_subnet.instance-subnet", "aws_instance.npl-instance"]
}
