resource "google_cloud_run_v2_service" "main" {
  name     = var.run.name
  location = var.location

  template {
    scaling {
      max_instance_count = var.run.max_instance_count
      min_instance_count = var.run.min_instance_count
    }

    vpc_access {
      connector = google_vpc_access_connector.main.id
      egress    = "PRIVATE_RANGES_ONLY"
    }

    service_account = google_service_account.run_executor.email

    containers {
      image = var.run.image

      dynamic "env" {
        for_each = var.run.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }
}

resource "google_service_account" "run_executor" {
  project      = var.project_id
  account_id   = var.run.executor.id
  display_name = "Cloud Run custom Service Account"
}

resource "google_cloud_run_v2_service_iam_member" "member" {
  for_each = var.run.executor.roles
  project  = google_cloud_run_v2_service.main.project
  location = google_cloud_run_v2_service.main.location
  name     = google_cloud_run_v2_service.main.name
  role     = each.value
  member   = "serviceAccount:${google_service_account.run_executor.email}"
}
