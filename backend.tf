provider "google" {
  region = "eu-west2"
}

terraform {
  backend "gcs" {
    bucket = "test-actions-bucket"
    prefix = "terraform/state"
  }
}