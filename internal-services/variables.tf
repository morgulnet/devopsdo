variable "token" {
  description = "Yandex.Cloud Token"
  type = string
}

variable "cloud_id" {
  description = "Cloud Id"
  type = string
}

variable "folder_id" {
  description = "Folder Id"
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_token" {
  type = string
}

variable "zone" {
  description = "Availability zone."
  type = string
  default = "ru-central1-a"
}
