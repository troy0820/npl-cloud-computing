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
