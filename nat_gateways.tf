# -- NAT GWs
# ------------------------------------------------------------------------------------------------
resource "aws_nat_gateway" "natgw" {
  count         = "${length(data.aws_availability_zones.available.names)}"
  allocation_id = "${element(aws_eip.elastic_ips.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "${var.tag_env}_NAT_Gateway_${count.index + 1}${upper(replace(element(data.aws_availability_zones.available.names, count.index), data.aws_region.current.name, ""))}"
  }
}
