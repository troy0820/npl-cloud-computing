terraform {
  required_version = ">0.11.0"
}

provider "aws" {
  version = "~>1.8"
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "norfolk-library" {
  source = "./modules/"

  is_ready = "true"

  name          = "${var.name}"
  cidr_block    = "${var.cidr_block}"
  public_key    = "${var.public_key}"
  count         = "${var.count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
}
