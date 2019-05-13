# -- Private Subnets
# ------------------------------------------------------------------------------------------------
resource "aws_subnet" "private" {
  count             = "${var.num_prv_subnets}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(split(",", var.cfg_prv_subnets[count.index]), 0)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags {
    Name  = "${upper(var.tag_env)}_Private_Subnet_${count.index + 1}_${upper(element(split(",", var.cfg_prv_subnets[count.index]), 1))}_${upper(replace(element(data.aws_availability_zones.available.names, count.index), data.aws_region.current.name, ""))}"
    Env   = "${var.tag_env}"
  }
}

# -- Public Subnets
# ------------------------------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count             = "${var.num_pub_subnets}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(split(",", var.cfg_pub_subnets[count.index]), 0)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags {
    Name  = "${upper(var.tag_env)}_Public_Subnet_${count.index + 1}_${upper(element(split(",", var.cfg_pub_subnets[count.index]), 1))}_${upper(replace(element(data.aws_availability_zones.available.names, count.index), data.aws_region.current.name, ""))}"
    Env   = "${var.tag_env}"
  }
}
