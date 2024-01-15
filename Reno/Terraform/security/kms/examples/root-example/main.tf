data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "default_policy" {
  statement {
    sid = "RootExampleKMSPolicy"

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }
}

module "kms" {
  source = "../.."

  alias_name = var.alias_name
  policy     = data.aws_iam_policy_document.default_policy.json
}