# reos_nginx_demo_clean_tf

cd terraform-azure-nginx  
terraform init  
terraform plan  
terraform apply  


# Optimized Folder Structure for TF 
```
terraform-azure-nginx/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── files
│   └── cloud-init.yaml
└── modules
    ├── network
    │   └── main.tf
    └── compute
        └── main.tf
```
# Top-Level Calrirty (Root Module)
```
terraform-azure-nginx/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
```
| File           | Purpose                                                   | Why it’s good                                                                              |
| -------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `providers.tf` | Declares Terraform + provider versions                    | Keeps provider and versioning logic separate — easy upgrades, no merge conflicts           |
| `variables.tf` | Defines all root-level inputs                             | Provides clear interface for what users can configure (like function parameters)           |
| `main.tf`      | Calls submodules + global resources (e.g. Resource Group) | Makes the “architecture map” obvious — you see the big picture at a glance                 |
| `outputs.tf`   | Defines what’s exported                                   | Enables other Terraform stacks (or CI/CD pipelines) to consume this infrastructure cleanly |

# modules/ Folder - Reusable Building Blocks
```
modules/
├── network/
│   └── main.tf
└── compute/
    └── main.tf
```
Each subfolder is a module — a self-contained “lego block” that you can reuse in other projects.

| Aspect      | Flat Code                            | Modular Code                                                         |
| ----------- | ------------------------------------ | -------------------------------------------------------------------- |
| Reusability | You have to copy-paste entire blocks | You can just `source = "../modules/network"` anywhere                |
| Isolation   | Changes can break everything         | Changes are scoped to one module                                     |
| Testing     | Hard to test individual parts        | You can test modules separately with `terraform plan` in that folder |
| Complexity  | All resources in one big file        | Separation by concern — “network”, “compute”, “storage”, etc.        |

In a greenfield project, this pattern lets you grow organically:
add modules/security, modules/monitoring, or modules/storage later
version and reuse them across environments (dev, staging, prod)

# files/ Folder - Keep Static Assets Out of Code
```
files/
└── cloud-init.yaml
```
YAML or bash scripts sitting inside your .tf files

Externalizing:   
Readability: YAML indentation and color-coding stay intact.  
Versioning: Git diffs show changes in configuration scripts clearly.  
Maintainability: You can test or run the file outside Terraform.  
Security: Sensitive or lengthy bootstrap data can be separated, or even encrypted.i  
Terraform loads it via file("files/cloud-init.yaml"), keeping your .tf logic clean.  

# Separation for a Clean Workflow

| Goal                | How this structure helps                                                 |
| ------------------- | ------------------------------------------------------------------------ |
| **Readability**     | Each file has one purpose — new engineers understand it fast             |
| **Maintainability** | Easier to update modules independently (e.g., swap VM image, change NSG) |
| **Scalability**     | You can add environments (`dev`, `prod`) or workspaces easily            |
| **Reusability**     | Modules can be shared across projects or published to a registry         |
| **Automation**      | CI/CD pipelines (like your GitHub Actions) can apply consistent patterns |
| **Drift isolation** | Each module’s state and resources are logically grouped                  |

# GitHub Actions Pipeline 

.github/workflows/terraform-deply.yml  
on push to main → deploys your latest Terraform (new VM, updated NSG, etc.)  
on PR → runs terraform plan only (so you can see what would change)  
on schedule → re-applies once a day, good for “greenfield but evolving” setups  
uses your repo root → so it picks up:  
main.tf (resource group + modules)  
modules/network  
modules/compute  
files/cloud-init.yaml  

Required GitHub secrets:  
Set these in Repo → Settings → Secrets and variables → Actions:  
AZURE_CLIENT_ID  
AZURE_TENANT_ID  
AZURE_SUBSCRIPTION_ID  
TF_SSH_PUBLIC_KEY → put your public key here, e.g. contents of ~/.ssh/id_rsa.pub   
