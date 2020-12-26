terraform {
  source =  "../../terraform-modules/tags"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name              = read_terragrunt_config(find_in_parent_folders("commons.hcl")).locals.name
  app_contact_email = "cassioliveiram@gmail.com"
  app_cost_center   = "laboratorio"
  app_owner         = "moreira-cassio"
  custom_tags = {
    CostSolution = "laboratorio"
    CostService = "aws"
  }
}