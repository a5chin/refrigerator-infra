project_id = "dena-ai-sandbox-28-gcp"
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
