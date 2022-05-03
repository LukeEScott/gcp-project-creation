
module "example" {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account

  emails        = ["joebloggs@gmail.com"]
  access_expiry = "2021-08-14"
}


module "example1" {
  source = "./modules/analyst_interview"

  billing_account = var.billing_account

  emails        = ["joebloggs@gmail.com"]
  access_expiry = "2021-08-14"
}