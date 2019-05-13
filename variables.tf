# -- Provider
# ------------------------------------------------------------------------------------------------
variable "region"                     { default = "dummy" }
variable "assume_role"                { default = "dummy" }
variable "allowed_accounts"           { default = "dummy" }
  
# -- VPC  
# ------------------------------------------------------------------------------------------------
variable "vpc_base_cidr"              { }
  
# -- Tags 
# ------------------------------------------------------------------------------------------------
variable "tag_env"                    { }
variable "tag_cust"                   { }
  
# -- IAM  
# ------------------------------------------------------------------------------------------------
variable "min_password_length"        { default = 8 }
variable "max_password_age"           { default = 30 }
variable "password_reuse_prevention"  { default = 10 }
variable "iam_groups_list"            { type = "list" }
variable "iam_create_flowlogs_role"   { default = true }
variable "iam_flowlogs_role_name"     { default = "VPCFlowLogsRole" }
  
# -- Subnets  
# ------------------------------------------------------------------------------------------------
variable "num_prv_subnets"            { default = 3 }
variable "cfg_prv_subnets"            { # Format: <CIDR_blk>,<name>
                                        type = "list"
                                      }
variable "num_pub_subnets"            { default = 3 }
variable "cfg_pub_subnets"            { # Format: <CIDR_blk>,<name>
                                        type = "list"
                                      }

# -- S3
# ------------------------------------------------------------------------------------------------
variable "s3_bucket_name_cloudtrail"  { default = "" }
