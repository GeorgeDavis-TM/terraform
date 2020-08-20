data "azurerm_client_config" "current" {}

data "aws_iam_policy_document" "cgw-aws-sns-policy-doc" {
  statement {
    actions = [
      "sns:Publish"
    ]
    resources = [
      "${aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]}"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:sts::717210094962:assumed-role/setting-v1-us-west-2-lambdaRole/setting-v1-privateCreate"]
    }
  }

  statement {
    actions = [
      "sns:*"
    ]
    resources = [
      "${aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]}"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::666402644145:user/georged"]
    }
  }
}