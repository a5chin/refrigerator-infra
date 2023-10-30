terraform {
  backend "gcs" {
    bucket = "refrigerator-tfstate"
    prefix = "shared"
  }
}
