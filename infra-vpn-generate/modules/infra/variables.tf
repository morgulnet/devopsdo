variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "dev_nat_ip" {
  description = "Dev network Nat ip address"
  type = string
}

variable "folder_id" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}
