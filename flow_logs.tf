# -- Flow Log  
# ------------------------------------------------------------------------------------------------
resource "aws_flow_log" "flowlogs" {
  iam_role_arn    = "${aws_iam_role.flowlogs.arn}"
  log_destination = "${aws_cloudwatch_log_group.flowlogs.arn}"
  traffic_type    = "ALL"
  vpc_id          = "${aws_vpc.vpc.id}"
}

# -- Cloudwatch log Group 
# ------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "flowlogs" {
  name              = "flowlogs"
  retention_in_days = 7
}


# --- Flow Logs Creation Policy
# ------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "flowlogs_assume_role_policy" {
  count       = "${var.iam_create_flowlogs_role ? 1 : 0}"

  statement {
    actions   = [ "sts:AssumeRole" ]
    principals {
      type        = "Service"
      identifiers = [ "vpc-flow-logs.amazonaws.com" ]
    }
  }
}
resource "aws_iam_role" "flowlogs" {
  count       = "${var.iam_create_flowlogs_role ? 1 : 0}"

  name                = "${var.tag_env}${var.iam_flowlogs_role_name}"
  assume_role_policy  = "${data.aws_iam_policy_document.flowlogs_assume_role_policy.json}"
}

# --- SwitchRole-Admin Role Policy
# ------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "flowlogs" {
  count       = "${var.iam_create_flowlogs_role ? 1 : 0}"

  statement {
    resources = [ "*" ]
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]
  }
}
resource "aws_iam_role_policy" "flowlogs" {
  count     = "${var.iam_create_flowlogs_role ? 1 : 0}"

  name      = "FlowLogsCreatePolicy"
  role      = "${aws_iam_role.flowlogs.id}"
  policy    = "${data.aws_iam_policy_document.flowlogs.json}"
}
