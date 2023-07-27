data "aws_iam_policy_document" "iam_policy" {
  statement {
    sid       = "AllowEC2ReadAccess"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

module "iam" {
  source = "../.."

  policy      = data.aws_iam_policy_document.iam_policy.json
  policy_name = format("%s-iam-policy", var.name_prefix)
  role_name   = format("%s-iam-role", var.name_prefix)
  user_name   = format("%s-iam-user", var.name_prefix)
  create_user = true
  create_role = true

}