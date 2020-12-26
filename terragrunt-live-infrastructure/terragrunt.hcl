locals {
  commons_vars = read_terragrunt_config(find_in_parent_folders("commons.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))


  app_name = local.commons_vars.locals.name
  region   = local.region_vars.locals.region
}


# Configure Terragrunt to automatically store tfstate files in S3.
# The backend tf file is dynamically generate for each module.
remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    encrypt        = true
    region         = "us-west-2"
    bucket         = format("%s-live-infrastructure-state-storage", get_aws_account_id())
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    dynamodb_table = format("%s_live_infrastructure_terraform_locks", local.app_name)
  }
}

# Generate an AWS provider block.
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}

terraform {
  # Force Terraform to keep trying to acquire a lock for up to 20 minutes
  # if someone else already has the lock.
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
local.commons_vars.locals,
local.account_vars.locals,
local.region_vars.locals,
)