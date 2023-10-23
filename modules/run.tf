resource "google_service_account" "run_executor" {
  project      = var.project_id
  account_id   = var.run.executor.id
  display_name = "Cloud Run custom Service Account"
}
