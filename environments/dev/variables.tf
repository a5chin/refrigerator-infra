variable "project_id" {
  description = "The ID of Google Cloud Platform"
  type        = string
}

variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "run" {
  description = "Settings for the Cloud Run"
}

variable "db" {
  description = "Settings for the Cloud SQL"
}
