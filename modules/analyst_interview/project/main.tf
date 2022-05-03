resource "random_id" "id" {
  byte_length = 8
}

resource "google_project" "project" {
  name            = "interview-${random_id.id.hex}"
  project_id      = "interview-${random_id.id.hex}"
  billing_account = var.billing_account

  labels = {
    created_by = "terraform"
  }
}

resource "google_project_service" "iam" {
  project = google_project.project.id
  service = "iam.googleapis.com"

  depends_on = [google_project.project]
}

resource "google_project_service" "bigquery" {
  project                    = google_project.project.id
  service                    = "bigquery.googleapis.com"
  disable_dependent_services = true

  depends_on = [google_project.project]
}

resource "google_project_iam_member" "job_user" {
  for_each = toset(var.emails)
  project  = google_project.project.name
  role     = "roles/bigquery.jobUser"
  member   = "user:${each.value}"

  condition {
    title      = "expires_on_${var.access_expiry}"
    expression = "request.time < timestamp(\"${var.access_expiry}T00:00:00Z\")"
  }
}
