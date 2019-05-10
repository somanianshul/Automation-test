# VPC Config Section
# ------------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block  = "${var.vpc_base_cidr}"

  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags {
    Name  = "${var.tag_env}_VPC"
    Env   = "${var.tag_env}"
  }
}
