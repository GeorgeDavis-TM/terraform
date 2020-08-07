# Cloud Governance Workshop Azure Module

## Module Description

This module creates Azure resources in the following Azure services for the Cloud Governance workshop.

**Note:** These resources are :warning: **willfully misconfigured** :warning: to be used along with [Cloud One Conformity](https://cloudconformity.com) tool to understand how a CSPM would help resolve Cloud Security issues.

- Azure Virtual Machines
- Azure Block Storage
- Azure Blob Storage
- Azure LB (Unchecked)
- ~~Azure IAM User~~
- ~~Azure IAM Role~~
- ~~Azure IAM Instance Profile~~
- ~~Azure IAM Policy~~
- Azure Network Security Group
- Azure Key Vault
- Azure Functions (WIP)
- Azure MySQL (WIP)
- Azure App Service (WIP)


## Module Output

ID | Description
---|--------------
*cgw-az-uuid* | Unique ID for the Resource Group 
*cgw-az-public-ip* | Public IP of the Azure VM Instance 
*cgw-az-nic* | Network Interface ID of the Azure VM Instance 
*cgw-az-vm* | VM ID of the Azure VM Instance 
*cgw-az-sc* | Storage Container ID of the Azure Blob Storage 
*cgw-az-ssh-sg* | Name of the Azure Network Security Group