project_id = "secrets"
location   = "us-central1"

run = {
  executor = {
    id = "refrigerator-sa-dev"
  }
}

db = {
  instance_name = "ref-dev"
  executor = {
    id = "db-sa-dev"
  }
}
