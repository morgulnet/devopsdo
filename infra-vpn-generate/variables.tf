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

variable "dev_nat_ip" {
  description = "Dev network Nat ip address"
  type = string
  default = "192.168.101.101"
}

variable "internal_svc_ip" {
  type        = string
  default     = "192.168.111.21"
}
