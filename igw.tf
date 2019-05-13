# Internet Gateway
# ------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id    = "${aws_vpc.vpc.id}"

  tags { 
    Name  = "${var.tag_env}_IGW"
    Env   = "${var.tag_env}"
  }
}
