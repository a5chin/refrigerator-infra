resource "google_sql_database_instance" "ref" {
  name             = "ref"
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }

  deletion_protection = "false"
}

resource "google_sql_database" "food" {
  name      = var.db.database_name
  instance  = google_sql_database_instance.ref.name
  charset   = "UTF8"
  collation = "en_US.UTF8"
}

resource "google_sql_user" "iam_service_account_user" {
  name     = trimsuffix(google_service_account.run_executor.email, ".gserviceaccount.com")
  instance = google_sql_database_instance.ref.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}
