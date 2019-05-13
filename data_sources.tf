# -- aws_availability_zones 
# -- Allows access to the list of AWS Availability Zones which can be accessed by an AWS account 
#    within the region configured in the provider
# ------------------------------------------------------------------------------------------------ 
data "aws_availability_zones" "available" { }

# -- aws_region 
# -- As well as validating a given region name this resource can be used to discover the name of 
#    the region configured within the provider
# ------------------------------------------------------------------------------------------------ 
data "aws_region" "current"               { }
