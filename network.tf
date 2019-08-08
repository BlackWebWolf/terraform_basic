data "aws_availability_zones" "available" {}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "v1.66.0"
  name = "${var.app_name}-vpc"
  cidr = "${var.cidr_block}"

  azs             = ["${data.aws_availability_zones.available.names}"]
  #can be done by cidrsubnet, but for sake of simpility not done that
  private_subnets = "${var.cidr_block_public}"
  public_subnets  = "${var.cidr_block_private}"
  database_subnets = "${var.cidr_block_database}"

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "${var.app_name}"
  }
}
