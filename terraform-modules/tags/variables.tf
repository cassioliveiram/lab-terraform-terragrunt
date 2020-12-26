variable "name" {
  description = "Application Name."
}

variable "environment" {
  description = "Application Environment."
  default     = "Dev"
}

variable "custom_tags" {
  description = "Map containing custom application tags."
  default     = {}
  type        = map(string)
}

variable "app_contact_email" {
  description = "Mandatory for infrastructure-enabled accounts."
  default     = ""
}

variable "app_cost_center" {
  description = "Mandatory for infrastructure-enabled accounts."
  default     = ""
}

variable "app_criticality" {
  description = "Mandatory for infrastructure-enabled accounts."
  default     = ""
}

variable "app_owner" {
  description = "Application Owner"
}
