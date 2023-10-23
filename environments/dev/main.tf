module "refrigerator" {
  source = "../../modules"

  project_id = var.project_id
  location   = var.location

  run = var.run
  db  = var.db
}
