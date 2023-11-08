resource "google_service_account" "github" {
  project      = var.project_id
  account_id   = var.github.sa.id
  display_name = "Service Account for GitHub"
}

resource "google_project_iam_custom_role" "github" {
  role_id     = "github"
  title       = "GitHub Role"
  description = "Allows a principal to GitHub for Build and Deploy"
  permissions = var.github.sa.roles
}

resource "google_project_iam_member" "github" {
  project  = var.project_id
  role     = google_project_iam_custom_role.github.name
  member   = "serviceAccount:${google_service_account.github.email}"
}
