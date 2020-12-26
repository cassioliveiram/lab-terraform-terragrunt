locals {


  count_app_criticality   = var.app_criticality == "" ? 0 : 1
  count_app_contact_email = var.app_contact_email == "" ? 0 : 1
  count_app_cost_center   = var.app_cost_center == "" ? 0 : 1
  count_app_owner   = var.app_owner == "" ? 0 : 1



  tag_owner           = min(local.count_app_owner, local.count_app_contact_email) == 0 ? {} : { Owner = format("Name:%s+Contact:%s", var.name, var.app_contact_email) }
  tag_cost_management = min(local.count_app_cost_center) == 0 ? {} : { CostManagement = "${var.app_cost_center}" }

  tags = merge(
  { Name = var.name },
  { Environment = lower(var.environment) },
  local.tag_owner,
  local.tag_cost_management,
  var.custom_tags,
  )
}

resource "null_resource" "values" {
  triggers = {
    tags_hash = sha256(jsonencode(local.tags))
  }
}
