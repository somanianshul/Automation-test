# -- Provider
# ------------------------------------------------------------------------------------------------
variable "region"           { default = "dummy" }
variable "assume_role"      { default = "dummy" }
variable "allowed_accounts" { default = "dummy" }

# -- VPC 
# ------------------------------------------------------------------------------------------------
variable "vpc_base_cidr"    { }

# -- Tags
# ------------------------------------------------------------------------------------------------
variable "tag_env"          { }

# -- IAM
# ------------------------------------------------------------------------------------------------
variable "iam_create_flowlogs_role" { default = true }
variable "iam_flowlogs_role_name"   { default = "VPCFlowLogsRole" }