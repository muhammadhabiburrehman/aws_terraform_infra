# ECR with Terraform Pipeline Project 🐳

[![Terraform](https://img.shields.io/badge/Terraform-v1.0+-7C3AED?style=flat&logo=terraform)](https://terraform.io)
[![AWS ECR](https://img.shields.io/badge/AWS-ECR-FF9900?style=flat&logo=amazon-aws)](https://aws.amazon.com/ecr/)
[![Docker](https://img.shields.io/badge/Docker-Container-2496ED?style=flat&logo=docker)](https://docker.com)

This project demonstrates how to create and manage an Amazon Elastic Container Registry (ECR) using Terraform with automated CI/CD pipeline integration. The pipeline automatically builds Docker images, pushes them to ECR, and manages the infrastructure lifecycle.

## 📋 Project Overview

### What You'll Learn
- Creating AWS ECR repositories with Terraform
- Implementing CI/CD pipelines for container deployments
- Managing Docker image lifecycle
- Terraform state management
- GitHub Actions integration with AWS services

### What Gets Created
- **AWS ECR Repository** - Private container registry
- **IAM Roles & Policies** - Secure access management
- **GitHub Actions Workflow** - Automated CI/CD pipeline
- **Docker Images** - Containerized applications

## 🏗️ Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   Developer     │────▶│  GitHub Actions  │────▶│   AWS ECR       │
│   (Git Push)    │     │   (CI/CD)        │     │  (Container     │
└─────────────────┘     └──────────────────┘     │   Registry)     │
                                 │                └─────────────────┘
                                 ▼
                        ┌──────────────────┐
                        │   Terraform      │
                        │   (IaC)          │
                        └──────────────────┘
```

## 🚀 Getting Started

### Prerequisites

#### Required Tools
```bash
# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Docker
sudo apt-get update
sudo apt-get install docker.io
sudo usermod -aG docker $USER
```

#### AWS Account Setup
1. **Create IAM User** with the following policies:
   - `AmazonEC2ContainerRegistryFullAccess`
   - `IAMFullAccess` (for creating service roles)
   - `AmazonS3FullAccess` (for Terraform state)

2. **Configure AWS CLI:**
```bash
aws configure
AWS Access Key ID: YOUR_ACCESS_KEY
AWS Secret Access Key: YOUR_SECRET_KEY
Default region name: us-east-1
Default output format: json
```

### 🔧 Project Setup

#### Clone and Switch Branch
```bash
git clone https://github.com/YOUR_USERNAME/aws_terraform_infra.git
cd aws_terraform_infra
git checkout ecr-terraform-pipeline
```



## 🔧 GitHub Secrets Configuration

Set up the following secrets in your GitHub repository:

1. Go to `Settings` → `Secrets and variables` → `Actions`
2. Add the following secrets:

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `AWS_ACCESS_KEY_ID` | AWS Access Key | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Key | `wJalrXUt...` |

3. Add the following variables:

| Variable Name | Description | Example Value |
|---------------|-------------|---------------|
| `ECR_REPO_NAME` | ECR Repository Name | `my-app-repo` |
| `AWS_REGION` | AWS Region | `us-east-1` |

## 🚀 Deployment Steps

### 1. Deploy Infrastructure
```bash
# Initialize Terraform
cd terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

### 2. Build and Push Docker Image
```bash
# Get ECR login token
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

# Build and tag image
cd docker
docker build -t my-app-repo:latest .
docker tag my-app-repo:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:latest

# Push image
docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/my-app-repo:latest
```

### 3. Verify Deployment
```bash
# Check ECR repository
aws ecr describe-repositories --repository-names my-app-repo

# List images
aws ecr list-images --repository-name my-app-repo

# Get image details
aws ecr describe-images --repository-name my-app-repo
```


## 🎯 Next Steps

After completing this project, consider:

1. **Implement Blue-Green Deployments**
   - Use multiple ECR repositories
   - Implement traffic switching logic

2. **Add Container Orchestration**
   - Deploy to ECS/EKS
   - Implement service discovery

3. **Enhance Monitoring**
   - Add CloudWatch metrics
   - Implement alerting

4. **Implement GitOps**
   - Use ArgoCD or Flux
   - Automated deployments

## 📖 Resources

### Documentation
- [Amazon ECR User Guide](https://docs.aws.amazon.com/ecr/)
- [Terraform AWS Provider ECR](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

### Tools
- [ECR Credential Helper](https://github.com/awslabs/amazon-ecr-credential-helper)
- [Dive - Docker Image Explorer](https://github.com/wagoodman/dive)
- [Hadolint - Dockerfile Linter](https://github.com/hadolint/hadolint)
