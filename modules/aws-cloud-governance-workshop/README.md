# Cloud Governance Workshop AWS Module

## Module Description

This module creates AWS resources in the following AWS services for the Cloud Governance workshop.

**Note:** These resources are :warning: **willfully misconfigured** :warning: to be used along with [Cloud One Conformity](https://cloudconformity.com) tool to understand how a CSPM would help resolve Cloud Security issues.

- Amazon EC2
- Amazon EBS
- Amazon S3
- Amazon ELB v2
- Amazon IAM User
- Amazon IAM Role
- Amazon IAM Instance Profile
- Amazon IAM Policy
- Amazon VPC Security Group
- Amazon KMS
- Amazon Lambda (WIP)
- Amazon RDS (WIP)


## Module Output

ID | Description
---|--------------
*cgw-uuid* | Unique ID for the Resource Group
*cgw-instance-public-ip* | Public IP of the EC2 Instance
*cgw-instance-id* | Instance ID of the EC2 Instance
*cgw-vol* | Volume ID of the EBS Volume
*cgw-s3-bucket* | Name of the S3 Bucket Name
*cgw-iam-user* | Name of the IAM User
*cgw-iam-user-password* | AWS Console password of the IAM User
*cgw-iam-role* | Name of the IAM Role
*cgw-iam-instance-profile* | Name of the IAM Instance Profile
*cgw-iam-policy* | Name of the IAM Policy
*cgw-ssh-sg* | Name of the VPC Security Group