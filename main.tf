# Specify the provider and access details
terraform {
  backend "s3" {
    key    = "app.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "priv"
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config {
    bucket = "${var.bucket}"
    dynamodb_table = "${var.dynamodb_table}"
    region = "eu-central-1"
    key = "terraform.tfstate"
  }
}