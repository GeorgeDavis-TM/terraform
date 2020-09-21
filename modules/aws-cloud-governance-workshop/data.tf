data "aws_ami" "ubuntu-1804" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["*ubuntu-bionic-*-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amzn-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_policy_document" "cgw-aws-iam-policy-doc" {
  statement {
    sid    = join("", ["CGWS3Role", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }

  statement {
    sid    = join("", ["CGWEc2Role", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }

  # statement {
  #   sid    = join("", ["CGWEc2Role2", random_string.unique-id.result])
  #   effect = "Allow"
  #   actions = [
  #     "ec2:*"
  #   ]
  #   resources = [
  #     "*"
  #   ]
  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:PrincipalTag/Project"
  #     values = [
  #       "cgw"
  #     ]
  #   }
  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:RequestedRegion"
  #     values = [
  #       "us-east-1"
  #     ]
  #   }
  # }

  # statement {
  #   sid    = join("", ["CGWDescribeRole", random_string.unique-id.result])
  #   effect = "Allow"
  #   actions = [
  #     "ec2:DescribeInstances",
  #     "s3:ListAllMyBuckets",
  #     "s3:ListBucket",
  #     "iam:ListRoles",
  #     "iam:ListPolicies",
  #     "iam:ListUsers",
  #     "sns:ListTopics",
  #     "sns:ListSubscriptions",
  #     "sns:ListPlatformApplications",
  #     "lambda:ListFunctions"
  #   ]
  #   resources = [
  #     "*"
  #   ]
  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:PrincipalTag/Project"
  #     values = [
  #       "cgw"
  #     ]
  #   }
  #   condition {
  #     test     = "StringEquals"
  #     variable = "aws:RequestedRegion"
  #     values = [
  #       "us-east-1"
  #     ]
  #   }
  # }

  statement {
    sid    = join("", ["CGWKmsRole", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }

  statement {
    sid    = join("", ["CGWIamRole", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "iam:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }

  statement {
    sid    = join("", ["CGWLambdaRole", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "lambda:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }

  statement {
    sid    = join("", ["CGWSnsRole", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "SNS:Publish"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/Team-UUID"
      values = [
        join("", ["cgw-aws-", random_string.unique-id.result])
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        "us-east-1"
      ]
    }
  }
}

data "aws_iam_policy_document" "cgw-aws-sns-policy-doc" {
  statement {
    sid    = join("", ["CGWConformityCrossAccountRole", random_string.unique-id.result])
    effect = "Allow"
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
    sid    = join("", ["CGWSnsRole", random_string.unique-id.result])
    effect = "Allow"
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

data "aws_iam_policy_document" "cgw-aws-lambda-sns-policy-doc" {
  statement {
    sid    = join("", ["CGWLambdaSnsServiceRole", random_string.unique-id.result])
    effect = "Allow"
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
  }

  statement {
    sid    = join("", ["CGWLambdaBasicExecutionRole", random_string.unique-id.result])
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

# data "aws_subnet_ids" "aws-subnet-by-az" {
#   vpc_id = "${var.defaultAwsVpcId}"
# }