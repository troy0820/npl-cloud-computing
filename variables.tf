variable "region" {
  description = "Region for AWS assets"
  type        = "string"
}

variable "profile" {
  description = "AWS profile"
  type        = "string"
}

variable "count" {
  description = "Instance count"
  type        = "string"
}

variable "ami" {
  description = "Amazon machine image id"
  type        = "string"
}

variable "public_key" {
  description = "Public key for ssh instance"
  type        = "string"
}

variable "name" {
  description = "Tags for each instance"
  type        = "string"
}

variable "cidr_block" {
  description = "Cidr block for instances"
  type        = "string"
}

variable "instance_type" {
  description = "AWS instance_type type e.g t2.micro"
  type        = "string"
}
