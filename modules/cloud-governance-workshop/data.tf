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

data "aws_iam_policy_document" "cgw-iam-policy-doc" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        join("", ["cgw-", random_string.unique-id.result])
      ]
    }
  }

  statement {
    actions = [
      "ec2:*"
    ]
    resources = [
      "arn:aws:ec2:*:*:instance/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Project"
      values = [
        join("", ["cgw-", random_string.unique-id.result])
      ]
    }
  }

  statement {
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/Project"
      values = [
        join("", ["cgw-", random_string.unique-id.result])
      ]
    }
  }

  statement {
    actions = [
      "iam:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:ResourceTag/Project"
      values = [
        join("", ["cgw-", random_string.unique-id.result])
      ]
    }
  }
}