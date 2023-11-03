resource "google_sql_database_instance" "ref" {
  name             = "ref"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main.self_link
      require_ssl     = false
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "food" {
  name      = var.db.database_name
  instance  = google_sql_database_instance.ref.name
  charset   = var.db.charset
  collation = var.db.collation
}

resource "google_sql_user" "main" {
  name     = var.run.env_vars.DB_USER
  instance = google_sql_database_instance.ref.name
  password = var.run.env_vars.DB_PWD
}
