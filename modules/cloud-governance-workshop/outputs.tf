output "cgw-uuid" {
  description = "Unique ID for the Resource Group"
  value       = random_string.unique-id.result
}

output "cgw-instance-public-ip" {
  description = "Public IP of the EC2 Instance"
  value       = aws_instance.cgw-instance.public_ip
  # value       = aws_eip.cgw-instance-public-ip.public_ip
}

output "cgw-instance-id" {
  description = "Instance ID of the EC2 Instance"
  value       = aws_instance.cgw-instance.id
}

output "cgw-vol" {
  description = "Volume ID of the EBS Volume"
  value       = aws_ebs_volume.cgw-vol.id
}

output "cgw-s3-bucket" {
  description = "Name of the S3 Bucket Name"
  value       = aws_s3_bucket.cgw-s3-bucket.bucket_domain_name
}

output "cgw-iam-user" {
  description = "Name of the IAM User"
  value       = aws_iam_user.cgw-iam-user.name
}

output "cgw-iam-user-password" {
  description = "AWS Console password of the IAM User"
  value       = aws_iam_user_login_profile.cgw-iam-user-login-profile.encrypted_password
}

output "cgw-iam-role" {
  description = "Name of the IAM Role"
  value       = aws_iam_role.cgw-iam-role.name
}

output "cgw-iam-instance-profile" {
  description = "Name of the IAM Instance Profile"
  value       = aws_iam_instance_profile.cgw-iam-instance-profile.name
}

output "cgw-iam-policy" {
  description = "Name of the IAM Policy"
  value       = aws_iam_policy.cgw-iam-policy.name
}

output "cgw-ssh-sg" {
  description = "Name of the VPC Security Group"
  value       = aws_security_group.cgw-ssh-sg.name
}