module "project_creation" {
  source = "../../modules/analyst_interview/project"

  billing_account = var.billing_account
  emails          = var.emails
  access_expiry   = var.access_expiry
}
