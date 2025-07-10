# GitHub Actions + AWS OIDC Integration

Secure AWS access for GitHub Actions without storing secrets. Uses OpenID Connect (OIDC) for temporary credential generation.

## 🎯 What This Does

- GitHub Actions assumes AWS IAM Role directly
- No AWS secrets stored in GitHub
- Temporary credentials auto-expire after 1 hour
- Full AWS access through assumed role

## 🚀 Quick Setup

### 1. AWS Configuration

**Create OIDC Provider:**
```bash
# In AWS Console: IAM → Identity Providers → Add Provider
Provider Type: OpenID Connect
Provider URL: https://token.actions.githubusercontent.com
Audience: sts.amazonaws.com
```

**Create IAM Role:**
```bash
# In AWS Console: IAM → Roles → Create Role
Trusted Entity: Web Identity
Identity Provider: [Select created OIDC provider]
Audience: sts.amazonaws.com
Policy: AdministratorAccess
Role Name: GitHubActionsAdminRole
```

**Trust Policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::YOUR_ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR_USERNAME/YOUR_REPO:*"
        }
      }
    }
  ]
}
```

### 2. GitHub Actions Workflow

`.github/workflows/deploy.yml`:
```yaml
name: Deploy EC2 via GitHub Actions with OIDC

# When should this workflow run?
on:
  workflow_dispatch:  # Allows manual trigger from GitHub UI

# Define the job
jobs:
  deploy:
    runs-on: ubuntu-latest  # Use Ubuntu virtual machine
    
    # CRITICAL: These permissions are required for OIDC
    permissions:
      id-token: write    # Allows requesting OIDC token
      contents: read     # Allows reading repository contents
    
    steps:
      # Step 1: Get the code
      - name: Checkout code
        uses: actions/checkout@v4
      
      # Step 2: Get AWS credentials using OIDC (THE MAGIC HAPPENS HERE)
      - name: Configure AWS credentials using OIDC
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: arn:aws:iam::<Account-id>:role/<Role-Name>
          aws-region: us-east-1
      
      # Step 3: Use AWS CLI with the temporary credentials
      - name: Launch EC2 instance
        run: |
          echo "Launching EC2 instance..."
          aws ec2 run-instances \
            --image-id ami-0c02fb55956c7d316 \
            --count 1 \
            --instance-type t2.micro \
            --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=GitHubOIDCTest}]' \
            --key-name <key-pair-name> \
            --security-groups default
            
  ```
### Replace these placeholders

Replace the following placeholders in your GitHub Actions workflow file:

| Placeholder              | Replace with                                                                 |
|--------------------------|------------------------------------------------------------------------------|
| `<Account-id>`      | Your AWS Account ID (e.g. `123456789012`)                                   |
| `<Role-Name>`       | Name of the IAM Role you created (e.g. `GitHubActionsAdminRole`)            |
| `key-pair-name`     | Name of an EC2 Key Pair already created in AWS                              |
| `ami-0c02fb55956c7d316`  | Amazon Linux 2 AMI for `us-east-1` (can be used as-is if your region matches) |

## 🔧 Key Components

| Component | Purpose |
|-----------|---------|
| OIDC Provider | Establishes trust between GitHub and AWS |
| IAM Role | Defines AWS permissions for GitHub Actions |
| Trust Policy | Restricts access to specific repository |
| Workflow Permissions | Enables OIDC token generation |

## ⚠️ Important Notes

- **Permissions**: `id-token: write` and `contents: read` are required
- **Security**: Trust policy limits access to your specific repository
- **Credentials**: Temporary credentials expire automatically
- **Region**: Specify your preferred AWS region


## How It All Works Together

### The Flow
1. **You trigger the workflow** (manually or via push/PR)
2. **GitHub Actions starts** a virtual machine
3. **GitHub generates an OIDC token** containing workflow metadata
4. **AWS receives the token** and verifies it against the trust policy
5. **AWS provides temporary credentials** to the workflow
6. **Your workflow uses these credentials** to perform AWS operations
7. **Credentials automatically expire** after ~1 hour



## 🐛 Common Issues

| Error | Solution |
|-------|----------|
| "Unable to assume role" | Check role ARN and trust policy |
| "Token validation failed" | Verify `id-token: write` permission |
| "Access denied" | Ensure role has required AWS permissions |

## 🎉 Benefits

- ✅ No secrets management
- ✅ Automatic credential rotation
- ✅ Enhanced security
- ✅ Full audit trail
- ✅ Repository-specific access

## 📚 Additional Resources

### Official Documentation
- [AWS IAM OIDC Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)
- [GitHub Actions OIDC with AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [AWS Configure Credentials Action](https://github.com/aws-actions/configure-aws-credentials)


## 🌟 Explore More AWS Content

### 📖 **Related Reading**

Loved this secure integration guide? Take your AWS skills to the next level with cost monitoring and automation:

> 💰 **[How to Build an Automated AWS Resource Monitor](https://muhammadhabib.vercel.app/blog/how-to-build-an-automated-aws-resource-monitor)**  
> *Build a smart system that tracks your AWS resources and sends hourly notifications to prevent surprise bills*

**✨ What you'll learn:**
- 🔔 Automated email alerts for running resources
- 📊 Cost optimization strategies  
- ⚡ Lambda-powered monitoring system

---

<div align="center">
  <strong>Happy Reading & Building!</strong>
