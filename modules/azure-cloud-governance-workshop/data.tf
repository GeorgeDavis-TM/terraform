data "azurerm_client_config" "current" {}

data "aws_iam_policy_document" "cgw-aws-sns-policy-doc" {
  statement {
    sid = join("", ["CGWConformityCrossAccountRole", random_string.unique-id.result])
    actions = [
      "SNS:Publish"
    ]
    resources = [
      "${aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]}"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::717210094962:root"]
    }
  }

  statement {
    sid = join("", ["CGWSnsRole", random_string.unique-id.result])
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
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

data "azurerm_resource_group" "cgw-az-rg" {
  name = "CGW"
}

data "azuread_users" "cgw-az-owners" {
  user_principal_names = [
    "george_davis@trendmicro.com",
    "yama_saadat@trendmicro.com"
  ]
}