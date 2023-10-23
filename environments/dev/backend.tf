terraform {
  backend "gcs" {
    bucket = "refrigerator-tfstate"
  }
}
