###############################################################################
# Root: main.tf
# - Composes the stack by calling reusable modules.
# - Renders the Hello World HTML from files/index.html.tpl, injecting the stage.
###############################################################################

# Company-standard tagging (extend to your policy as needed)
locals {
  common_tags = {
    project   = var.project_name
    env       = var.stage
    managedBy = "terraform"
  }

  # Render the HTML file once per plan/apply using the template in /files.
  rendered_index_html = templatefile("${path.module}/files/index.html.tpl", {
    project_name = var.project_name
    stage        = var.stage
  })

  # Pass as base64 to avoid shell quoting pitfalls when echoing multi-line HTML.
  rendered_index_html_b64 = base64encode(local.rendered_index_html)
}

# Resource Group (reusable module)
module "rg" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Container Group (nginx on ACI)
module "nginx" {
  source              = "./modules/container_group"
  name                = "${var.project_name}-aci-${var.stage}"
  location            = var.location
  resource_group_name = module.rg.name

  dns_name_label  = var.dns_name_label
  container_image = var.container_image
  container_cpu   = var.container_cpu
  container_memory = var.container_memory

  # merge stage into the environment variables (caller-provided vars take precedence)
  container_env_vars = merge(
    {
      STAGE     = var.stage
      APP_NAME  = "nginx-hello-world"
      # Provide a minimal default; override per env in tfvars
      LOG_LEVEL = var.stage == "prod" ? "error" : "debug"
    },
    var.container_env_vars
  )

  # Provide the pre-rendered HTML as base64 to the module
  index_html_base64 = local.rendered_index_html_b64

  # Tags for the container group resource
  tags = local.common_tags
}
