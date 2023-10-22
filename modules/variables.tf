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
  type = object({
    executor = object({
      id = string
      roles = optional(
        list(string), [
          # TODO: decrese authority
          "roles/editor",
        ]
      )
    })
  })
}

variable "db" {
  description = "Settings for the Cloud SQL"
  type = object({
    instance_name = string
    database_name = optional(string, "ingredients")
    version       = optional(string, "db-f1-micro")
    tier          = optional(string, "UTF8")
    collation     = optional(string, "en_US.UTF8")
    executor = object({
      id = string
      roles = optional(
        list(string), [
          "roles/editor"
        ]
      )
    })
  })
}
