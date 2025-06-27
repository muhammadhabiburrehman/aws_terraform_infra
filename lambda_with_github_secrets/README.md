# AWS Lambda with Secrets Manager Integration

This project demonstrates how to create AWS Lambda functions with secure secret management using AWS Secrets Manager and GitHub Actions CI/CD pipeline.

## 🏗️ Architecture Overview

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   GitHub Repo   │    │  GitHub Actions  │    │   AWS Cloud     │
│                 │    │                  │    │                 │
│ ┌─────────────┐ │    │ ┌──────────────┐ │    │ ┌─────────────┐ │
│ │ Terraform   │ │───▶│ │  Workflow    │ │───▶│ │   Lambda    │ │
│ │ Code        │ │    │ │  Pipeline    │ │    │ │  Function   │ │
│ └─────────────┘ │    │ └──────────────┘ │    │ └─────────────┘ │
│                 │    │                  │    │        │        │
│ ┌─────────────┐ │    │ ┌──────────────┐ │    │        ▼        │
│ │ GitHub      │ │◀───│ │   Secrets    │ │    │ ┌─────────────┐ │
│ │ Secrets     │ │    │ │ Sync Process │ │    │ │  Secrets    │ │
│ └─────────────┘ │    │ └──────────────┘ │    │ │  Manager    │ │
└─────────────────┘    └──────────────────┘    │ └─────────────┘ │
                                               └─────────────────┘
```

## 🎯 What This Project Does

1. **Creates AWS Lambda Function** using Terraform
2. **Stores secrets** in both GitHub Secrets and AWS Secrets Manager
3. **Synchronizes secrets** between GitHub and AWS automatically
4. **Deploys infrastructure** using GitHub Actions workflow
5. **Manages environment-specific configurations**

## 📋 Prerequisites

### Required Software
- [Terraform](https://www.terraform.io/downloads) (>= 1.0)
- [AWS CLI](https://aws.amazon.com/cli/) (>= 2.0)
- Git
- GitHub account with repository access

### Required Access
- AWS account with programmatic access
- GitHub repository with Actions enabled
- Appropriate IAM permissions for Lambda and Secrets Manager

## 🔐 Required Secrets Setup

### GitHub Secrets
Navigate to your repository → Settings → Secrets and Variables → Actions, then add:

```bash
# AWS Credentials
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_REGION=us-east-1

# Application Secrets (these will be synced to AWS Secrets Manager)
TF_VAR_my_secret=<any_value>
```

### AWS Secrets Manager
The workflow will automatically create and sync these secrets to AWS Secrets Manager.


## 🚀 Quick Start Guide

### Step 1: Clone and Setup
```bash
# Clone the repository
git clone https://github.com/your-username/aws_terraform_infra.git
cd aws_terraform_infra

# Switch to lambda-secrets branch
git checkout lambda-secrets-branch
```

### Step 2: Configure AWS Credentials
```bash
# Configure AWS CLI
aws configure
# OR export credentials
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
export AWS_DEFAULT_REGION=us-east-1
```

### Step 3: Setup GitHub Secrets
1. Go to repository Settings → Secrets and Variables → Actions
2. Add all required secrets listed above
3. Verify secrets are properly set

### Step 4: Review Terraform Configuration
```bash
# Navigate to terraform directory
cd terraform/

# Review and modify variables if needed
vim variables.tf

# Initialize Terraform
terraform init
```

### Step 5: Deploy Infrastructure

#### Option A: Automated Deployment (Recommended)
```bash
# Push changes to trigger GitHub Actions
git add .
git commit -m "Deploy lambda with secrets"
git push origin lambda-secrets-branch
```

#### Option B: Manual Deployment
```bash
# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## 🔄 GitHub Actions Workflow

The workflow automatically:
1. **Triggers** on push to the lambda-secrets branch
2. **Sets up** Terraform environment
3. **Syncs secrets** from GitHub to AWS Secrets Manager
4. **Plans** infrastructure changes
5. **Applies** changes to AWS
6. **Outputs** deployment status




### Workflow Failures
- Check GitHub Actions logs
- Verify all required secrets are set
- Ensure AWS credentials have sufficient permissions



## 🧹 Cleanup

### Destroy Infrastructure
```bash
# Using Terraform
terraform destroy

# Manual cleanup if needed
aws lambda delete-function --function-name your-function-name
aws secretsmanager delete-secret --secret-id your-secret-name --force-delete-without-recovery
```

## 📚 Additional Resources

- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda/)
- [AWS Secrets Manager Documentation](https://docs.aws.amazon.com/secretsmanager/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: Always review and test configurations in a non-production environment before deploying to production. Keep your secrets secure and never commit them to version control.