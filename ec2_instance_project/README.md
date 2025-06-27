# AWS Infrastructure with Terraform and GitHub Actions

This repository contains Terraform configurations for provisioning AWS infrastructure, specifically EC2 instances, with automated CI/CD workflows using GitHub Actions.

## 🏗️ Architecture Overview

This project implements Infrastructure as Code (IaC) using Terraform to manage AWS resources. The workflow is triggered automatically when pull requests are created, ensuring infrastructure changes are validated before deployment.

## 📋 Prerequisites

Before using this project, ensure you have:

- AWS Account with appropriate permissions
- Terraform >= 1.0
- GitHub repository with Actions enabled
- AWS CLI configured (for local development)

## 🚀 Features

- **Automated Infrastructure Provisioning**: EC2 instance created via Terraform
- **CI/CD Pipeline**: GitHub Actions workflow for automated testing
- **Security**: AWS credentials managed through GitHub Secrets
- **Pull Request Validation**: Automatic `terraform plan` execution on PR creation
## ⚙️ Setup Instructions


### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/aws_terraform_infra.git
cd aws_terraform_infra
```

### 2. Configure GitHub Secrets

Navigate to your GitHub repository settings and add the following secrets:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `AWS_ACCESS_KEY_ID` | AWS Access Key ID | `AKIA...` |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION` | AWS Region for resources | `us-east-1` |




## 🔄 Workflow Process

### Automatic Trigger on Pull Request

1. **Create a Pull Request**: When you create a PR against the main branch
2. **GitHub Actions Trigger**: The workflow automatically starts
3. **Terraform Plan**: Executes `terraform plan` to show proposed changes
4. **Plan Review**: Review the plan output in the GitHub Actions logs
5. **Merge**: After approval, merge the PR to apply changes (if auto-apply is enabled)



## 🛠️ Local Development

### Initialize Terraform

```bash
cd terraform
terraform init
```

### Plan Changes

```bash
terraform plan
```

### Apply Changes (if needed)

```bash
terraform apply
```

### Destroy Resources

```bash
terraform destroy
```

## 📊 GitHub Actions Workflow

The workflow includes the following steps:

1. **Checkout Code**: Retrieves the latest code
2. **Setup Terraform**: Installs Terraform CLI
3. **Configure AWS Credentials**: Sets up AWS authentication
4. **Terraform Format Check**: Validates code formatting
5. **Terraform Init**: Initializes Terraform working directory
6. **Terraform Validate**: Validates configuration files
7. **Terraform Plan**: Generates execution plan
8. **Comment PR**: Posts plan results as PR comment

## 🔐 Security Best Practices

- AWS credentials are stored as GitHub Secrets (never in code)
- IAM roles follow least privilege principle
- Terraform state file is stored securely (consider using S3 backend)
- Security groups follow restrictive access patterns

## 📝 EC2 Configuration

The Terraform configuration creates:

- EC2 instance with specified AMI and instance type
- Security groups with defined ingress/egress rules
- Key pair association for SSH access
- Optional: Elastic IP assignment
- Optional: EBS volumes and attachments

## 🚨 Troubleshooting

### Common Issues

**Workflow fails with authentication error:**
- Verify AWS credentials in GitHub Secrets
- Check IAM permissions for the AWS user/role

**Terraform plan shows unexpected changes:**
- Check for manual changes made outside Terraform
- Review terraform.tfvars for correct values

**EC2 instance fails to launch:**
- Verify AMI ID is valid for the specified region
- Check subnet and security group configurations

### Debugging Steps

1. Check GitHub Actions logs for detailed error messages
2. Verify AWS credentials have necessary permissions
3. Ensure Terraform syntax is correct
4. Review AWS CloudTrail logs for API call details

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For questions or issues:

- Create an issue in this repository
- Check the [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- Review [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🔗 Useful Links

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

---

**Note**: Always review the Terraform plan output before applying changes to production environments. This README assumes you have basic knowledge of AWS, Terraform, and GitHub Actions.