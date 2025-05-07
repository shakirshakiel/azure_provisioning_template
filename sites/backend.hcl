locals {
  prefix = "shakiel"
}

inputs = {
  resource_group_name  = "${local.prefix}-sample-rg"
  storage_account_name = "${local.prefix}terraformstates"
  container_name       = "template"
}