# -- IAM Groups 
# ------------------------------------------------------------------------------------------------ 
resource "aws_iam_group" "iam_groups" {
  count = "${length(var.iam_groups_list)}"
  name = "${element(var.iam_groups_list, count.index)}"
}

# -- IAM Groups Policies
# ------------------------------------------------------------------------------------------------ 
# -- Admin
resource "aws_iam_group_policy_attachment" "admin" {
  group      = "${var.iam_groups_list[0]}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  depends_on = [ "aws_iam_group.iam_groups"]
}

# -- Readonly
resource "aws_iam_group_policy_attachment" "readonly" {
  group      = "${var.iam_groups_list[1]}"
  policy_arn = "${aws_iam_policy.readonly_policy.arn}"

  depends_on = [ "aws_iam_group.iam_groups"]
}
