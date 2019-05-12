# -- aws_availability_zones 
# -- Allows access to the list of AWS Availability Zones which can be accessed by an AWS account 
#    within the region configured in the provider
# ------------------------------------------------------------------------------------------------ 
data "aws_availability_zones" "available" { }


data "aws_region" "current" {}

