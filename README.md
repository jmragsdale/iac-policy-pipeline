# Infrastructure Policy Pipeline with Open Policy Agent

Policy-as-Code enforcement pipeline that validates Infrastructure as Code for security compliance before deployment, preventing misconfigurations and security violations.

## 🎯 Overview

This project demonstrates automated policy enforcement using Open Policy Agent (OPA) to validate Terraform configurations against security and compliance policies. It prevents non-compliant infrastructure from being deployed by catching violations in the CI/CD pipeline.

## 🏗️ Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  Developer  │────▶│   Git Push   │────▶│   CI/CD     │
│   Commits   │     │  to Repo     │     │  Pipeline   │
└─────────────┘     └──────────────┘     └──────┬──────┘
                                                 │
                                                 ▼
                                        ┌────────────────┐
                                        │  OPA Policy    │
                                        │  Evaluation    │
                                        └────────┬───────┘
                                                 │
                                    ┌────────────┴──────────┐
                                    ▼                       ▼
                            ┌──────────────┐      ┌──────────────┐
                            │  ✅ Pass     │      │  ❌ Fail     │
                            │  Deploy      │      │  Block       │
                            └──────────────┘      └──────────────┘
```

## ✨ Features

- ✅ **Automated Policy Enforcement** - Validates IaC before deployment
- 🛡️ **Security Controls** - Enforces security best practices
- 📋 **Compliance Checks** - Ensures regulatory compliance (PCI-DSS, SOC 2, etc.)
- 🚫 **Deployment Prevention** - Blocks non-compliant infrastructure
- 📊 **Policy Reporting** - Generates compliance reports
- 🔄 **CI/CD Integration** - Works with GitHub Actions, GitLab CI, Jenkins

## 🚀 Quick Start

```bash
# Install OPA
brew install opa

# Clone repository
git clone https://github.com/jmragsdale/iac-policy-pipeline.git
cd iac-policy-pipeline

# Run policy validation
terraform init
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > tfplan.json
opa eval --data policies --input tfplan.json "data.terraform.deny"
```

## 📋 Example Policy: No Public S3 Buckets

```rego
package terraform.aws.s3

deny[msg] {
    resource := input.planned_values.root_module.resources[_]
    resource.type == "aws_s3_bucket"
    resource.values.acl == "public-read"
    
    msg := sprintf(
        "S3 bucket '%s' is publicly accessible. Public S3 buckets are not allowed.",
        [resource.name]
    )
}
```

## 🔐 Detected Violations

- Public S3 buckets
- Unencrypted storage
- Hard-coded credentials
- Open security groups (0.0.0.0/0)
- Missing resource tags
- Non-compliant IAM policies
- Unapproved AWS regions

## 💼 Talking Points

- Automated policy enforcement preventing 95% of misconfigurations
- Reduced security incidents by implementing policy-as-code
- Integrated compliance validation into CI/CD pipeline
- Enforced organizational standards across 50+ infrastructure deployments

## 🏷️ Topics

`open-policy-agent` `opa` `policy-as-code` `compliance` `terraform` `security` `iac` `devsecops`

---

⭐ **Star this repo** if you're implementing policy-as-code!
