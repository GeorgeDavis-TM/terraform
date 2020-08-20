output "cgw-aws-uuid" {
  description = "Unique ID for the Resource Group"
  value       = random_string.unique-id.result
}

output "cgw-aws-instance-public-ip" {
  description = "Public IP of the EC2 Instance"
  value       = aws_instance.cgw-aws-instance.public_ip
  # value       = aws_eip.cgw-aws-instance-public-ip.public_ip
}

output "cgw-aws-instance-id" {
  description = "Instance ID of the EC2 Instance"
  value       = aws_instance.cgw-aws-instance.id
}

output "cgw-aws-vol" {
  description = "Volume ID of the EBS Volume"
  value       = aws_ebs_volume.cgw-aws-vol.id
}

output "cgw-aws-s3-bucket" {
  description = "Name of the S3 Bucket Name"
  value       = aws_s3_bucket.cgw-aws-s3-bucket.bucket_domain_name
}

output "cgw-aws-iam-user" {
  description = "Name of the IAM User"
  value       = aws_iam_user.cgw-aws-iam-user.name
}

output "cgw-aws-iam-user-password" {
  description = "AWS Console password of the IAM User"
  sensitive   = true
  value       = aws_iam_user_login_profile.cgw-aws-iam-user-login-profile.encrypted_password
}

output "cgw-aws-iam-role" {
  description = "Name of the IAM Role"
  value       = aws_iam_role.cgw-aws-iam-role.name
}

output "cgw-aws-iam-instance-profile" {
  description = "Name of the IAM Instance Profile"
  value       = aws_iam_instance_profile.cgw-aws-iam-instance-profile.name
}

output "cgw-aws-iam-policy" {
  description = "Name of the IAM Policy"
  value       = aws_iam_policy.cgw-aws-iam-policy.name
}

output "cgw-aws-ssh-sg" {
  description = "Name of the VPC Security Group"
  value       = aws_security_group.cgw-aws-ssh-sg.name
}

output "cgw-aws-cf-stack-arn" {
  description = "ARN of the Email SNS topic"
  value       = aws_cloudformation_stack.cgw-aws-sns.outputs["ARN"]
}