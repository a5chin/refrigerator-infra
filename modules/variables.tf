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
        set(string), [
          # TODO: decrese authority
          "roles/editor",
        ]
      )
    })
    image              = string
    max_instance_count = optional(number, 1)
    min_instance_count = optional(number, 0)
    name               = string
    env_vars = object({
      HOSTNAME   = string
      DB_USER    = string
      DB_PWD     = string
      DB_NAME    = string
      DB_TCPHOST = string
      DB_PORT    = number
    })
  })
}

variable "db" {
  description = "Settings for the Cloud SQL"
  type = object({
    instance_name = string
    database_name = optional(string, "ingredients")
    version       = optional(string, "db-f1-micro")
    charset       = optional(string, "utf8mb4")
    collation     = optional(string, "utf8mb4_unicode_ci")
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

variable "github" {
  description = "Settings for GitHub"
  type = object({
    sa = object({
      id    = string
      roles = set(string)
    })
  })
}
