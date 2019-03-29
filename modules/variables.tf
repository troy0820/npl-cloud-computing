variable "region" {
  description = "AWS Region"
  type        = "string"
}

variable "profile" {
  description = "AWS profile"
  type        = "string"
}

variable "is_ready" {
  description = "Trigger for null resource"
  type        = "string"
}

variable "key_name" {
  description = "ssh key_name pair for instance connection"
  type        = "string"
}

variable "name" {
  description = "Name tag in tags"
  type        = "string"
}

variable "ami" {
  description = "Name of ami to use"
  type        = "string"
}

variable "count" {
  description = "The count of instances for docker-ee-beta"
  type        = "string"
}

variable "instance_type" {
  description = "Instance size of node"
  type        = "string"
  default     = "t2.medium"
}

variable "cidr_block" {
  description = "CIDR block for subnet"
  type        = "string"
}

variable "public_key" {
  description = "Public key for key/pair for instance"
  type        = "string"
}
