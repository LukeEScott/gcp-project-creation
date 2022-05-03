variable "billing_account" {
  type = string

}

variable "emails" {
  type = list(string)
}

variable "access_expiry" {
  type        = string
  description = "In the format Year, Month, Day"
}
