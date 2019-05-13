# -- Elastic IPs
# ------------------------------------------------------------------------------------------------
resource "aws_eip" "elastic_ips" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc   = true
}
