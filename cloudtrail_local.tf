# -- "Local" CloudTrail and Bucket
# ------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {
}

data "aws_iam_policy_document" "cloudtrail_local_policy" {
  statement {
    actions   = [ "s3:GetBucketAcl" ]
    resources = [ "${aws_s3_bucket.cloudtrail_local.arn}" ]
    principals {
      type        = "Service"
      identifiers = [ "cloudtrail.amazonaws.com" ]
    }
  }

  statement {
    actions   = [ "s3:PutObject" ]
    resources = [ "${aws_s3_bucket.cloudtrail_local.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*" ]
    principals {
      type        = "Service"
      identifiers = [ "cloudtrail.amazonaws.com" ]
    }
    condition {
      test      = "StringEquals"
      variable  = "s3:x-amz-acl"
      values    = [ "bucket-owner-full-control" ]
    }
  }
}
resource "aws_s3_bucket_policy" "cloudtrail_local" {
  bucket  = "${aws_s3_bucket.cloudtrail_local.id}"
  policy  = "${data.aws_iam_policy_document.cloudtrail_local_policy.json}"
}

resource "aws_s3_bucket" "cloudtrail_local" {
  bucket        = "${var.s3_bucket_name_cloudtrail != "" ? lower(var.s3_bucket_name_cloudtrail) : lower("${var.tag_cust}-${var.tag_env}-cloudtrail-${data.aws_region.current.name}")}"
  force_destroy = true

  tags {
    Cust  = "${var.tag_cust}"
    Env   = "${var.tag_env}"
  }
}


# -- CloudTrail local to the account
# ------------------------------------------------------------------------------------------------
resource "aws_cloudtrail" "trail_local" {
  name            = "trail_local"
  s3_bucket_name  = "${aws_s3_bucket.cloudtrail_local.id}"

  enable_log_file_validation    = true
  enable_logging                = true
  include_global_service_events = true
  is_multi_region_trail         = true

  tags {
    Cust  = "${var.tag_cust}"
    Env   = "${var.tag_env}"
  }

  depends_on = [ "aws_s3_bucket_policy.cloudtrail_local" ]
}
