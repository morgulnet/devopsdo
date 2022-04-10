variable "folder_id" {
  type = string
}

variable "sa_name" {
  type = string
  description = "Service account name"
}

variable "bucket_names" {
  type = list(string)
}

variable "force_destroy" {
  type = bool
  default = false
}

variable "permissions" {
  type = list(
    object({
    user = string
    permission = list(string)
    })
  )
}
