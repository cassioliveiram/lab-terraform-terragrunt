terraform {
  source =  "../../terraform-modules/autoscaling-group"
}

include {
  path = find_in_parent_folders()
}

dependency "tags" {
  config_path = "../tags"
}


inputs = {
  instance_type = "t3.micro"
  enable_monitoring = true
}