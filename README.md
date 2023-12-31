# Azure.Terraform

## Cheat Sheet
```bash
# Initialize terraform envionment
terraform init

# Validate terraform configuration
terraform validate

# Plan terraform configuration
terraform plan -out tf.plan -var-file="parameters.staging.tfvars"

# Apply terraform configuration
terraform apply tf.plan
```

### References
[Github Example](https://github.com/Azure-Samples/terraform-github-actions)
[Azure Docs](https://learn.microsoft.com/en-us/devops/deliver/iac-github-actions)