variable "zone" {
  description = "Availability zone"
  type = string
  default = "ru-central1-a"
}

variable "dev_nat_ip" {
  description = "Dev network Nat ip address"
  type = string
}
