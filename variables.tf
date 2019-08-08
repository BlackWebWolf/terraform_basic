variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-central-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t3.small"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}
variable "image_url" {
  default = "nginx"
}

variable "app_name" {}
variable "app_container_name" {}

variable "cidr_block" {}
variable "cidr_block_public" {
  type = "list"
}
variable "cidr_block_private" {
  type = "list"
}
variable "cidr_block_database" {
  type = "list"
}
variable "bucket" {}
variable "dynamodb_table" {}