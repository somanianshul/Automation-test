# -- Route Table Definition
# ------------------------------------------------------------------------------------------------
resource "aws_route_table" "private" {
  count   = "${var.num_prv_subnets}"
  vpc_id  = "${aws_vpc.vpc.id}"

  tags {
    Name  = "${var.tag_env}_VPC:Private_RouteTable_${count.index + 1}_${upper(element(split(",", var.cfg_prv_subnets[count.index]), 1))}_${upper(replace(element(data.aws_availability_zones.available.names, count.index), data.aws_region.current.name, ""))}"
    Env   = "${var.tag_env}"
  }
}

# -- Route Table Association
# ------------------------------------------------------------------------------------------------
resource "aws_route_table_association" "private" {
  count           = "${var.num_prv_subnets}"
  subnet_id       = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"
}

# -- Routes
# ------------------------------------------------------------------------------------------------
resource "aws_route" "private_route_natgw" {
  count = "${var.num_prv_subnets}"

  route_table_id          = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
}
