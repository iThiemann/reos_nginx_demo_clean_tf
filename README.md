# reos_nginx_demo_clean_tf

# Optimized Folder Structure for TF 

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

# Top-Level Calrirty (Root Module)

terraform-azure-nginx/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf


| File           | Purpose                                                   | Why it’s good                                                                              |
| -------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| `providers.tf` | Declares Terraform + provider versions                    | Keeps provider and versioning logic separate — easy upgrades, no merge conflicts           |
| `variables.tf` | Defines all root-level inputs                             | Provides clear interface for what users can configure (like function parameters)           |
| `main.tf`      | Calls submodules + global resources (e.g. Resource Group) | Makes the “architecture map” obvious — you see the big picture at a glance                 |
| `outputs.tf`   | Defines what’s exported                                   | Enables other Terraform stacks (or CI/CD pipelines) to consume this infrastructure cleanly |

